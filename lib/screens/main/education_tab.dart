import 'package:flutter/material.dart';
import '../../models/education_content.dart';

class EducationTab extends StatelessWidget {
  const EducationTab({super.key});

  final List<EducationContent> _educationContent = const [
    EducationContent(
      id: '1',
      title: 'Interpretación de Análisis de pH',
      description: 'Aprende a entender los niveles de pH en tu suelo y cómo afectan tus cultivos.',
      category: 'Análisis de Suelo',
      difficulty: 'Básico',
      readTime: '5 min',
      icon: Icons.science,
    ),
    EducationContent(
      id: '2',
      title: 'Manejo de Nutrientes en el Suelo',
      description: 'Guía completa sobre NPK y micronutrientes esenciales para plantas.',
      category: 'Nutrición',
      difficulty: 'Intermedio',
      readTime: '8 min',
      icon: Icons.eco,
    ),
    EducationContent(
      id: '3',
      title: 'Sistemas de Riego Eficientes',
      description: 'Optimiza el uso del agua con técnicas de riego modernas.',
      category: 'Riego',
      difficulty: 'Avanzado',
      readTime: '12 min',
      icon: Icons.water_drop,
    ),
    EducationContent(
      id: '4',
      title: 'Control de Plagas Orgánico',
      description: 'Métodos naturales para proteger tus cultivos sin químicos.',
      category: 'Protección',
      difficulty: 'Intermedio',
      readTime: '10 min',
      icon: Icons.bug_report,
    ),
    EducationContent(
      id: '5',
      title: 'Rotación de Cultivos',
      description: 'Maximiza la productividad del suelo con rotaciones inteligentes.',
      category: 'Planificación',
      difficulty: 'Básico',
      readTime: '6 min',
      icon: Icons.refresh,
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
                      'Contenido Educativo',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFFE65100),
                      ),
                    ),
                    Text(
                      'Aprende y mejora tus técnicas agrícolas',
                      style: TextStyle(
                        fontSize: 16,
                        color: Color(0xFF666666),
                      ),
                    ),
                  ],
                ),
              ),
              
              // Categories Filter
              SizedBox(
                height: 50,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  children: [
                    _buildCategoryChip('Todos', true),
                    const SizedBox(width: 8),
                    _buildCategoryChip('Análisis de Suelo', false),
                    const SizedBox(width: 8),
                    _buildCategoryChip('Nutrición', false),
                    const SizedBox(width: 8),
                    _buildCategoryChip('Riego', false),
                    const SizedBox(width: 8),
                    _buildCategoryChip('Protección', false),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              
              // Content List
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  itemCount: _educationContent.length,
                  itemBuilder: (context, index) {
                    final content = _educationContent[index];
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 16),
                      child: _buildContentCard(context, content),
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

  Widget _buildCategoryChip(String label, bool isSelected) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: isSelected ? const Color(0xFFE65100) : Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: isSelected ? const Color(0xFFE65100) : Colors.grey[300]!,
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

  Widget _buildContentCard(BuildContext context, EducationContent content) {
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
      child: InkWell(
        onTap: () {
          _showContentDetail(context, content);
        },
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: const Color(0xFFE65100).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(
                  content.icon,
                  color: const Color(0xFFE65100),
                  size: 24,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      content.title,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF2E7D32),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      content.description,
                      style: const TextStyle(
                        fontSize: 14,
                        color: Color(0xFF666666),
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        _buildInfoChip(content.difficulty, _getDifficultyColor(content.difficulty)),
                        const SizedBox(width: 8),
                        _buildInfoChip(content.readTime, Colors.grey),
                      ],
                    ),
                  ],
                ),
              ),
              const Icon(
                Icons.arrow_forward_ios,
                size: 16,
                color: Color(0xFF666666),
              ),
            ],
          ),
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

  Color _getDifficultyColor(String difficulty) {
    switch (difficulty) {
      case 'Básico':
        return Colors.green;
      case 'Intermedio':
        return Colors.orange;
      case 'Avanzado':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  void _showContentDetail(BuildContext context, EducationContent content) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.8,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Column(
          children: [
            Container(
              width: 40,
              height: 4,
              margin: const EdgeInsets.symmetric(vertical: 12),
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          width: 60,
                          height: 60,
                          decoration: BoxDecoration(
                            color: const Color(0xFFE65100).withOpacity(0.1),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Icon(
                            content.icon,
                            color: const Color(0xFFE65100),
                            size: 30,
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                content.title,
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF2E7D32),
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                content.category,
                                style: const TextStyle(
                                  fontSize: 14,
                                  color: Color(0xFF666666),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Row(
                      children: [
                        _buildInfoChip(content.difficulty, _getDifficultyColor(content.difficulty)),
                        const SizedBox(width: 8),
                        _buildInfoChip(content.readTime, Colors.grey),
                      ],
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      'Descripción',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF2E7D32),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      content.description,
                      style: const TextStyle(
                        fontSize: 16,
                        color: Color(0xFF666666),
                        height: 1.5,
                      ),
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      'Contenido del Artículo',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF2E7D32),
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Expanded(
                      child: SingleChildScrollView(
                        child: Text(
                          'Este es el contenido detallado del artículo educativo. Aquí encontrarás información valiosa sobre el tema seleccionado.\n\nEn futuras versiones, este contenido será dinámico y se cargará desde una base de datos con artículos completos, videos, infografías y otros recursos educativos.\n\nPor ahora, esta es una demostración de cómo se vería la pantalla de detalle de contenido educativo.',
                          style: TextStyle(
                            fontSize: 16,
                            color: Color(0xFF666666),
                            height: 1.6,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
