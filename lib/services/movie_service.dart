import 'dart:convert';
import 'package:http/http.dart' as http;

class MovieService {
  final String apiKey = '4b41f6b94c36b9f0e33c6f43fd1ee165';
  final String baseUrl = 'https://api.themoviedb.org/3';

  Future<List<dynamic>> fetchPopularMovies() async {
    final response = await http.get(
      Uri.parse('$baseUrl/movie/popular?api_key=$apiKey'),
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return data['results'];
    } else {
      throw Exception('Failed to load movies');
    }
  }

  Future<Map<String, dynamic>> fetchMovieDetails(int movieId) async {
    final response = await http.get(
      Uri.parse('$baseUrl/movie/$movieId?api_key=$apiKey'),
    );

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load movie details');
    }
  }

  Future<List<dynamic>> searchMovies(String query) async {
    final response = await http.get(
      Uri.parse('$baseUrl/search/movie?query=$query&api_key=$apiKey'),
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return data['results'];
    } else {
      throw Exception('Failed to search movies');
    }
  }
}