import 'package:flutter/material.dart';
import '/app/data/http/exceptions.dart';
import '/app/data/http/http_client.dart';
import '/app/data/models/event_model.dart';
import '/app/data/repositories/event_repository.dart';

class EventoStore extends ChangeNotifier {
  final IEventRepository repository;
  final ValueNotifier<bool> isLoading = ValueNotifier<bool>(false);
  final ValueNotifier<List<EventModel>> state = ValueNotifier<List<EventModel>>([]);
  final ValueNotifier<String> erro = ValueNotifier<String>('');

  EventoStore({required this.repository, required HttpClient client});

  // Método genérico para obter eventos
  Future<void> _fetchEvents(Future<List<EventModel>> Function() fetchFunction) async {
    isLoading.value = true;
    erro.value = ''; // Limpar erros anteriores

    try {
      final result = await fetchFunction();
      state.value = result;
      notifyListeners(); // Notifique os ouvintes sobre a mudança de estado
    } on NotFoundException catch (e) {
      erro.value = e.message;
    } catch (e) {
      erro.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }

  // Método para obter todos os eventos
  Future<void> getEventos() async {
    await _fetchEvents(repository.getEventos);
  }

  Future<void> getFavoritos() async {
    await _fetchEvents(repository.getFavoritos);
  }
  
  // Método para obter eventos recentes
  Future<void> getRecentEventos() async {
    await _fetchEvents(repository.getRecentEvents);
  }

  // Método para obter eventos pagos
  Future<void> getPaidEventos() async {
    await _fetchEvents(repository.getPaidEvents);
  }

  // Método para obter eventos gratuitos
  Future<void> getFreeEventos() async {
    await _fetchEvents(repository.getFreeEvents);
  }

  // Método para obter eventos por tipo
  Future<void> getEventosByType(String eventType) async {
    await _fetchEvents(() => repository.getEventsByType(eventType));
  }

  // Método para buscar eventos pelo título
  List<EventModel> searchEvents(String query) {
    return state.value.where((event) {
      return event.title.toLowerCase().contains(query.toLowerCase());
    }).toList();
  }

  // Métodos para obter eventos por data (asc e desc)
  Future<void> getEventosByDateAsc() async {
    await _fetchEvents(repository.getEventsByDateAsc);
  }

  Future<void> getEventosByDateDesc() async {
    await _fetchEvents(repository.getEventsByDateDesc);
  }

  // Método para obter eventos por cidade
  Future<void> getEventosByCity(String eventCity) async {
    await _fetchEvents(() => repository.getEventsByCity(eventCity));
  }

  // Método para favoritar um evento
  Future<void> favoriteEvent(String eventId) async {
    isLoading.value = true;
    erro.value = ''; // Limpar erros anteriores

    try {
      await repository.favoriteEvent(eventId);
      // Atualiza o estado se necessário
      notifyListeners(); // Notifique os ouvintes sobre a mudança de estado
    } on NotFoundException catch (e) {
      erro.value = e.message;
    } catch (e) {
      erro.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }

  // Método para desfavoritar um evento
  Future<void> unfavoriteEvent(String eventId) async {
    isLoading.value = true;
    erro.value = ''; // Limpar erros anteriores

    try {
      await repository.unfavoriteEvent(eventId);
      // Atualiza o estado se necessário
      notifyListeners(); // Notifique os ouvintes sobre a mudança de estado
    } on NotFoundException catch (e) {
      erro.value = e.message;
    } catch (e) {
      erro.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }
}
