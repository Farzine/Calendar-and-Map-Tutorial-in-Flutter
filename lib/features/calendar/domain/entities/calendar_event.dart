import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class CalendarEvent extends Equatable {
  final String id;
  final String title;
  final String description;
  final DateTime startTime;
  final DateTime endTime;
  final bool isAllDay;
  final Color color;
  final String? location;

  const CalendarEvent({
    required this.id,
    required this.title,
    required this.description,
    required this.startTime,
    required this.endTime,
    this.isAllDay = false,
    this.color = Colors.blue,
    this.location,
  });

  @override
  List<Object?> get props => [
        id,
        title,
        description,
        startTime,
        endTime,
        isAllDay,
        color,
        location,
      ];

  CalendarEvent copyWith({
    String? id,
    String? title,
    String? description,
    DateTime? startTime,
    DateTime? endTime,
    bool? isAllDay,
    Color? color,
    String? location,
  }) {
    return CalendarEvent(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
      isAllDay: isAllDay ?? this.isAllDay,
      color: color ?? this.color,
      location: location ?? this.location,
    );
  }
}