import 'package:flutter/material.dart';
import '../../domain/entities/calendar_event.dart';
import 'package:intl/intl.dart';

class EventList extends StatelessWidget {
  final List<CalendarEvent> events;

  const EventList({
    super.key,
    required this.events,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: events.length,
      padding: const EdgeInsets.all(8),
      itemBuilder: (context, index) {
        final event = events[index];
        return Card(
          elevation: 2,
          margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 4),
          child: ListTile(
            leading: Container(
              width: 12,
              height: double.infinity,
              color: event.color,
            ),
            title: Text(
              event.title,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 4),
                Text(event.description),
                const SizedBox(height: 4),
                Text(
                  '${DateFormat.Hm().format(event.startTime)} - ${DateFormat.Hm().format(event.endTime)}',
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.secondary,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                if (event.location != null) ...[
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Icon(
                        Icons.location_on,
                        size: 14,
                        color: Theme.of(context).colorScheme.secondary,
                      ),
                      const SizedBox(width: 4),
                      Expanded(
                        child: Text(
                          event.location!,
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.secondary,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ],
            ),
            isThreeLine: true,
            contentPadding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
          ),
        );
      },
    );
  }
}