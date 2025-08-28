import 'package:flutter/material.dart';
import '../models/crop_recommendation.dart';
import '../models/soil_improvement.dart';

class RecommendationsScreen extends StatefulWidget {
  const RecommendationsScreen({super.key});

  @override
  State<RecommendationsScreen> createState() => _RecommendationsScreenState();
}

class _RecommendationsScreenState extends State<RecommendationsScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  final List<CropRecommendation> cropRecommendations = [
    CropRecommendation(
      name: 'Maíz',
      icon: '🌽',
      compatibility: 95,
      season: 'Primavera-Verano',
      reason: 'pH ideal y buena humedad',
      benefits: ['Alto rendimiento esperado', 'Condiciones óptimas', 'Buen drenaje'],
    ),
    CropRecommendation(
      name: 'Frijol',
      icon: '🫘',
      compatibility: 88,
      season: 'Todo el año',
      reason: 'Excelente para fijar nitrógeno',
      benefits: ['Mejora el suelo', 'Resistente', 'Complementa otros cultivos'],
    ),
    CropRecommendation(
      name: 'Tomate',
      icon: '🍅',
      compatibility: 82,
      season: 'Primavera',
      reason: 'Requiere ajuste menor de pH',
      benefits: ['Alto valor comercial', 'Demanda constante', 'Cultivo rentable'],
    ),
  ];

  final List<SoilImprovement> soilImprovements = [
    SoilImprovement(
      title: 'Aplicar Fertilizante Fosfórico',
      priority: Priority.high,
      icon: Icons.flash_on,
      description: 'El fósforo está en nivel crítico (38%). Aplicar 50kg/ha de superfosfato.',
      timeframe: 'Inmediato',
      cost: 'Medio',
      steps: [
        'Adquirir superfosfato triple (46% P2O5)',
        'Aplicar 50kg por hectárea',
        'Incorporar al suelo con rastra',
        'Regar ligeramente después de la aplicación',
      ],
    ),
    SoilImprovement(
      title: 'Fertilización Nitrogenada',
      priority: Priority.medium,
      icon: Icons.eco,
      description: 'Nitrógeno en descenso (45%). Aplicar urea o sulfato de amonio.',
      timeframe: '1-2 semanas',
      cost: 'Bajo',
      steps: [
        'Aplicar 30kg/ha de urea',
        'Dividir en 2 aplicaciones',
        'Aplicar cerca de las raíces',
        'Regar inmediatamente',
      ],
    ),
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

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
              Color(0xFFFFF8E1),
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              // Header
              Container(
                color: Colors.white,
                padding: const EdgeInsets.all(16),
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Recomendaciones Inteligentes',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF2D5016),
                      ),
                    ),
                    Text(
                      'Basadas en tu análisis del 15 de Marzo, 2024',
                      style: TextStyle(
                        fontSize: 16,
                        color: Color(0xFF4CAF50),
                      ),
                    ),
                  ],
                ),
              ),
              
              // Tabs
              Container(
                color: Colors.white,
                child: TabBar(
                  controller: _tabController,
                  labelColor: const Color(0xFF2D5016),
                  unselectedLabelColor: Colors.grey,
                  indicatorColor: const Color(0xFF2D5016),
                  tabs: const [
                    Tab(text: 'Qué Sembrar'),
                    Tab(text: 'Mejorar Terreno'),
                  ],
                ),
              ),
              
              // Tab Content
              Expanded(
                child: TabBarView(
                  controller: _tabController,
                  children: [
                    // Crops Tab
                    ListView.builder(
                      padding: const EdgeInsets.all(16),
                      itemCount: cropRecommendations.length,
                      itemBuilder: (context, index) {
                        final crop = cropRecommendations[index];
                        return Card(
                          margin: const EdgeInsets.only(bottom: 16),
                          child: Padding(
                            padding: const EdgeInsets.all(16),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      crop.icon,
                                      style: const TextStyle(fontSize: 32),
                                    ),
                                    const SizedBox(width: 12),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            crop.name,
                                            style: const TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold,
                                              color: Color(0xFF2D5016),
                                            ),
                                          ),
                                          Row(
                                            children: [
                                              const Icon(Icons.wb_sunny, size: 16, color: Color(0xFFFF9800)),
                                              const SizedBox(width: 4),
                                              Text(
                                                crop.season,
                                                style: const TextStyle(
                                                  fontSize: 14,
                                                  color: Color(0xFF666666),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                      decoration: BoxDecoration(
                                        color: const Color(0xFF4CAF50).withOpacity(0.1),
                                        borderRadius: BorderRadius.circular(12),
                                        border: Border.all(
                                          color: const Color(0xFF4CAF50),
                                        ),
                                      ),
                                      child: Text(
                                        '${crop.compatibility}% compatible',
                                        style: const TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold,
                                          color: Color(0xFF4CAF50),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 12),
                                Text(
                                  'Por qué es ideal: ${crop.reason}',
                                  style: const TextStyle(
                                    fontSize: 14,
                                    color: Color(0xFF4CAF50),
                                  ),
                                ),
                                const SizedBox(height: 12),
                                const Text(
                                  'Beneficios:',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFF2D5016),
                                  ),
                                ),
                                const SizedBox(height: 4),
                                ...crop.benefits.map((benefit) => Padding(
                                  padding: const EdgeInsets.only(left: 8, bottom: 2),
                                  child: Text(
                                    '• $benefit',
                                    style: const TextStyle(
                                      fontSize: 14,
                                      color: Color(0xFF4CAF50),
                                    ),
                                  ),
                                )),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                    
                    // Improvements Tab
                    ListView.builder(
                      padding: const EdgeInsets.all(16),
                      itemCount: soilImprovements.length,
                      itemBuilder: (context, index) {
                        final improvement = soilImprovements[index];
                        return Card(
                          margin: const EdgeInsets.only(bottom: 16),
                          child: Padding(
                            padding: const EdgeInsets.all(16),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.all(8),
                                      decoration: BoxDecoration(
                                        color: const Color(0xFFE8F5E8),
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: Icon(
                                        improvement.icon,
                                        color: const Color(0xFF2D5016),
                                      ),
                                    ),
                                    const SizedBox(width: 12),
                                    Expanded(
                                      child: Text(
                                        improvement.title,
                                        style: const TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                          color: Color(0xFF2D5016),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 12),
                                Text(
                                  improvement.description,
                                  style: const TextStyle(
                                    fontSize: 14,
                                    color: Color(0xFF666666),
                                  ),
                                ),
                                const SizedBox(height: 12),
                                Row(
                                  children: [
                                    const Icon(Icons.access_time, size: 16, color: Color(0xFF4CAF50)),
                                    const SizedBox(width: 4),
                                    Text(
                                      'Tiempo: ${improvement.timeframe}',
                                      style: const TextStyle(
                                        fontSize: 14,
                                        color: Color(0xFF4CAF50),
                                      ),
                                    ),
                                    const SizedBox(width: 16),
                                    Text(
                                      'Costo: ${improvement.cost}',
                                      style: const TextStyle(
                                        fontSize: 14,
                                        color: Color(0xFF4CAF50),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
