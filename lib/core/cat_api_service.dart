import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/breed.dart';
import '../models/cat_image.dart';

class CatApiService {
  static const _base = 'https://api.thecatapi.com/v1';
  static const _key =
      'live_JBT0Ah0Nt12iyl2IpjQVLDWjcLk0GQwf4zI9wBMfmfejKmcC31mOJp4yJz5TsOUP';

  static Map<String, String> get _headers => {'x-api-key': _key};

  Future<List<Breed>> getBreeds() async {
    final res = await http.get(Uri.parse('$_base/breeds'), headers: _headers);
    if (res.statusCode == 200) {
      final data = jsonDecode(res.body) as List;
      return data.map((e) => Breed.fromJson(e)).toList();
    }
    throw Exception('Error al obtener razas');
  }

  Future<List<CatImage>> getImagesByBreed(
    String breedId, {
    int limit = 10,
  }) async {
    final url = '$_base/images/search?limit=$limit&breed_ids=$breedId';
    final res = await http.get(Uri.parse(url), headers: _headers);
    if (res.statusCode == 200) {
      final data = jsonDecode(res.body) as List;
      return data.map((e) => CatImage.fromJson(e)).toList();
    }
    throw Exception('Error al obtener imágenes');
  }
}
