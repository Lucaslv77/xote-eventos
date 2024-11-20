import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:xote_eventos/app/pages/stores/evento_store.dart';
import 'package:xote_eventos/app/widgets/pageTemplate.dart';
import '/app/widgets/scroll_menu.dart';

class MenuSection extends StatelessWidget {
  const MenuSection({super.key});

  @override
  Widget build(BuildContext context) {
    final eventStore = Provider.of<EventoStore>(context);

    return FutureBuilder<void>(
      future: eventStore.getEventos(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError) {
          return const Center(
              child: Text('Erro ao carregar os tipos de eventos'));
        }
        final allEvents = eventStore.state;
        if (allEvents.isEmpty) {
          return const Center(child: Text('Nenhum tipo de evento encontrado'));
        }

        final eventTypesList = allEvents.map((e) => e.type).toSet().toList();

        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Menu',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 22.0,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 16.0),
              Center(
                child: ScrollMenu(
                  menuItems: eventTypesList,
                  pages: eventTypesList.map((type) {
                    return PageTemplate(
                        eventType: type, eventStore: eventStore);
                  }).toList(),
                  icons:
                      List.generate(eventTypesList.length, (_) => Icons.event),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
