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
    isLoading = true;
    notifyListeners();

    if (_queue.isEmpty) {
      final breeds = await _api.getBreeds();

      if (breeds.isEmpty) {
        hasError = true;
        isLoading = false;
        notifyListeners();
        return;
      }

      _queue.addAll(breeds..shuffle());
    }

    if (_queue.isEmpty) {
      hasError = true;
      isLoading = false;
      notifyListeners();
      return;
    }

    final next = _queue.removeLast();
    final images = await _api.getImagesByBreed(next.id, limit: 1);

    current = next;
    currentImageUrl = images.isNotEmpty ? images.first.url : null;
    isLoading = false;
    hasError = false;
    notifyListeners();
  }

  void vote(bool like) {
    _loadNext();
  }
}
