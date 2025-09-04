import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // Import for date formatting
import '../../widgets/analysis_history_card.dart'; // Ensure this path is correct
import 'package:siembra_facil/models/history_item.dart'; // You will create this file

class AnalysisTab extends StatefulWidget {
  const AnalysisTab({super.key});

  @override
  State<AnalysisTab> createState() => _AnalysisTabState();
}

class _AnalysisTabState extends State<AnalysisTab> {
  // A placeholder list to simulate fetched data
  final List<HistoryItem> _analysisHistory = [
    // You would typically fetch this from an API or database
    // For now, these are placeholder items.
    HistoryItem(
      id: 1,
      date: '2024-03-20',
      time: '10:30 AM',
      location: 'Parcela Norte',
      status: HistoryStatus.optimal,
      ph: 6.5,
      humidity: 45,
      temperature: 25,
      trend: TrendDirection.stable,
    ),
    HistoryItem(
      id: 2,
      date: '2024-03-18',
      time: '02:15 PM',
      location: 'Parcela Sur',
      status: HistoryStatus.warning,
      ph: 5.8,
      humidity: 50,
      temperature: 24,
      trend: TrendDirection.down,
    ),
    HistoryItem(
      id: 3,
      date: '2024-03-15',
      time: '09:00 AM',
      location: 'Parcela Este',
      status: HistoryStatus.critical,
      ph: 4.9,
      humidity: 55,
      temperature: 22,
      trend: TrendDirection.up,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          child: Column(
            children: [
              // Header
              Container(
                padding: const EdgeInsets.all(20),
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Análisis de Suelo',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF2E7D32),
                      ),
                    ),
                    Text(
                      'Historial y nuevos análisis',
                      style: TextStyle(
                        fontSize: 16,
                        color: Color(0xFF666666),
                      ),
                    ),
                  ],
                ),
              ),
              
              // New Analysis Button
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 20),
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: () {
                    // Navigate to a screen to perform a new analysis
                    Navigator.pushNamed(context, '/analysis-request');
                  },
                  icon: const Icon(Icons.add, color: Colors.white),
                  label: const Text(
                    'Realizar Nuevo Análisis',
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
              const SizedBox(height: 20),
              
              // Analysis History
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Historial de Análisis',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF2E7D32),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 12),
              
              // List of Analysis Cards
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  itemCount: _analysisHistory.length,
                  itemBuilder: (context, index) {
                    final analysis = _analysisHistory[index];
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: AnalysisHistoryCard(
                        parcelName: analysis.location,
                        // Parse the string date into a DateTime object
                        date: DateTime.parse(analysis.date), 
                        status: analysis.status, // Pass enum directly
                        onTap: () {
                          Navigator.pushNamed(context, '/analysis-results');
                        },
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}