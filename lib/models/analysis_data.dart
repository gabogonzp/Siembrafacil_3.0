enum MetricStatus { optimal, warning, critical }
enum TrendDirection { up, down, stable }

class MetricData {
  final double value;
  final MetricStatus status;
  final TrendDirection trend;

  MetricData({
    required this.value,
    required this.status,
    required this.trend,
  });
}

class AnalysisData {
  final String date;
  final String time;
  final String location;
  final MetricData ph;
  final MetricData humidity;
  final MetricData temperature;
  final MetricData nitrogen;
  final MetricData phosphorus;
  final MetricData potassium;
  final MetricData organicMatter;
  final MetricData conductivity;

  AnalysisData({
    required this.date,
    required this.time,
    required this.location,
    required this.ph,
    required this.humidity,
    required this.temperature,
    required this.nitrogen,
    required this.phosphorus,
    required this.potassium,
    required this.organicMatter,
    required this.conductivity,
  });
}
