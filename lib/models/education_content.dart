import 'package:flutter/material.dart';

class EducationContent {
  final String id;
  final String title;
  final String description;
  final String category;
  final String difficulty;
  final String readTime;
  final IconData icon;

  const EducationContent({
    required this.id,
    required this.title,
    required this.description,
    required this.category,
    required this.difficulty,
    required this.readTime,
    required this.icon,
  });
}
