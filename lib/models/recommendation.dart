import 'package:flutter/material.dart';

class Recommendation {
  final String id;
  final String title;
  final String description;
  final String priority;
  final String category;
  final IconData icon;

  const Recommendation({
    required this.id,
    required this.title,
    required this.description,
    required this.priority,
    required this.category,
    required this.icon,
  });
}
