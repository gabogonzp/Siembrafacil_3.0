enum HistoryStatus { optimal, warning, critical }
enum TrendDirection { up, down, stable }

class HistoryItem {
  final int id;
  final String date;
  final String time;
  final String location;
  final HistoryStatus status;
  final double ph;
  final int humidity;
  final int temperature;
  final TrendDirection trend;

  HistoryItem({
    required this.id,
    required this.date,
    required this.time,
    required this.location,
    required this.status,
    required this.ph,
    required this.humidity,
    required this.temperature,
    required this.trend,
  });
}
