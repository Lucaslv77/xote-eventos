import 'package:xote_eventos/domain/models/models.dart';

abstract class IEventRepository {
  Future<List<EventModel>> getEventos();
  Future<List<EventModel>> getRecentEvents();
  Future<List<EventModel>> getPaidEvents();
  Future<List<EventModel>> getPaidEventsAsc();
  Future<List<EventModel>> getPaidEventsDesc();
  Future<List<EventModel>> getFreeEvents();
  Future<List<EventModel>> getEventsByType(String eventType);
  Future<List<EventModel>> getEventsByDateAsc();
  Future<List<EventModel>> getEventsByDateDesc();
  Future<List<EventModel>> getEventsByCity(String eventCity);
  Future<List<EventModel>> getFavoritos();
  Future<void> favoriteEvent(String id);
  Future<void> unfavoriteEvent(String id);
}
