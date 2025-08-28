import 'package:flutter/material.dart';
import '../models/soil_data.dart';
import '../models/soil_status.dart';
import 'package:intl/intl.dart';

class StatusCard extends StatelessWidget {
  final SensorData sensorData;

  const StatusCard({super.key, required this.sensorData});

  // This function determines the overall status based on the sensor readings
  SoilStatus _calculateOverallStatus(SensorData data) {
    bool hasWarning = false;
    bool hasCritical = false;

    // pH check
    if (data.ph < 6.0 || data.ph > 7.0) {
      hasWarning = true;
    }

    // EC (Conductivity) check - assuming a range of 100-1500 uS/cm
    if (data.ec < 100 || data.ec > 1500) {
      hasWarning = true;
    }

    // Nitrogen (N) check - assuming ranges in mg/kg
    if (data.nitrogen < 20 || data.nitrogen > 50) {
      hasWarning = true;
    }

    // Phosphorous (P) check - assuming ranges in mg/kg
    if (data.phosphorous < 10) {
      hasCritical = true; // Critical if very low
    } else if (data.phosphorous > 30) {
      hasWarning = true;
    }

    // Potassium (K) check - assuming ranges in mg/kg
    if (data.potassium < 100) {
      hasCritical = true; // Critical if very low
    } else if (data.potassium > 200) {
      hasWarning = true;
    }

    if (hasCritical) {
      return SoilStatus.critical;
    } else if (hasWarning) {
      return SoilStatus.warning;
    } else {
      return SoilStatus.optimal;
    }
  }

  @override
  Widget build(BuildContext context) {
    final overallStatus = _calculateOverallStatus(sensorData);
    
    Color statusColor;
    IconData statusIcon;
    String statusText;
    String statusMessage;

    switch (overallStatus) {
      case SoilStatus.optimal:
        statusColor = const Color(0xFF4CAF50);
        statusIcon = Icons.check_circle;
        statusText = 'EXCELENTE';
        statusMessage = 'Tu suelo está perfecto para sembrar';
        break;
      case SoilStatus.warning:
        statusColor = const Color(0xFFFF9800);
        statusIcon = Icons.warning;
        statusText = 'NECESITA ATENCIÓN';
        statusMessage = 'Algunos valores necesitan mejorarse';
        break;
      case SoilStatus.critical:
        statusColor = const Color(0xFFF44336);
        statusIcon = Icons.error;
        statusText = 'URGENTE';
        statusMessage = 'Requiere acción inmediata';
        break;
    }

    final lastUpdate = DateFormat('d/M/y - h:mm a').format(
    DateTime.fromMillisecondsSinceEpoch((sensorData.timestamp * 1000).round()),
    );

    return Card(
      color: statusColor.withOpacity(0.1),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: statusColor, width: 2),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Row(
          children: [
            Container(
              width: 64,
              height: 64,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(32),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Icon(
                statusIcon,
                size: 32,
                color: statusColor,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    statusText,
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: statusColor,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    statusMessage,
                    style: TextStyle(
                      fontSize: 18,
                      color: statusColor,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Última actualización: $lastUpdate',
                    style: TextStyle(
                      fontSize: 14,
                      color: statusColor.withOpacity(0.8),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}