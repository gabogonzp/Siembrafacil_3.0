import 'package:flutter/material.dart';
import '../models/crop_recommendation.dart';
import '../models/soil_improvement.dart';
import 'package:intl/intl.dart';

class RecommendationsScreen extends StatefulWidget {
  const RecommendationsScreen({super.key});

  @override
  State<RecommendationsScreen> createState() => _RecommendationsScreenState();
}

class _RecommendationsScreenState extends State<RecommendationsScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  final String _currentDate = DateFormat('dd MMM, yyyy').format(DateTime.now());

  final List<CropRecommendation>  cropRecommendations = [
    CropRecommendation(
  name: 'Papa',
  icon: '🥔',
  compatibility: 95,
  season: 'Época fresca',
  reason: 'El suelo muestra condiciones adecuadas para tubérculos, con buen balance de nutrientes y un ambiente fresco que favorece el cultivo.',
  benefits: [
    'Alto rendimiento esperado en suelos de clima templado',
    'Aprovecha bien la fertilidad disponible',
    'Producto con buena salida en el mercado local',
  ],
),

CropRecommendation(
  name: 'Habas o Frijol',
  icon: '🫘',
  compatibility: 90,
  season: 'Todo el año',
  reason: 'Las leguminosas ayudan a enriquecer el terreno y aportan beneficios a los cultivos que se siembren después.',
  benefits: [
    'Mejora la salud del suelo',
    'Resistente a variaciones de clima y suelo',
    'Ideal como rotación después de tubérculos',
  ],
),

CropRecommendation(
  name: 'Zanahoria',
  icon: '🥕',
  compatibility: 85,
  season: 'Época fresca',
  reason: 'El ambiente favorece el desarrollo de raíces de buena calidad y uniformidad.',
  benefits: [
    'Buen desempeño en climas frescos',
    'Tolera condiciones variables del terreno',
    'Alta demanda tanto en el mercado local como en exportación',
  ],
),
  ];

  final List<SoilImprovement> soilImprovements = [
   SoilImprovement(
  title: 'Manejo de Salinidad Moderada',
  priority: Priority.high,
  icon: Icons.water_drop,
  description: 'La CE promedio indica acumulación moderada de sales. Es necesario aplicar riegos de lavado y evitar fertilizantes salinos.',
  timeframe: 'Inmediato',
  cost: 'Medio',
  steps: [
    'Realizar riego profundo con agua de baja salinidad para lixiviar sales',
    'Evitar fertilizantes como cloruro de potasio o nitrato de sodio',
    'Usar fertilizantes de liberación controlada o fertirrigación precisa',
    'Monitorear la CE del suelo cada 2-3 semanas',
  ],
),

SoilImprovement(
  title: 'Incorporación de Materia Orgánica',
  priority: Priority.medium,
  icon: Icons.grass,
  description: 'El suelo es fértil en N, P y K, pero la materia orgánica mejora estructura, retención de humedad y reduce acumulación de sales.',
  timeframe: '1 mes',
  cost: 'Bajo',
  steps: [
    'Aplicar 2-3 toneladas por hectárea de compost o estiércol vacuno/gallinaza compostada',
    'Incorporar con arado o rastra ligera',
    'Mantener cobertura vegetal o mulching para conservar la humedad',
    'Fomentar microorganismos benéficos en el suelo',
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
      appBar: AppBar(
        title: const Text(
          'Análisis de suelo',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        backgroundColor: const Color(0xFF2E7D32),
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
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
                child: Padding(
                  padding: const EdgeInsets.only(left: 65, right: 65, top: 16, bottom: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Recomendaciones',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF2D5016),
                        ),
                      ),
                      Text(
                        'Basadas en tu análisis del $_currentDate',
                        style: const TextStyle(
                          fontSize: 16,
                          color: Color(0xFF4CAF50),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              
              // Tabs
              Container(
                color: Colors.white,
                child: TabBar(
                  controller: _tabController,
                  labelColor:  Color(0xFF2D5016),
                  unselectedLabelColor: Colors.grey,
                  indicatorColor:  Color(0xFF2D5016),
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