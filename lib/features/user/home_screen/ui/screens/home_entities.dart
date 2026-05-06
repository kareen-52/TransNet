import 'package:flutter/material.dart';

class TimelineStepModel {
  final String label;
  final bool isDone;
  final bool isActive;

  TimelineStepModel({
    required this.label,
    this.isDone = false,
    this.isActive = false,
  });
}



class TransportMethodModel {
  final String title;
  final String price;
  final IconData icon;
  final Color color;

  TransportMethodModel({
    required this.title,
    required this.price,
    required this.icon,
    required this.color,
  });
}
