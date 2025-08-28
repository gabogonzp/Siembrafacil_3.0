import 'package:flutter/material.dart';
import '../../widgets/parcel_selector.dart';
import '../../widgets/weather_card.dart';
import '../../widgets/quick_action_card.dart';
import '../../widgets/analysis_history_card.dart';
import '../../services/app_state.dart';
import '../../services/auth_services.dart';

class HomeTab extends StatefulWidget {
  final VoidCallback onWeatherCardTap;
  const HomeTab({super.key, required this.onWeatherCardTap});

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  @override
  Widget build(BuildContext context) {
    final user = authServices.value.currentUser;
    final userName = user?.displayName ?? user?.email?.split('@')[0] ?? 'Usuario';
    
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
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header
                Container(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '¡Hola, $userName!',
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF2E7D32),
                        ),
                      ),
                      const Text(
                        'Gestiona tus cultivos de manera inteligente',
                        style: TextStyle(
                          fontSize: 16,
                          color: Color(0xFF666666),
                        ),
                      ),
                    ],
                  ),
                ),
                
                // Parcel Selector - Updated to show selected parcel name
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: ParcelSelector(
                    onParcelChanged: () {
                      setState(() {}); // Refresh when parcel changes
                    },
                  ),
                ),
                const SizedBox(height: 20),
                
                // Weather Card
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  // Use widget.onWeatherCardTap to access the passed function
                  child: WeatherCard(onTap: widget.onWeatherCardTap),
                ),
                const SizedBox(height: 20),
                
                // Quick Actions
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Text(
                    'Acciones Rápidas',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF2E7D32),
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                SizedBox(
                  height: 120,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    children: [
                      QuickActionCard(
                        title: 'Nuevo Análisis',
                        icon: Icons.science,
                        color: const Color(0xFF4CAF50),
                        onTap: () {
                          Navigator.pushNamed(context, '/analysis-request');
                        },
                      ),
                      const SizedBox(width: 12),
                      QuickActionCard(
                        title: 'Mis Parcelas',
                        icon: Icons.landscape,
                        color: const Color(0xFF2196F3),
                        onTap: () {
                          Navigator.pushNamed(context, '/parcels');
                        },
                      ),
                      const SizedBox(width: 12),
                      QuickActionCard(
                        title: 'Clima',
                        icon: Icons.cloud,
                        color: const Color(0xFFFF9800),
                        // Use the passed callback instead of finding the ancestor state
                        onTap: widget.onWeatherCardTap,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                
                // Recent Analysis - Auto-refresh with latest results
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Text(
                    'Análisis Recientes',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF2E7D32),
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                
                // Show latest analysis results
                if (AppState.analysisHistory.isNotEmpty)
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    itemCount: AppState.analysisHistory.length > 3 ? 3 : AppState.analysisHistory.length,
                    itemBuilder: (context, index) {
                      final analysis = AppState.analysisHistory[index];
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 12),
                        child: AnalysisHistoryCard(
                          parcelName: analysis.parcelName,
                          date: analysis.date,
                          status: analysis.overallStatus,
                          onTap: () {
                            Navigator.pushNamed(context, '/analysis-results');
                          },
                        ),
                      );
                    },
                  )
                else
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 8,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          const Icon(
                            Icons.science_outlined,
                            size: 48,
                            color: Color(0xFF9E9E9E),
                          ),
                          const SizedBox(height: 12),
                          const Text(
                            'No hay análisis recientes',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Color(0xFF666666),
                            ),
                          ),
                          const SizedBox(height: 8),
                          const Text(
                            'Realiza tu primer análisis de suelo',
                            style: TextStyle(
                              fontSize: 14,
                              color: Color(0xFF9E9E9E),
                            ),
                          ),
                          const SizedBox(height: 16),
                          ElevatedButton(
                            onPressed: () {
                              Navigator.pushNamed(context, '/analysis-request');
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF2E7D32),
                            ),
                            child: const Text(
                              'Comenzar Análisis',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ],
                      ),
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
