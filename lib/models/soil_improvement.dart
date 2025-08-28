import 'package:flutter/material.dart';

enum Priority { high, medium, low }

class SoilImprovement {
  final String title;
  final Priority priority;
  final IconData icon;
  final String description;
  final String timeframe;
  final String cost;
  final List<String> steps;

  SoilImprovement({
    required this.title,
    required this.priority,
    required this.icon,
    required this.description,
    required this.timeframe,
    required this.cost,
    required this.steps,
  });

  static List<SoilImprovement> getSampleImprovements() {
    return [
      SoilImprovement(
        title: 'Ajustar pH del Suelo',
        priority: Priority.high,
        icon: Icons.science,
        description: 'El pH está fuera del rango óptimo para la mayoría de cultivos',
        timeframe: '2-4 semanas',
        cost: '\$50-100',
        steps: [
          'Aplicar cal agrícola si el pH es muy ácido',
          'Usar azufre elemental si el pH es muy alcalino',
          'Incorporar materia orgánica',
          'Regar moderadamente después de la aplicación'
        ],
      ),
      SoilImprovement(
        title: 'Aumentar Materia Orgánica',
        priority: Priority.medium,
        icon: Icons.eco,
        description: 'Mejorar la estructura y fertilidad del suelo',
        timeframe: '1-3 meses',
        cost: '\$30-80',
        steps: [
          'Agregar compost maduro',
          'Incorporar estiércol bien descompuesto',
          'Plantar cultivos de cobertura',
          'Reducir el laboreo excesivo'
        ],
      ),
      SoilImprovement(
        title: 'Corregir Deficiencia de Nitrógeno',
        priority: Priority.high,
        icon: Icons.grass,
        description: 'Los niveles de nitrógeno están por debajo del óptimo',
        timeframe: '1-2 semanas',
        cost: '\$25-60',
        steps: [
          'Aplicar fertilizante nitrogenado',
          'Usar abono orgánico rico en nitrógeno',
          'Plantar leguminosas como cultivo de cobertura',
          'Monitorear el crecimiento de las plantas'
        ],
      ),
    ];
  }
}
