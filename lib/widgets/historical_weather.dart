import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:fl_chart/fl_chart.dart'; // Make sure to add this to your pubspec.yaml

// --- Data Models for Historical Open-Meteo API ---

// Data model for a single daily historical data point.
class HistoricalData {
  final DateTime date;
  final double precipitationSum;
  final int precipitationProbability;

  HistoricalData({
    required this.date,
    required this.precipitationSum,
    required this.precipitationProbability,
  });

  factory HistoricalData.fromJson(Map<String, dynamic> json, int index) {
    return HistoricalData(
      date: DateTime.parse(json['time'][index]),
      precipitationSum: json['precipitation_sum'][index].toDouble(),
      precipitationProbability: json['precipitation_probability'][index],
    );
  }
}

// --- Historical Weather Service ---
class HistoricalWeatherService {
  final String _baseUrl = 'https://archive-api.open-meteo.com/v1/archive';

  // Fetches historical data for a specific date range.
  Future<List<HistoricalData>> fetchHistoricalData(
      double lat, double lon, String startDate, String endDate) async {
    final url =
        '$_baseUrl?latitude=$lat&longitude=$lon&start_date=$startDate&end_date=$endDate&daily=precipitation_sum,precipitation_probability&timezone=auto';

    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final dailyData = data['daily'];

        if (dailyData == null) {
          throw Exception('No historical daily data found.');
        }

        final List<HistoricalData> historicalData = [];
        for (int i = 0; i < dailyData['time'].length; i++) {
          historicalData.add(HistoricalData.fromJson(dailyData, i));
        }
        return historicalData;
      } else {
        throw Exception(
            'Failed to load historical data: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to fetch historical data: $e');
    }
  }
}

class HistoricalWeatherTab extends StatefulWidget {
  const HistoricalWeatherTab({super.key});

  @override
  State<HistoricalWeatherTab> createState() => _HistoricalWeatherTabState();
}

class _HistoricalWeatherTabState extends State<HistoricalWeatherTab> {
  late Future<List<HistoricalData>> _historicalDataFuture;
  final HistoricalWeatherService _weatherService = HistoricalWeatherService();
  final double _lat = 18.4861;
  final double _lon = -69.9307;

  @override
  void initState() {
    super.initState();
    _fetchHistoricalData();
  }

  // Fetches data for the last three full years
  void _fetchHistoricalData() {
    final now = DateTime.now();
    final startYear = now.year - 3;
    final endYear = now.year - 1;
    final startDate = '${startYear}-01-01';
    final endDate = '${endYear}-12-31';

    setState(() {
      _historicalDataFuture =
          _weatherService.fetchHistoricalData(_lat, _lon, startDate, endDate);
    });
  }

  // Processes the raw daily data into monthly averages for the chart.
  Map<int, double> _processData(List<HistoricalData> data) {
    Map<int, List<double>> monthlyPrecipitation = {};
    for (var d in data) {
      final month = d.date.month;
      if (!monthlyPrecipitation.containsKey(month)) {
        monthlyPrecipitation[month] = [];
      }
      monthlyPrecipitation[month]!.add(d.precipitationSum);
    }

    Map<int, double> monthlyAverage = {};
    monthlyPrecipitation.forEach((month, values) {
      monthlyAverage[month] =
          values.reduce((a, b) => a + b) / values.length;
    });

    return monthlyAverage;
  }

  // Generates a drought prediction based on historical patterns.
  String _getDroughtPrediction(Map<int, double> monthlyAverages) {
    if (monthlyAverages.isEmpty) {
      return 'No hay suficientes datos para generar una predicción.';
    }

    // Find the month with the lowest average precipitation.
    final driestMonth = monthlyAverages.entries
        .reduce((a, b) => a.value < b.value ? a : b);

    // Get the name of the month
    final monthName = DateFormat('MMMM', 'es').format(DateTime(2024, driestMonth.key));

    return 'Análisis de la Tendencia: Basado en los datos históricos de los últimos tres años, '
        'la tendencia muestra que los meses de **${monthName.toUpperCase()}** tienen consistentemente '
        'la menor precipitación. Se recomienda considerar este período como el de mayor riesgo '
        'de sequía. La planificación del riego y la conservación del agua deben ser prioritarias '
        'durante este tiempo para mitigar los efectos de un posible déficit hídrico.';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: FutureBuilder<List<HistoricalData>>(
            future: _historicalDataFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(
                  child: Text(
                    'Error: ${snapshot.error}',
                    style: const TextStyle(color: Colors.red),
                  ),
                );
              } else if (snapshot.hasData) {
                final processedData = _processData(snapshot.data!);
                final prediction = _getDroughtPrediction(processedData);

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Análisis de Lluvia Histórica (2022-2024)',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),
                    _buildPrecipitationGraph(processedData),
                    const SizedBox(height: 24),
                    const Text(
                      'Predicción de Sequía para 2025',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 12),
                    _buildPredictionCard(prediction),
                  ],
                );
              } else {
                return const SizedBox.shrink();
              }
            },
          ),
        ),
      ),
    );
  }

  Widget _buildPrecipitationGraph(Map<int, double> data) {
    final List<FlSpot> spots = [];
    data.forEach((month, avg) {
      spots.add(FlSpot(month.toDouble(), avg));
    });

    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SizedBox(
          height: 300,
          child: LineChart(
            LineChartData(
              gridData: const FlGridData(
                show: true,
                drawVerticalLine: true,
              ),
              titlesData: FlTitlesData(
                show: true,
                bottomTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    getTitlesWidget: (value, meta) {
                      const style = TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      );
                      String text;
                      switch (value.toInt()) {
                        case 1: text = 'Ene'; break;
                        case 2: text = 'Feb'; break;
                        case 3: text = 'Mar'; break;
                        case 4: text = 'Abr'; break;
                        case 5: text = 'May'; break;
                        case 6: text = 'Jun'; break;
                        case 7: text = 'Jul'; break;
                        case 8: text = 'Ago'; break;
                        case 9: text = 'Sep'; break;
                        case 10: text = 'Oct'; break;
                        case 11: text = 'Nov'; break;
                        case 12: text = 'Dic'; break;
                        default: text = ''; break;
                      }
                      return Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Text(text, style: style),
                      );
                    },
                    reservedSize: 28,
                  ),
                ),
                leftTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    getTitlesWidget: (value, meta) {
                      return Text('${value.toInt()} mm',
                          style: const TextStyle(fontSize: 10));
                    },
                    reservedSize: 36,
                  ),
                ),
                topTitles: const AxisTitles(
                  sideTitles: SideTitles(showTitles: false),
                ),
                rightTitles: const AxisTitles(
                  sideTitles: SideTitles(showTitles: false),
                ),
              ),
              borderData: FlBorderData(
                show: true,
                border: Border.all(
                  color: const Color(0xff37434d),
                  width: 1,
                ),
              ),
              lineBarsData: [
                LineChartBarData(
                  spots: spots,
                  isCurved: true,
                  color: Colors.blue,
                  barWidth: 3,
                  isStrokeCapRound: true,
                  dotData: const FlDotData(show: false),
                  belowBarData: BarAreaData(
                    show: true,
                    color: Colors.blue.withOpacity(0.3),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPredictionCard(String text) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.lightGreen[50],
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.lightGreen[200]!),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: Colors.lightGreen[800],
          fontSize: 14,
          height: 1.5,
        ),
      ),
    );
  }
}
