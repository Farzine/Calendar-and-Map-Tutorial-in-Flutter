import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:infinite_calendar_view/infinite_calendar_view.dart';
import 'package:calendar_view/calendar_view.dart';
import 'package:easy_date_timeline/easy_date_timeline.dart';
import '../providers/calendar_provider.dart';
import '../widgets/calendar_view_selector.dart';
import '../widgets/event_list.dart';
import '../../../map/presentation/pages/map_page.dart';

class CalendarPage extends ConsumerStatefulWidget {
  const CalendarPage({super.key});

  @override
  ConsumerState<CalendarPage> createState() => _CalendarPageState();
}

class _CalendarPageState extends ConsumerState<CalendarPage> {
  final EventController _eventController = EventController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(calendarNotifierProvider.notifier).fetchEvents(DateTime.now());
    });
  }

  @override
  Widget build(BuildContext context) {
    final calendarState = ref.watch(calendarNotifierProvider);
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('Calendar'),
        actions: [
          IconButton(
            icon: const Icon(Icons.map),
            onPressed: () => context.go('/map'),
          ),
        ],
      ),
      body: Column(
        children: [
          CalendarViewSelector(
            currentView: calendarState.currentView,
            onViewChanged: (viewType) {
              ref.read(calendarNotifierProvider.notifier).changeView(viewType);
            },
          ),
          Expanded(
            child: _buildCalendarView(calendarState),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Add new event
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildCalendarView(CalendarState state) {
    switch (state.currentView) {
      case CalendarViewType.day:
        return _buildDayView(state);
      case CalendarViewType.week:
        return _buildWeekView(state);
      case CalendarViewType.month:
        return _buildMonthView(state);
      case CalendarViewType.timeline:
        return _buildTimelineView(state);
      case CalendarViewType.agenda:
        return _buildAgendaView(state);
      default:
        return _buildMonthView(state);
    }
  }

  Widget _buildDayView(CalendarState state) {
    return DayView(
      controller: _eventController,
      eventTileBuilder: (date, events, boundary, startDuration, endDuration) {
        return Container(
          decoration: BoxDecoration(
            color: events.first.color,
            borderRadius: BorderRadius.circular(4),
          ),
          child: Center(
            child: Text(
              events.first.title ?? '',
              style: const TextStyle(color: Colors.white),
            ),
          ),
        );
      },
    );
  }

  Widget _buildWeekView(CalendarState state) {
    return WeekView(
      controller: _eventController,
      eventTileBuilder: (date, events, boundary, startDuration, endDuration) {
        return Container(
          decoration: BoxDecoration(
            color: events.first.color,
            borderRadius: BorderRadius.circular(4),
          ),
          child: Center(
            child: Text(
              events.first.title ?? '',
              style: const TextStyle(color: Colors.white),
            ),
          ),
        );
      },
    );
  }

  Widget _buildMonthView(CalendarState state) {
    return MonthView(
      controller: _eventController,
      onCellTap: (events, date) {
        ref.read(calendarNotifierProvider.notifier).selectDay(date, date);
      },
      // dayBuilder: (context, date, isSelected) {
      //   final events = ref.read(calendarNotifierProvider.notifier).getEventsForDay(date);
      //   return GestureDetector(
      //     onTap: () {
      //       ref.read(calendarNotifierProvider.notifier).selectDay(date, date);
      //     },
      //     child: Container(
      //       decoration: BoxDecoration(
      //         color: isSelected ? Theme.of(context).colorScheme.primaryContainer : null,
      //         borderRadius: BorderRadius.circular(8),
      //         border: isSelected 
      //           ? Border.all(color: Theme.of(context).colorScheme.primary, width: 2)
      //           : null,
      //       ),
      //       child: Column(
      //         mainAxisAlignment: MainAxisAlignment.center,
      //         children: [
      //           Text(
      //             date.day.toString(),
      //             style: TextStyle(
      //               fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
      //             ),
      //           ),
      //           if (events.isNotEmpty)
      //             Container(
      //               margin: const EdgeInsets.only(top: 4),
      //               width: 6,
      //               height: 6,
      //               decoration: BoxDecoration(
      //                 color: events.first.color,
      //                 shape: BoxShape.circle,
      //               ),
      //             ),
      //         ],
      //       ),
      //     ),
      //   );
      // },
    );
  }

  Widget _buildTimelineView(CalendarState state) {
    return EasyDateTimeLine(
      initialDate: state.selectedDay,
      onDateChange: (selectedDate) {
        ref.read(calendarNotifierProvider.notifier).selectDay(selectedDate, selectedDate);
      },
      headerProps: const EasyHeaderProps(
        showHeader: true,
        showMonthPicker: true,
        monthPickerType: MonthPickerType.dropDown,
      ),
      dayProps: const EasyDayProps(
        height: 80,
        width: 60,
        dayStructure: DayStructure.dayNumDayStr,
      ),
      activeColor: Theme.of(context).colorScheme.primary,
      timeLineProps: const EasyTimeLineProps(
        hPadding: 16,
        separatorPadding: 16,
      ),
    );
  }

  Widget _buildAgendaView(CalendarState state) {
    if (state.isLoading) {
      return const Center(child: CircularProgressIndicator());
    } else if (state.errorMessage != null) {
      return Center(child: Text('Error: ${state.errorMessage}'));
    } else if (state.events.isEmpty) {
      return const Center(child: Text('No events scheduled for this day'));
    }
    
    return EventList(events: state.events);
  }
}