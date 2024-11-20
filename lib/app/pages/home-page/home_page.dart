import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'recent_events_section.dart';
import 'future_events_section.dart';
import 'menu_section.dart';
import '/app/widgets/header.dart';
import '/app/pages/stores/evento_store.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final eventStore = Provider.of<EventoStore>(context);

    return Scaffold(
      appBar: const Header(),
      body: Container(
        width: double.infinity,
        height: MediaQuery.of(context).size.height,
        color: const Color(0xFF02142F),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              MenuSection(),
              const RecentEventsSection(),
              const FutureEventsSection(),
            ],
          ),
        ),
      ),
    );
  }
}
