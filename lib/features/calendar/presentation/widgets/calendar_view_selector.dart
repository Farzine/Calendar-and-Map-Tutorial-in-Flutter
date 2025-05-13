import 'package:flutter/material.dart';
import '../providers/calendar_provider.dart';

class CalendarViewSelector extends StatelessWidget {
  final CalendarViewType currentView;
  final Function(CalendarViewType) onViewChanged;

  const CalendarViewSelector({
    super.key,
    required this.currentView,
    required this.onViewChanged,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildViewButton(
            context,
            'Day',
            Icons.calendar_view_day,
            CalendarViewType.day,
          ),
          _buildViewButton(
            context,
            'Week',
            Icons.calendar_view_week,
            CalendarViewType.week,
          ),
          _buildViewButton(
            context,
            'Month',
            Icons.calendar_view_month,
            CalendarViewType.month,
          ),
          _buildViewButton(
            context,
            'Timeline',
            Icons.timeline,
            CalendarViewType.timeline,
          ),
          _buildViewButton(
            context,
            'Agenda',
            Icons.view_agenda,
            CalendarViewType.agenda,
          ),
        ],
      ),
    );
  }

  Widget _buildViewButton(
    BuildContext context,
    String label,
    IconData icon,
    CalendarViewType viewType,
  ) {
    final isSelected = currentView == viewType;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: FilledButton.tonal(
        onPressed: () => onViewChanged(viewType),
        style: FilledButton.styleFrom(
          backgroundColor: isSelected
              ? Theme.of(context).colorScheme.primaryContainer
              : Theme.of(context).colorScheme.surfaceVariant,
          foregroundColor: isSelected
              ? Theme.of(context).colorScheme.onPrimaryContainer
              : Theme.of(context).colorScheme.onSurfaceVariant,
        ),
        child: Row(
          children: [
            Icon(icon, size: 18),
            const SizedBox(width: 4),
            Text(label),
          ],
        ),
      ),
    );
  }
}