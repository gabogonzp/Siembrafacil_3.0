import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:intl/intl.dart';

// --- Data Models for Open-Meteo API ---

// Data model for current weather.
class WeatherData {
  final double temperature;
  final double humidity;
  final double windSpeed;
  final int? weatherCode; // Made nullable to handle potential nulls from API
  final String locationName;
  final DateTime time;

  WeatherData({
    required this.temperature,
    required this.humidity,
    required this.windSpeed,
    required this.weatherCode,
    required this.locationName,
    required this.time,
  });

  // A factory constructor to parse the JSON response for current weather.
  factory WeatherData.fromJson(Map<String, dynamic> json, String location) {
    return WeatherData(
      temperature: json['temperature_2m'].toDouble(),
      humidity: json['relative_humidity_2m'].toDouble(),
      windSpeed: json['wind_speed_10m'].toDouble(),
      // Use null-aware access and null coalescing to provide a default value (0).
      weatherCode: (json['weather_code'] as int?) ?? 0,
      locationName: location,
      time: DateTime.parse(json['time']),
    );
  }
}

// Data model for a single hourly forecast item.
class HourlyForecast {
  final DateTime time;
  final double temperature;
  final int? weatherCode; // Made nullable

  HourlyForecast({
    required this.time,
    required this.temperature,
    required this.weatherCode,
  });
}

// Data model for a single daily forecast item.
class DailyForecast {
  final DateTime date;
  final double minTemp;
  final double maxTemp;
  final int? weatherCode; // Made nullable

  DailyForecast({
    required this.date,
    required this.minTemp,
    required this.maxTemp,
    required this.weatherCode,
  });
}

// --- Weather Service for Open-Meteo API ---
class WeatherService {
  final String _baseUrl = 'https://api.open-meteo.com/v1/forecast';

  // Fetches a combined forecast with all required data.
  Future<Map<String, dynamic>> fetchAllWeatherData(
      double lat, double lon, String locationName) async {
    // We can simplify the API call since we no longer need the precipitation data.
    final url = '$_baseUrl?latitude=$lat&longitude=$lon&current=temperature_2m,relative_humidity_2m,wind_speed_10m,weather_code&hourly=temperature_2m,weather_code&daily=weather_code,temperature_2m_max,temperature_2m_min&timezone=auto&forecast_days=7';

    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        final currentWeather = WeatherData.fromJson(data['current'], locationName);

        final hourlyTimestamps = data['hourly']['time'] as List;
        final hourlyTemps = data['hourly']['temperature_2m'] as List;
        final hourlyCodes = data['hourly']['weather_code'] as List;
        final List<HourlyForecast> hourlyForecast = [];
        for (int i = 0; i < hourlyTimestamps.length && i < 8; i++) {
          hourlyForecast.add(HourlyForecast(
            time: DateTime.parse(hourlyTimestamps[i]),
            temperature: hourlyTemps[i].toDouble(),
            weatherCode: (hourlyCodes[i] as int?) ?? 0,
          ));
        }

        final dailyDates = data['daily']['time'] as List;
        final dailyMaxTemps = data['daily']['temperature_2m_max'] as List;
        final dailyMinTemps = data['daily']['temperature_2m_min'] as List;
        final dailyCodes = data['daily']['weather_code'] as List;
        final List<DailyForecast> dailyForecast = [];
        for (int i = 0; i < dailyDates.length; i++) {
          dailyForecast.add(DailyForecast(
            date: DateTime.parse(dailyDates[i]),
            maxTemp: dailyMaxTemps[i].toDouble(),
            minTemp: dailyMinTemps[i].toDouble(),
            weatherCode: (dailyCodes[i] as int?) ?? 0,
          ));
        }

        return {
          'current': currentWeather,
          'hourly': hourlyForecast,
          'daily': dailyForecast,
        };
      } else {
        throw Exception(
            'Failed to load weather data: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to fetch weather data: $e');
    }
  }
}

class WeatherTab extends StatefulWidget {
  const WeatherTab({super.key});

  @override
  State<WeatherTab> createState() => _WeatherTabState();
}

class _WeatherTabState extends State<WeatherTab> {
  late Future<Map<String, dynamic>> _weatherDataFuture;
  final WeatherService _weatherService = WeatherService();

  final double _lat = 18.4861;
  final double _lon = -69.9307;
  final String _locationName = 'Santo Domingo, DR';

  @override
  void initState() {
    super.initState();
    _fetchWeatherData();
  }

  Future<void> _fetchWeatherData() async {
    setState(() {
      _weatherDataFuture = _weatherService.fetchAllWeatherData(
        _lat,
        _lon,
        _locationName,
      );
    });
  }

  IconData _getWeatherIcon(int? code) {
    switch (code) {
      case 0:
        return Icons.wb_sunny;
      case 1:
      case 2:
      case 3:
        return Icons.cloud;
      case 45:
      case 48:
        return Icons.grain;
      case 51:
      case 53:
      case 55:
      case 56:
      case 57:
        return Icons.water_drop;
      case 61:
      case 63:
      case 65:
      case 66:
      case 67:
        return Icons.shower;
      case 71:
      case 73:
      case 75:
        return Icons.ac_unit;
      case 80:
      case 81:
      case 82:
        return Icons.thunderstorm;
      case 95:
        return Icons.storm;
      case 96:
      case 99:
        return Icons.thunderstorm;
      default:
        return Icons.help_outline;
    }
  }

  String _getWeatherDescription(int? code) {
    switch (code) {
      case 0:
        return 'Cielo despejado';
      case 1:
        return 'Mayormente despejado';
      case 2:
        return 'Parcialmente nublado';
      case 3:
        return 'Nublado';
      case 45:
      case 48:
        return 'Niebla';
      case 51:
      case 53:
      case 55:
        return 'Llovizna';
      case 56:
      case 57:
        return 'Llovizna helada';
      case 61:
      case 63:
      case 65:
        return 'Lluvia';
      case 66:
      case 67:
        return 'Lluvia helada';
      case 71:
      case 73:
      case 75:
        return 'Nevada';
      case 80:
      case 81:
      case 82:
        return 'Lluvias';
      case 95:
      case 96:
      case 99:
        return 'Tormenta';
      default:
        return 'Desconocido';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: FutureBuilder<Map<String, dynamic>>(
            future: _weatherDataFuture,
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
                final WeatherData currentWeather = snapshot.data!['current'];
                final List<HourlyForecast> hourlyForecast =
                    snapshot.data!['hourly'];
                final List<DailyForecast> dailyForecast =
                    snapshot.data!['daily'];

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Clima Actual',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        IconButton(
                          onPressed: _fetchWeatherData,
                          icon: const Icon(Icons.refresh),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    _buildCurrentWeatherCard(currentWeather),
                    const SizedBox(height: 24),
                    const Text(
                      'Alertas Agrícolas',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.orange[50],
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Colors.orange[200]!),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.warning,
                                color: Colors.orange[600],
                                size: 20,
                              ),
                              const SizedBox(width: 8),
                              Text(
                                'Alerta de Lluvia',
                                style: TextStyle(
                                  color: Colors.orange[800],
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Se esperan lluvias intensas mañana. Considera posponer la aplicación de fertilizantes y pesticidas.',
                            style: TextStyle(
                              color: Colors.orange[700],
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),
                    const Text(
                      'Pronóstico por Horas',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 12),
                    SizedBox(
                      height: 120,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: hourlyForecast.length,
                        itemBuilder: (context, index) {
                          return _buildHourlyForecastItem(hourlyForecast[index]);
                        },
                      ),
                    ),
                    const SizedBox(height: 24),
                    const Text(
                      'Pronóstico de 7 Días',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 12),
                    ...dailyForecast.map((forecast) {
                      return _buildDailyForecastItem(forecast);
                    }).toList(),
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

  Widget _buildCurrentWeatherCard(WeatherData data) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF4FC3F7), Color(0xFF29B6F6)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    data.locationName,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                  Text(
                    '${data.temperature.round()}°C',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 48,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    _getWeatherDescription(data.weatherCode),
                    style: const TextStyle(
                      color: Colors.white70,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
              Icon(
                _getWeatherIcon(data.weatherCode),
                color: Colors.white,
                size: 64,
              ),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildWeatherDetail(
                  'Humedad', '${data.humidity.round()}%', Icons.water_drop),
              _buildWeatherDetail(
                  'Viento', '${data.windSpeed.round()} km/h', Icons.air),
              _buildWeatherDetail('UV', '8', Icons.wb_sunny),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildHourlyForecastItem(HourlyForecast data) {
    final hourFormat = DateFormat('ha');
    return Container(
      width: 80,
      margin: const EdgeInsets.only(right: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Text(
            hourFormat.format(data.time),
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
          ),
          Icon(
            _getWeatherIcon(data.weatherCode),
            color: Colors.blue[600],
            size: 24,
          ),
          Text(
            '${data.temperature.round()}°',
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDailyForecastItem(DailyForecast data) {
    final dateFormat = DateFormat('EEEE', 'es');
    String day = dateFormat.format(data.date);
    day = day[0].toUpperCase() + day.substring(1);

    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          SizedBox(
            width: 80,
            child: Text(
              data.date.day == DateTime.now().day ? 'Hoy' : day,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Icon(
            _getWeatherIcon(data.weatherCode),
            color: Colors.blue[600],
            size: 24,
          ),
          const SizedBox(width: 16),
          // We have removed the precipitation icon and text here.
          Expanded(
            child: Container(), // Empty container to take up space.
          ),
          Text(
            '${data.minTemp.round()}° / ${data.maxTemp.round()}°',
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWeatherDetail(String label, String value, IconData icon) {
    return Column(
      children: [
        Icon(
          icon,
          color: Colors.white70,
          size: 20,
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 14,
          ),
        ),
        Text(
          label,
          style: const TextStyle(
            color: Colors.white70,
            fontSize: 12,
          ),
        ),
      ],
    );
  }
}
 