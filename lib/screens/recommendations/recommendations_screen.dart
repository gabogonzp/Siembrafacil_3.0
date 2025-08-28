import 'package:flutter/material.dart';
import '../../models/recommendation.dart';

class RecommendationsScreen extends StatelessWidget {
  const RecommendationsScreen({super.key});

  final List<Recommendation> _recommendations = const [
    Recommendation(
      id: '1',
      title: 'Aplicar Fertilizante Fosfórico',
      description: 'El nivel de fósforo está bajo. Aplica 50kg/ha de superfosfato triple.',
      priority: 'Alta',
      category: 'Nutrición',
      icon: Icons.eco,
    ),
    Recommendation(
      id: '2',
      title: 'Monitorear Conductividad',
      description: 'La conductividad eléctrica está en el límite. Revisa el riego y drenaje.',
      priority: 'Media',
      category: 'Riego',
      icon: Icons.water_drop,
    ),
    Recommendation(
      id: '3',
      title: 'Mantener Condiciones Actuales',
      description: 'El pH y la temperatura están en niveles óptimos. Continúa con el manejo actual.',
      priority: 'Baja',
      category: 'Mantenimiento',
      icon: Icons.check_circle,
    ),
    Recommendation(
      id: '4',
      title: 'Programar Próximo Análisis',
      description: 'Realiza el siguiente análisis en 2 semanas para monitorear cambios.',
      priority: 'Media',
      category: 'Planificación',
      icon: Icons.schedule,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Recomendaciones',
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
              Color(0xFFFFF3E0),
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
                      'Recomendaciones Personalizadas',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF2E7D32),
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Basadas en el análisis de tu parcela',
                      style: TextStyle(
                        fontSize: 16,
                        color: Color(0xFF666666),
                      ),
                    ),
                  ],
                ),
              ),
              
              // Priority Filter
              SizedBox(
                height: 50,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  children: [
                    _buildPriorityChip('Todas', true),
                    const SizedBox(width: 8),
                    _buildPriorityChip('Alta', false),
                    const SizedBox(width: 8),
                    _buildPriorityChip('Media', false),
                    const SizedBox(width: 8),
                    _buildPriorityChip('Baja', false),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              
              // Recommendations List
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  itemCount: _recommendations.length,
                  itemBuilder: (context, index) {
                    final recommendation = _recommendations[index];
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 16),
                      child: _buildRecommendationCard(recommendation),
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

  Widget _buildPriorityChip(String label, bool isSelected) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: isSelected ? const Color(0xFF2E7D32) : Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: isSelected ? const Color(0xFF2E7D32) : Colors.grey[300]!,
        ),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: isSelected ? Colors.white : const Color(0xFF666666),
          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
        ),
      ),
    );
  }

  Widget _buildRecommendationCard(Recommendation recommendation) {
    return Container(
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
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    color: _getPriorityColor(recommendation.priority).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(
                    recommendation.icon,
                    color: _getPriorityColor(recommendation.priority),
                    size: 24,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        recommendation.title,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF2E7D32),
                        ),
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          _buildInfoChip(
                            recommendation.priority,
                            _getPriorityColor(recommendation.priority),
                          ),
                          const SizedBox(width: 8),
                          _buildInfoChip(
                            recommendation.category,
                            Colors.grey,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              recommendation.description,
              style: const TextStyle(
                fontSize: 14,
                color: Color(0xFF666666),
                height: 1.4,
              ),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {
                      _showRecommendationDetail(recommendation);
                    },
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: Color(0xFF2E7D32)),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text(
                      'Ver Detalles',
                      style: TextStyle(
                        color: Color(0xFF2E7D32),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      _markAsCompleted(recommendation);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF2E7D32),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text(
                      'Marcar Hecho',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoChip(String label, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 12,
          color: color,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  Color _getPriorityColor(String priority) {
    switch (priority) {
      case 'Alta':
        return const Color(0xFFF44336);
      case 'Media':
        return const Color(0xFFFF9800);
      case 'Baja':
        return const Color(0xFF4CAF50);
      default:
        return Colors.grey;
    }
  }

  void _showRecommendationDetail(Recommendation recommendation) {
    // Implementation for showing detailed recommendation
  }

  void _markAsCompleted(Recommendation recommendation) {
    // Implementation for marking recommendation as completed
  }
}
