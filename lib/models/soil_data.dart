import 'package:firebase_database/firebase_database.dart';

class SensorData {
  final double temperature;
  final double ph;
  final double ec;
  final double nitrogen;
  final double phosphorous;
  final double potassium;
  final double timestamp;

  SensorData({
    required this.temperature,
    required this.ph,
    required this.ec,
    required this.nitrogen,
    required this.phosphorous,
    required this.potassium,
    required this.timestamp,
  });

  // A factory constructor to create a SensorData object from a Map.
  factory SensorData.fromMap(Map<String, dynamic> map) {
    // A helper function to safely get a double value from the map.
    // It handles cases where the value might be null or not a double/integer.
    double getDouble(String key) {
      final value = map[key];
      if (value == null) {
        // If the value is null, return 0.0 to prevent errors.
        return 0.0;
      }
      if (value is num) {
        // If the value is a number (int or double), convert it to a double.
        return value.toDouble();
      }
      // If the value is not a number, try to parse it from a string.
      if (value is String) {
        return double.tryParse(value) ?? 0.0;
      }
      // Return 0.0 as a fallback if the type is unexpected.
      return 0.0;
    }

    // Now, use the safe helper function to retrieve each value.
    // We are using the exact key names from your Firebase Realtime Database.
    return SensorData(
      temperature: getDouble('Averaged Temperature'),
      ph: getDouble('Averaged Soil pH'),
      ec: getDouble('Averaged Electroconductivity'),
      nitrogen: getDouble('Averaged Nitrogen'),
      phosphorous: getDouble('Averaged Phosphorous'),
      potassium: getDouble('Averaged Potassium'),
      // The timestamp is now correctly included in the map from the previous file.
      timestamp: getDouble('timestamp'),
    );
  }
}
