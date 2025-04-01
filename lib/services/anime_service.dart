import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/anime.dart';

class AnimeService {
  final String baseUrl = 'https://api.jikan.moe/v4';

  Future<List<Anime>> getTrendingAnime() async {
    final response = await http.get(Uri.parse('$baseUrl/top/anime'));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return (data['data'] as List)
          .map((animeData) => Anime.fromJson(animeData))
          .toList();
    } else {
      throw Exception('Failed to load trending anime');
    }
  }

  Future<List<Anime>> searchAnime(String query) async {
    final response = await http.get(Uri.parse('$baseUrl/anime?q=$query'));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return (data['data'] as List)
          .map((animeData) => Anime.fromJson(animeData))
          .toList();
    } else {
      throw Exception('Failed to search anime');
    }
  }

  Future<Anime> getAnimeDetails(int id) async {
    final response = await http.get(Uri.parse('$baseUrl/anime/$id'));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return Anime.fromJson(data['data']);  
    } else {
      throw Exception('Failed to load anime details');
    }
  }

  Future<List<Anime>> getAnimeByCategory(String category) async {
    // Map nama kategori ke ID genre Jikan API
    final Map<String, int> genreMap = {
      'Action': 1,
      'Adventure': 2,
      'Comedy': 4,
      'Drama': 8,
      'Fantasy': 10,
      'Horror': 14,
      'Romance': 22,
      'Sci-Fi': 24,
    };

    final genreId =
        genreMap[category] ?? 1; // Default ke Action jika tidak ditemukan

    final response = await http.get(
      Uri.parse('$baseUrl/anime?genres=$genreId'),
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return (data['data'] as List)
          .map((animeData) => Anime.fromJson(animeData))
          .toList();
    } else {
      throw Exception('Failed to load anime by category');
    }
  }
}
