import 'package:flutter/material.dart';
import 'package:xote_eventos/app/pages/search-page/event_card.dart';
import '/app/data/models/event_model.dart';
import '/app/pages/stores/evento_store.dart';
import '/app/data/http/http_client.dart';
import '/app/data/repositories/event_repository.dart';

class FutureEventsSection extends StatefulWidget {
  const FutureEventsSection({super.key});

  @override
  FutureEventsSectionState createState() => FutureEventsSectionState();
}

class FutureEventsSectionState extends State<FutureEventsSection> {
  late final EventoStore _eventoStore;
  int _visibleItemCount = 2;

  @override
  void initState() {
    super.initState();
    _initializeStore();
    _fetchFutureEvents();
  }

  void _initializeStore() {
    final httpClient = HttpClient();
    final repository = EventRepository(client: httpClient);
    _eventoStore = EventoStore(repository: repository, client: httpClient);
  }

  Future<void> _fetchFutureEvents() async {
    await _eventoStore.getEventosByDateDesc();
  }

  Widget _buildError() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(_eventoStore.erro.value, textAlign: TextAlign.center),
          const SizedBox(height: 8.0),
          ElevatedButton(
            onPressed: _fetchFutureEvents,
            child: const Text('Tentar Novamente'),
          ),
        ],
      ),
    );
  }

  Widget _buildLoading() {
    return const Center(child: CircularProgressIndicator());
  }

  Widget _buildEventList(List<EventModel> eventos) {
    final isExpandable = _visibleItemCount < eventos.length;

    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: isExpandable ? _visibleItemCount + 1 : eventos.length,
      itemBuilder: (context, index) {
        if (isExpandable && index == _visibleItemCount) {
          return TextButton(
            onPressed: () {
              setState(() {
                _visibleItemCount =
                    (_visibleItemCount + 2).clamp(0, eventos.length);
              });
            },
            child: const Text(
              'Ver Mais',
              style: TextStyle(color: Colors.blue),
            ),
          );
        }

        return EventCard(event: eventos[index]);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<List<EventModel>>(
      valueListenable: _eventoStore.state,
      builder: (context, eventos, _) {
        if (_eventoStore.isLoading.value) {
          return _buildLoading();
        }

        if (_eventoStore.erro.value.isNotEmpty) {
          return _buildError();
        }

        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Eventos Futuros',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 22.0,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 8.0),
              _buildEventList(eventos),
            ],
          ),
        );
      },
    );
  }
}
