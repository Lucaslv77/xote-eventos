import 'package:flutter/material.dart';
import '/app/data/models/event_model.dart';

class EventInfo extends StatelessWidget {
  final EventModel event;

  const EventInfo({super.key, required this.event});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildEventInfo(Icons.calendar_today, event.formattedDate),
              _buildEventInfo(Icons.access_time, event.time),
            ],
          ),
        ),
        const SizedBox(height: 16.0),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Row(
            children: [
              const Icon(Icons.location_on, size: 18.0, color: Colors.white),
              const SizedBox(width: 4.0),
              Text(
                '${event.local}, ${event.city}',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16.0,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 20.0),
        // Adicionando a descrição do evento
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Descrição:',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 18.0,
                  letterSpacing: 0.5, 
                ),
              ),
              const SizedBox(height: 8.0),
              Text(
                event.description, 
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16.0,
                  height: 1.6, 
                ),
                textAlign: TextAlign.justify, 
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildEventInfo(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, size: 16.0, color: Colors.white),
        const SizedBox(width: 4.0),
        Text(
          text,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 14.0,
            fontWeight: FontWeight.w400, 
          ),
        ),
      ],
    );
  }
}
