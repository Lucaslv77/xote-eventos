import 'package:flutter/material.dart';
import 'package:xote_eventos/app/data/repositories/event_repository.dart';

import 'package:xote_eventos/domain/repositories/repositories.dart';
import 'package:xote_eventos/domain/models/models.dart';

import '/app/data/http/exceptions.dart';

class EventoStore extends ChangeNotifier {
  final IEventRepository repository = EventRepository();

  bool isLoading = false;
  List<EventModel> state = [];
  String erro = '';

  // Método genérico para obter eventos
  Future<void> _fetchEvents(
    Future<List<EventModel>> Function() fetchFunction,
  ) async {
    isLoading = true;
    erro = ''; // Limpar erros anteriores
    notifyListeners();

    try {
      final result = await fetchFunction();
      state = result;
      notifyListeners(); // Notifique os ouvintes sobre a mudança de estado
    } on NotFoundException catch (e) {
      erro = e.message;
      notifyListeners();
    } catch (e) {
      erro = e.toString();
      notifyListeners();
    } finally {
      isLoading = false;
      notifyListeners();
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
    return state.where((event) {
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
    isLoading = true;
    erro = ''; // Limpar erros anteriores
    notifyListeners();

    try {
      await repository.favoriteEvent(eventId);
      // Atualiza o estado se necessário
      notifyListeners(); // Notifique os ouvintes sobre a mudança de estado
    } on NotFoundException catch (e) {
      erro = e.message;
      notifyListeners();
    } catch (e) {
      erro = e.toString();
      notifyListeners();
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  // Método para desfavoritar um evento
  Future<void> unfavoriteEvent(String eventId) async {
    isLoading = true;
    erro = ''; // Limpar erros anteriores
    notifyListeners();

    try {
      await repository.unfavoriteEvent(eventId);
      // Atualiza o estado se necessário
      notifyListeners(); // Notifique os ouvintes sobre a mudança de estado
    } on NotFoundException catch (e) {
      erro = e.message;
      notifyListeners();
    } catch (e) {
      erro = e.toString();
      notifyListeners();
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
