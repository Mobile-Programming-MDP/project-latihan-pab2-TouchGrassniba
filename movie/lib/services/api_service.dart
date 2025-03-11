import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl = "https://api.themoviedb.org/3";
  static const String apiKey = '10c18dfa53630f23e70c0fa063de6456';

  Future<List<Map<String, dynamic>>> getAllMovies() async {
    final response = await http.get(
      Uri.parse("$baseUrl/movie/now_playing?api_key=$apiKey"),
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return List<Map<String, dynamic>>.from(data['results']);
    } else {
      throw Exception("Failed to load movies");
    }
  }

  Future<List<Map<String, dynamic>>> getTrendingMovies() async {
    final response = await http.get(
      Uri.parse("$baseUrl/trending/movie/week?api_key=$apiKey"),
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return List<Map<String, dynamic>>.from(data['results']);
    } else {
      throw Exception("Failed to load trending movies");
    }
  }

  Future<List<Map<String, dynamic>>> getPopularMovies() async {
    final response = await http.get(
      Uri.parse("$baseUrl/movie/popular?api_key=$apiKey"),
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return List<Map<String, dynamic>>.from(data['results']);
    } else {
      throw Exception("Failed to load popular movies");
    }
  }

  Future<List<Map<String, dynamic>>> searchMovies(String query) async {
    final encodedQuery = Uri.encodeQueryComponent(query.trim()); // Handle spaces
    final response = await http.get(
      Uri.parse("$baseUrl/search/movie?query=$encodedQuery&api_key=$apiKey"),
    );

    print("Search API Response: ${response.body}"); // Debugging

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      print("Decoded Data: $data"); // Debugging
      return List<Map<String, dynamic>>.from(data['results']);
    } else {
      throw Exception("Failed to search movies");
    }
  }
}
