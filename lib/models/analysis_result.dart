import 'parcel.dart';

class AnalysisResult {
  final String id;
  final String parcelId;
  final String parcelName;
  final DateTime date;
  final double ph;
  final double humidity;
  final double temperature;
  final double conductivity;
  final double nitrogen;
  final double phosphorus;
  final double potassium;
  final double organicMatter;
  final String overallStatus;
  final List<String> recommendations;

  AnalysisResult({
    required this.id,
    required this.parcelId,
    required this.parcelName,
    required this.date,
    required this.ph,
    required this.humidity,
    required this.temperature,
    required this.conductivity,
    required this.nitrogen,
    required this.phosphorus,
    required this.potassium,
    required this.organicMatter,
    required this.overallStatus,
    required this.recommendations,
  });

  static AnalysisResult generateSimulated(Parcel parcel) {
    final random = DateTime.now().millisecondsSinceEpoch;
    
    // Generate realistic values
    final ph = 6.0 + (random % 200) / 100.0; // 6.0 - 8.0
    final humidity = 30.0 + (random % 400) / 10.0; // 30-70%
    final temperature = 18.0 + (random % 150) / 10.0; // 18-33°C
    final conductivity = 0.5 + (random % 200) / 100.0; // 0.5-2.5 dS/m
    final nitrogen = 20.0 + (random % 300) / 10.0; // 20-50 ppm
    final phosphorus = 10.0 + (random % 200) / 10.0; // 10-30 ppm
    final potassium = 100.0 + (random % 2000) / 10.0; // 100-300 ppm
    final organicMatter = 2.0 + (random % 300) / 100.0; // 2-5%

    // Determine overall status
    String status = 'Óptimo';
    if (ph < 6.2 || ph > 7.8 || humidity < 40 || nitrogen < 25) {
      status = 'Precaución';
    }
    if (ph < 5.5 || ph > 8.5 || humidity < 30 || nitrogen < 20) {
      status = 'Crítico';
    }

    // Generate recommendations
    List<String> recommendations = [];
    if (ph < 6.5) {
      recommendations.add('Aplicar cal para aumentar el pH del suelo');
    }
    if (ph > 7.5) {
      recommendations.add('Aplicar azufre para reducir el pH del suelo');
    }
    if (humidity < 40) {
      recommendations.add('Aumentar la frecuencia de riego');
    }
    if (nitrogen < 30) {
      recommendations.add('Aplicar fertilizante nitrogenado');
    }
    if (phosphorus < 15) {
      recommendations.add('Aplicar fertilizante fosfatado');
    }
    if (potassium < 150) {
      recommendations.add('Aplicar fertilizante potásico');
    }
    if (organicMatter < 3) {
      recommendations.add('Incorporar materia orgánica al suelo');
    }

    if (recommendations.isEmpty) {
      recommendations.add('El suelo está en condiciones óptimas');
      recommendations.add('Mantener las prácticas actuales de manejo');
    }

    return AnalysisResult(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      parcelId: parcel.id,
      parcelName: parcel.name,
      date: DateTime.now(),
      ph: ph,
      humidity: humidity,
      temperature: temperature,
      conductivity: conductivity,
      nitrogen: nitrogen,
      phosphorus: phosphorus,
      potassium: potassium,
      organicMatter: organicMatter,
      overallStatus: status,
      recommendations: recommendations,
    );
  }
}
