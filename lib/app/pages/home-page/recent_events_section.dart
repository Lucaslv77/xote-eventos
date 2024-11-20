import 'package:flutter/material.dart';
import 'package:xote_eventos/app/pages/home-page/recent_event_card_design.dart';
import '/app/data/models/event_model.dart';
import '/app/data/http/http_client.dart';
import '/app/data/repositories/event_repository.dart';
import '/app/pages/detail-page/event_detail_page.dart';
import '/app/pages/stores/evento_store.dart';

class RecentEventsSection extends StatefulWidget {
  const RecentEventsSection({super.key});

  @override
  RecentEventsSectionState createState() => RecentEventsSectionState();
}

class RecentEventsSectionState extends State<RecentEventsSection> {
  late final EventoStore _eventoStore;

  @override
  void initState() {
    super.initState();
    final httpClient = HttpClient();
    final repository = EventRepository(client: httpClient);
    _eventoStore = EventoStore(repository: repository, client: httpClient);
    _fetchRecentEvents();
  }

  Future<void> _fetchRecentEvents() async {
    await _eventoStore.getRecentEventos();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<List<EventModel>>(
      valueListenable: _eventoStore.state,
      builder: (context, eventos, _) {
        if (_eventoStore.isLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (_eventoStore.erro.value.isNotEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(_eventoStore.erro.value),
                const SizedBox(height: 8.0),
                ElevatedButton(
                  onPressed: _fetchRecentEvents,
                  child: const Text('Tentar Novamente'),
                ),
              ],
            ),
          );
        }

        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Mais Recentes',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 24.0,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 14.0),
              SizedBox(
                height: 200,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: eventos.length,
                  itemBuilder: (context, index) {
                    final event = eventos[index];
                    return RecentEventCardDesign(
                      event: event,
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => EventDetailPage(event: event),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
