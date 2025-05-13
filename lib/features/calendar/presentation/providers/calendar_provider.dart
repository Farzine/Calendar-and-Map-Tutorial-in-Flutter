import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:flutter/material.dart';
import '../../domain/entities/calendar_event.dart';

part 'calendar_provider.g.dart';

enum CalendarViewType {
  day,
  week,
  month,
  timeline,
  agenda,
}

class CalendarState {
  final bool isLoading;
  final List<CalendarEvent> events;
  final String? errorMessage;
  final CalendarViewType currentView;
  final DateTime selectedDay;
  final DateTime focusedDay;

  CalendarState({
    this.isLoading = false,
    this.events = const [],
    this.errorMessage,
    this.currentView = CalendarViewType.month,
    required this.selectedDay,
    required this.focusedDay,
  });

  CalendarState copyWith({
    bool? isLoading,
    List<CalendarEvent>? events,
    String? errorMessage,
    CalendarViewType? currentView,
    DateTime? selectedDay,
    DateTime? focusedDay,
  }) {
    return CalendarState(
      isLoading: isLoading ?? this.isLoading,
      events: events ?? this.events,
      errorMessage: errorMessage,
      currentView: currentView ?? this.currentView,
      selectedDay: selectedDay ?? this.selectedDay,
      focusedDay: focusedDay ?? this.focusedDay,
    );
  }
}

@riverpod
class CalendarNotifier extends _$CalendarNotifier {
  @override
  CalendarState build() {
    final now = DateTime.now();
    return CalendarState(
      selectedDay: now,
      focusedDay: now,
    );
  }

  Future<void> fetchEvents(DateTime date) async {
    state = state.copyWith(isLoading: true, errorMessage: null);
    
    try {
      // Simulating API call
      await Future.delayed(const Duration(seconds: 1));
      
      // Mock events data
      final events = [
        CalendarEvent(
          id: '1',
          title: 'Team Meeting',
          description: 'Weekly team sync',
          startTime: DateTime(date.year, date.month, date.day, 10, 0),
          endTime: DateTime(date.year, date.month, date.day, 11, 30),
          color: Colors.blue,
        ),
        CalendarEvent(
          id: '2',
          title: 'Project Review',
          description: 'Review Q1 progress',
          startTime: DateTime(date.year, date.month, date.day, 14, 0),
          endTime: DateTime(date.year, date.month, date.day, 15, 0),
          color: Colors.green,
        ),
        CalendarEvent(
          id: '3',
          title: 'Client Call',
          description: 'Discuss new requirements',
          startTime: DateTime(date.year, date.month, date.day, 16, 0),
          endTime: DateTime(date.year, date.month, date.day, 16, 30),
          color: Colors.orange,
        ),
      ];
      
      state = state.copyWith(
        isLoading: false, 
        events: events,
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: 'Failed to fetch events: ${e.toString()}',
      );
    }
  }

  void changeView(CalendarViewType viewType) {
    state = state.copyWith(currentView: viewType);
  }

  void selectDay(DateTime selectedDay, DateTime focusedDay) {
    state = state.copyWith(
      selectedDay: selectedDay, 
      focusedDay: focusedDay,
    );
    fetchEvents(selectedDay);
  }

  List<CalendarEvent> getEventsForDay(DateTime day) {
    return state.events.where((event) =>
        event.startTime.year == day.year &&
        event.startTime.month == day.month &&
        event.startTime.day == day.day).toList();
  }
}