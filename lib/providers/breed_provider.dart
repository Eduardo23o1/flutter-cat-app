import 'package:flutter/material.dart';
import '../core/cat_api_service.dart';
import '../models/breed.dart';
import '../models/cat_image.dart';

class BreedProvider extends ChangeNotifier {
  final _api = CatApiService();
  List<Breed> breeds = [];
  Breed? selected;
  List<CatImage> images = [];

  BreedProvider() {
    loadBreeds();
  }

  Future<void> loadBreeds() async {
    breeds = await _api.getBreeds();
    notifyListeners();
  }

  Future<void> selectBreed(Breed? b) async {
    if (b == null) return;
    selected = b;
    images = await _api.getImagesByBreed(b.id);
    notifyListeners();
  }
}
