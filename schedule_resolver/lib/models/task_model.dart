import 'package:flutter/material.dart';

class TaskModel {
  final String id;
  final String title;
  final String category;
  final DateTime date;
  final TimeOfDay startTime;
  final TimeOfDay endTime;
  final int urgency;
  final int importance;
  final double estimatedEffortHours;
  final String energyLevel;

  TaskModel({
    required this.id,
    required this.title,
    required this.category,
    required this.date,
    required this.startTime,
    required this.endTime,
    required this.urgency,
    required this.importance,
    required this.estimatedEffortHours,
    required this.energyLevel,
  });

  // Ginagamit para i-save ang data (e.g., sa Database o SharedPreferences)
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'category': category,
      'date': date.toIso8601String().split('T').first,
      // Inayos: Inalis ang backslash, pinalitan ang .minutes ng .minute, at nilagyan ng padding
      'startTime': '${startTime.hour.toString().padLeft(2, '0')}:${startTime.minute.toString().padLeft(2, '0')}',
      'endTime': '${endTime.hour.toString().padLeft(2, '0')}:${endTime.minute.toString().padLeft(2, '0')}',
      'urgency': urgency,
      'importance': importance,
      'estimatedEffortHours': estimatedEffortHours,
      'energyLevel': energyLevel,
    };
  }

  // MAHALAGA: Ito ang kailangan para ma-fetch ang data at ma-display sa UI
  factory TaskModel.fromJson(Map<String, dynamic> json) {
    // Helper function para gawing TimeOfDay ang String na "HH:mm"
    TimeOfDay parseTime(String timeStr) {
      final parts = timeStr.split(':');
      return TimeOfDay(
        hour: int.parse(parts[0]),
        minute: int.parse(parts[1]),
      );
    }

    return TaskModel(
      id: json['id'],
      title: json['title'],
      category: json['category'],
      date: DateTime.parse(json['date']),
      startTime: parseTime(json['startTime']),
      endTime: parseTime(json['endTime']),
      urgency: json['urgency'],
      importance: json['importance'],
      estimatedEffortHours: (json['estimatedEffortHours'] as num).toDouble(),
      energyLevel: json['energyLevel'],
    );
  }
}