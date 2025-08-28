import 'package:flutter/material.dart';
import '../models/analysis_data.dart';

class MetricCardDetailed extends StatelessWidget {
  final String title;
  final IconData icon;
  final MetricData data;
  final String unit;
  final String description;

  const MetricCardDetailed({
    super.key,
    required this.title,
    required this.icon,
    required this.data,
    required this.unit,
    required this.description,
  });

  Color getStatusColor(MetricStatus status) {
    switch (status) {
      case MetricStatus.optimal:
        return const Color(0xFF4CAF50);
      case MetricStatus.warning:
        return const Color(0xFFFF9800);
      case MetricStatus.critical:
        return const Color(0xFFF44336);
    }
  }

  IconData getStatusIcon(MetricStatus status) {
    switch (status) {
      case MetricStatus.optimal:
        return Icons.check_circle;
      case MetricStatus.warning:
        return Icons.warning;
      case MetricStatus.critical:
        return Icons.error;
    }
  }

  String getStatusText(MetricStatus status) {
    switch (status) {
      case MetricStatus.optimal:
        return 'Óptimo';
      case MetricStatus.warning:
        return 'Precaución';
      case MetricStatus.critical:
        return 'Crítico';
    }
  }

  IconData getTrendIcon(TrendDirection trend) {
    switch (trend) {
      case TrendDirection.up:
        return Icons.trending_up;
      case TrendDirection.down:
        return Icons.trending_down;
      case TrendDirection.stable:
        return Icons.trending_flat;
    }
  }

  Color getTrendColor(TrendDirection trend) {
    switch (trend) {
      case TrendDirection.up:
        return const Color(0xFF4CAF50);
      case TrendDirection.down:
        return const Color(0xFFF44336);
      case TrendDirection.stable:
        return const Color(0xFF9E9E9E);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: const BorderSide(color: Color(0xFFE0E0E0)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(icon, color: const Color(0xFF2D5016)),
                    const SizedBox(width: 8),
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF2D5016),
                      ),
                    ),
                  ],
                ),
                Icon(
                  getTrendIcon(data.trend),
                  color: getTrendColor(data.trend),
                  size: 20,
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: data.value.toString(),
                        style: const TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF4CAF50),
                        ),
                      ),
                      TextSpan(
                        text: unit,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF4CAF50),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: getStatusColor(data.status).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        getStatusIcon(data.status),
                        size: 16,
                        color: getStatusColor(data.status),
                      ),
                      const SizedBox(width: 4),
                      Text(
                        getStatusText(data.status),
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: getStatusColor(data.status),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            LinearProgressIndicator(
              value: data.value > 100 ? 1.0 : data.value / 100,
              backgroundColor: Colors.grey[300],
              valueColor: const AlwaysStoppedAnimation<Color>(Color(0xFF4CAF50)),
              minHeight: 6,
            ),
            const SizedBox(height: 8),
            Text(
              description,
              style: const TextStyle(
                fontSize: 14,
                color: Color(0xFF4CAF50),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
