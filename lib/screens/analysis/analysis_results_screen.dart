import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import '../../widgets/soil_metric_card.dart';
import '../../services/app_state.dart';
import 'package:siembra_facil/models/soil_data.dart';

class AnalysisResultsScreen extends StatefulWidget {
  const AnalysisResultsScreen({super.key});

  @override
  _AnalysisResultsScreenState createState() => _AnalysisResultsScreenState();
}

class _AnalysisResultsScreenState extends State<AnalysisResultsScreen> {
  // State variable to hold the sensor data
  SensorData? _latestSensorData;
  // State variable to track the loading status
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    // Call the method to fetch the latest data point
    _fetchLatestSensorData();
  }

  // A method to fetch the latest data point just once.
  void _fetchLatestSensorData() async {
    // Reference the 'sensor_readings' path in your Firebase Realtime Database
    final ref = FirebaseDatabase.instance.ref('sensor_readings');

    try {
      // Get the latest data point just once to initially populate the screen.
      final snapshot = await ref.orderByChild('timestamp').limitToLast(1).get();

      if (snapshot.exists) {
        // The value from DataSnapshot is dynamic, which we safely get here.
        final dynamic snapshotValue = snapshot.value;

        // Step 1: Check if the value is a Map.
        if (snapshotValue is Map) {
          // Step 2: Explicitly cast the map to a more usable type.
          final Map<dynamic, dynamic> values = snapshotValue;

          if (values.isNotEmpty) {
            // Get the first (and only) key from the limited snapshot
            final latestEntryKey = values.keys.first;
            
            // Get the dynamic data for that key
            final dynamic latestEntryData = values[latestEntryKey];
            
            // Step 3: Check if the inner data is also a Map. This is the crucial, defensive check.
            if (latestEntryData is Map) {
              // Now get the nested 'data' map, which contains the sensor readings
              final dynamic rawData = latestEntryData['data'];
              final dynamic timestampData = latestEntryData['timestamp'];

              // Step 4: Check if the nested 'data' map exists and is a Map.
              if (rawData is Map) {
                // Step 5: Safely cast the nested map to a Map<String, dynamic>.
                final Map<String, dynamic> dataMap = rawData.cast<String, dynamic>();
                
                // Add the timestamp to the map for the SensorData.fromMap constructor
                // Use a default value of 0.0 if the timestamp is null.
                dataMap['timestamp'] = (timestampData is num) ? timestampData : 0.0;

                // Now we can safely pass the correctly typed map to our data model.
                setState(() {
                  _latestSensorData = SensorData.fromMap(dataMap);
                  _isLoading = false;
                });
              } else {
                // Handle the case where the inner 'data' is not a map
                print('Error: The "data" field is missing or is not a Map.');
                setState(() {
                  _latestSensorData = null;
                  _isLoading = false;
                });
              }
            } else {
              // Handle the case where the inner data is not a map
              print('Error: Inner data is not a Map.');
              setState(() {
                _latestSensorData = null;
                _isLoading = false;
              });
            }
          } else {
            // Handle the case where the map is empty
            setState(() {
              _latestSensorData = null;
              _isLoading = false;
            });
          }
        } else {
          // Handle the case where snapshot value is not a map
          print('Error: Snapshot value is not a Map.');
          setState(() {
            _latestSensorData = null;
            _isLoading = false;
          });
        }
      } else {
        // Handle the case where no initial data exists
        setState(() {
          _latestSensorData = null;
          _isLoading = false;
        });
      }
    } catch (error) {
      // Handle errors during initial data fetch
      print('Error fetching initial sensor data: $error');
      setState(() {
        _isLoading = false;
      });
    }
  }

  // Helper function to determine status and color based on value
  String _getMetricStatus(double value, String metric) {
    if (metric == 'pH') {
      if (value >= 6.0 && value <= 7.0) return 'Óptimo';
      if (value > 7.0) return 'Alcalino';
      if (value < 6.0) return 'Ácido';
    } else if (metric == 'Conductividad') {
      if (value >= 100 && value <= 1500) return 'Óptimo';
      if (value > 1500) return 'Alto';
      if (value < 100) return 'Bajo';
    }
    // Add more status logic here for N, P, K as needed
    return 'Óptimo'; // Default status for other metrics
  }

  Color _getMetricStatusColor(String status) {
    switch (status) {
      case 'Óptimo':
        return const Color(0xFF4CAF50);
      case 'Alcalino':
        return const Color(0xFFFBC02D);
      case 'Ácido':
        return const Color(0xFFFBC02D);
      case 'Alto':
        return const Color(0xFFFF9800);
      case 'Bajo':
        return const Color(0xFFFF9800);
      default:
        return const Color(0xFF4CAF50);
    }
  }

  @override
  void dispose() {
    // There is no subscription to cancel in this version, so this can be left empty or removed.
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Resultados del Análisis',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        backgroundColor: const Color(0xFF2E7D32),
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, '/recommendations');
            },
            icon: const Icon(Icons.lightbulb),
            tooltip: 'Ver Recomendaciones',
          ),
        ],
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFFF1F8E9),
              Colors.white,
            ],
          ),
        ),
        child: SafeArea(
          child: _isLoading
              ? const Center(child: CircularProgressIndicator(color: Color(0xFF2E7D32)))
              : SingleChildScrollView(
                  child: Column(
                    children: [
                      // Header Info
                      Container(
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          children: [
                            Text(
                              AppState.activeParcel?.name ?? 'Parcela',
                              style: const TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF2E7D32),
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              'Análisis realizado el ${_latestSensorData != null ? DateTime.fromMillisecondsSinceEpoch((_latestSensorData!.timestamp * 1000).toInt()).day.toString() : 'N/A'}/${_latestSensorData != null ? DateTime.fromMillisecondsSinceEpoch((_latestSensorData!.timestamp * 1000).toInt()).month.toString() : 'N/A'}/${_latestSensorData != null ? DateTime.fromMillisecondsSinceEpoch((_latestSensorData!.timestamp * 1000).toInt()).year.toString() : 'N/A'}',
                              style: const TextStyle(
                                fontSize: 16,
                                color: Color(0xFF666666),
                              ),
                            ),
                            const SizedBox(height: 16),

                            // Overall Status
                            Container(
                              padding: const EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                color: const Color(0xFF4CAF50).withOpacity(0.1),
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(
                                  color: const Color(0xFF4CAF50),
                                  width: 1,
                                ),
                              ),
                              child: const Row(
                                children: [
                                  Icon(
                                    Icons.check_circle,
                                    color: Color(0xFF4CAF50),
                                    size: 24,
                                  ),
                                  SizedBox(width: 12),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Estado General: Óptimo',
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                            color: Color(0xFF4CAF50),
                                          ),
                                        ),
                                        Text(
                                          'Las condiciones del suelo son favorables para el cultivo',
                                          style: TextStyle(
                                            fontSize: 14,
                                            color: Color(0xFF666666),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      
                      // Soil Metrics
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Métricas del Suelo',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF2E7D32),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: _latestSensorData != null
                          ? Column(
                              children: [
                                Row(
                                  children: [
                                    Expanded(
                                      child: SoilMetricCard(
                                        title: 'Temperatura',
                                        value: '${_latestSensorData!.temperature.toStringAsFixed(2)}°C',
                                        status: _getMetricStatus(_latestSensorData!.temperature, 'Temperatura'),
                                        icon: Icons.thermostat,
                                        statusColor: _getMetricStatusColor(_getMetricStatus(_latestSensorData!.temperature, 'Temperatura')),
                                      ),
                                    ),
                                    const SizedBox(width: 12),
                                    Expanded(
                                      child: SoilMetricCard(
                                        title: 'pH',
                                        value: _latestSensorData!.ph.toStringAsFixed(2),
                                        status: _getMetricStatus(_latestSensorData!.ph, 'pH'),
                                        icon: Icons.science,
                                        statusColor: _getMetricStatusColor(_getMetricStatus(_latestSensorData!.ph, 'pH')),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 12),
                                Row(
                                  children: [
                                    Expanded(
                                      child: SoilMetricCard(
                                        title: 'Conductividad',
                                        value: '${_latestSensorData!.ec.toStringAsFixed(2)} uS/cm',
                                        status: _getMetricStatus(_latestSensorData!.ec, 'Conductividad'),
                                        icon: Icons.electrical_services,
                                        statusColor: _getMetricStatusColor(_getMetricStatus(_latestSensorData!.ec, 'Conductividad')),
                                      ),
                                    ),
                                    const SizedBox(width: 12),
                                    Expanded(
                                      child: SoilMetricCard(
                                        title: 'Nitrógeno (N)',
                                        value: '${_latestSensorData!.nitrogen.toStringAsFixed(2)} mg/kg',
                                        status: _getMetricStatus(_latestSensorData!.nitrogen, 'Nitrógeno (N)'),
                                        icon: Icons.eco,
                                        statusColor: _getMetricStatusColor(_getMetricStatus(_latestSensorData!.nitrogen, 'Nitrógeno (N)')),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 12),
                                Row(
                                  children: [
                                    Expanded(
                                      child: SoilMetricCard(
                                        title: 'Fósforo (P)',
                                        value: '${_latestSensorData!.phosphorous.toStringAsFixed(2)} mg/kg',
                                        status: _getMetricStatus(_latestSensorData!.phosphorous, 'Fósforo (P)'),
                                        icon: Icons.eco,
                                        statusColor: _getMetricStatusColor(_getMetricStatus(_latestSensorData!.phosphorous, 'Fósforo (P)')),
                                      ),
                                    ),
                                    const SizedBox(width: 12),
                                    Expanded(
                                      child: SoilMetricCard(
                                        title: 'Potasio (K)',
                                        value: '${_latestSensorData!.potassium.toStringAsFixed(2)} mg/kg',
                                        status: _getMetricStatus(_latestSensorData!.potassium, 'Potasio (K)'),
                                        icon: Icons.eco,
                                        statusColor: _getMetricStatusColor(_getMetricStatus(_latestSensorData!.potassium, 'Potasio (K)')),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            )
                          : const Center(
                              child: Padding(
                                padding: EdgeInsets.all(20.0),
                                child: Text(
                                  'No se encontraron datos. Por favor, realiza un análisis para ver los resultados.',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Color(0xFF666666),
                                  ),
                                ),
                              ),
                            ),
                      ),
                      
                      const SizedBox(height: 30),
                      
                      // Action Buttons
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Column(
                          children: [
                            SizedBox(
                              width: double.infinity,
                              child: ElevatedButton.icon(
                                onPressed: () {
                                  Navigator.pushNamed(context, '/recommendations');
                                },
                                icon: const Icon(Icons.lightbulb, color: Colors.white),
                                label: const Text(
                                  'Ver Recomendaciones',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xFF2E7D32),
                                  padding: const EdgeInsets.symmetric(vertical: 16),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 12),
                            SizedBox(
                              width: double.infinity,
                              child: OutlinedButton.icon(
                                onPressed: () {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text('Funcionalidad próximamente'),
                                    ),
                                  );
                                },
                                icon: const Icon(Icons.share, color: Color(0xFF2E7D32)),
                                label: const Text(
                                  'Compartir Resultados',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFF2E7D32),
                                  ),
                                ),
                                style: OutlinedButton.styleFrom(
                                  side: const BorderSide(color: Color(0xFF2E7D32)),
                                  padding: const EdgeInsets.symmetric(vertical: 16),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 100), // Space for bottom navigation
                    ],
                  ),
                ),
        ),
      ),
    );
  }

}
