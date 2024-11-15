
import 'package:flutter/material.dart';
import 'package:xote_eventos/app/pages/search-page/event_card.dart';
import 'package:xote_eventos/app/pages/stores/evento_store.dart';

class PageTemplate extends StatelessWidget {
  final String eventType;
  final EventoStore eventStore;

  const PageTemplate({
    super.key,
    required this.eventType,
    required this.eventStore,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF02142F), 
      appBar: AppBar(
        backgroundColor: const Color(0xFF000D1F), 
        title: Text(
          'Eventos: $eventType',
          style: const TextStyle(
            fontSize: 28.0, 
            fontWeight: FontWeight.bold,
            color: Color(0xFFFFB854),
          ), 
        ),
        elevation: 0,
        centerTitle: true, 
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: FutureBuilder(
        future: eventStore.getEventos(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return const Center(child: Text('Erro ao carregar os eventos', style: TextStyle(color: Colors.white)));
          } else if (eventStore.state.value.isEmpty) {
            return const Center(child: Text('Nenhum evento encontrado', style: TextStyle(color: Colors.white)));
          }

          final events = eventStore.state.value;
          final filteredEvents = events.where((event) => event.type == eventType).toList();

          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 20),
                const Text(
                  'Eventos Disponiveis:',
                  style: TextStyle(
                    fontSize: 20.0, 
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 255, 255, 255), 
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),
                Expanded(
                  child: ListView.builder(
                    itemCount: filteredEvents.length,
                    itemBuilder: (context, index) {
                      final event = filteredEvents[index];
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 16.0), 
                        child: EventCard(event: event), 
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
