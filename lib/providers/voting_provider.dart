import 'package:flutter/material.dart';
import '../core/cat_api_service.dart';
import '../models/breed.dart';

class VotingProvider extends ChangeNotifier {
  final _api = CatApiService();
  final List<Breed> _queue = [];

  Breed? current;
  String? currentImageUrl;
  bool isLoading = true;
  bool hasError = false;

  VotingProvider() {
    _loadNext();
  }

  Future<void> _loadNext() async {
    try {
      isLoading = true;
      notifyListeners();

      if (_queue.isEmpty) {
        final breeds = await _api.getBreeds();

        if (breeds.isEmpty) {
          throw Exception('No se obtuvieron razas de la API');
        }

        _queue.addAll(breeds..shuffle());
      }

      if (_queue.isEmpty) {
        throw Exception(
          'La cola de razas está vacía incluso después de recarga',
        );
      }

      final next = _queue.removeLast();

      final images = await _api.getImagesByBreed(next.id, limit: 1);

      if (images.isEmpty || images.first.url.isEmpty) {
        print(
          'No se encontró imagen para ${next.name}. Intentando con otra...',
        );
        return _loadNext(); // 🔁 Reintenta con otra raza
      }

      current = next;
      currentImageUrl = images.first.url;
      hasError = false;
    } catch (e) {
      print('Error en VotingProvider: $e');
      hasError = true;
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  void vote(bool like) {
    _loadNext();
  }
}
