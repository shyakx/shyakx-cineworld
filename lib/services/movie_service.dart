import 'dart:convert';
import 'package:http/http.dart' as http;

class MovieService {
  final String _apiKey = "4b41f6b94c36b9f0e33c6f43fd1ee165";
  final String _baseUrl = "https://api.themoviedb.org/3";

  Future<List<dynamic>> fetchTrendingMovies() async {
    try {
      final response = await http.get(Uri.parse('$_baseUrl/trending/movie/week?api_key=$_apiKey'));
      if (response.statusCode == 200) {
        return json.decode(response.body)['results'];
      } else {
        throw Exception('Failed to fetch trending movies');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  Future<List<dynamic>> searchMovies(String query) async {
    try {
      final response = await http.get(Uri.parse('$_baseUrl/search/movie?api_key=$_apiKey&query=$query'));
      if (response.statusCode == 200) {
        return json.decode(response.body)['results'];
      } else {
        throw Exception('Failed to search movies');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }
}