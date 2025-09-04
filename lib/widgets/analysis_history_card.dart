import 'package:siembra_facil/models/history_item.dart';
import 'package:flutter/material.dart';

class AnalysisHistoryCard extends StatelessWidget {
  final String parcelName;
  final DateTime date;
  final HistoryStatus status; // Changed to the enum type
  final VoidCallback onTap;

  const AnalysisHistoryCard({
    super.key,
    required this.parcelName,
    required this.date,
    required this.status, // Changed to the enum type
    required this.onTap,
  });

  Color _getStatusColor() {
    switch (status) {
      case HistoryStatus.optimal:
        return const Color(0xFF4CAF50);
      case HistoryStatus.warning:
        return const Color(0xFFFF9800);
      case HistoryStatus.critical:
        return const Color(0xFFF44336);
      default:
        return const Color(0xFF9E9E9E);
    }
  }

  // The switch statement now checks the enum directly
  IconData _getStatusIcon() {
    switch (status) {
      case HistoryStatus.optimal:
        return Icons.check_circle;
      case HistoryStatus.warning:
        return Icons.warning;
      case HistoryStatus.critical:
        return Icons.error;
      default:
        return Icons.help;
    }
  }

  String _formatDate(DateTime date) {
    final months = [
      'Ene', 'Feb', 'Mar', 'Abr', 'May', 'Jun',
      'Jul', 'Ago', 'Sep', 'Oct', 'Nov', 'Dic'
    ];
    return '${date.day} ${months[date.month - 1]} ${date.year}';
  }

  String _getDisplayStatus() {
    switch (status) {
      case HistoryStatus.optimal:
        return 'Óptimo';
      case HistoryStatus.warning:
        return 'Precaución';
      case HistoryStatus.critical:
        return 'Crítico';
      default:
        return 'Desconocido';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: _getStatusColor().withOpacity(0.1),
                  borderRadius: BorderRadius.circular(24),
                ),
                child: Icon(
                  _getStatusIcon(),
                  color: _getStatusColor(),
                  size: 24,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      parcelName,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF2E7D32),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Análisis del ${_formatDate(date)}',
                      style: const TextStyle(
                        fontSize: 14,
                        color: Color(0xFF666666),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: _getStatusColor().withOpacity(0.1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        _getDisplayStatus(),
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: _getStatusColor(),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const Icon(
                Icons.arrow_forward_ios,
                color: Color(0xFF9E9E9E),
                size: 16,
              ),
            ],
          ),
        ),
      ),
    );
  }
}