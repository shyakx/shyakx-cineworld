import 'package:flutter/material.dart';
import '../services/movie_service.dart';

class DetailsScreen extends StatefulWidget {
  final int movieId;

  DetailsScreen({required this.movieId});

  @override
  _DetailsScreenState createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  final MovieService movieService = MovieService();
  late Future<Map<String, dynamic>> movieDetails;

  @override
  void initState() {
    super.initState();
    movieDetails = movieService.fetchMovieDetails(widget.movieId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Movie Details'),
      ),
      body: FutureBuilder<Map<String, dynamic>>(
        future: movieDetails,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.hasData) {
            final movie = snapshot.data!;
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(15.0),
                      child: Image.network(
                        'https://image.tmdb.org/t/p/w500${movie['poster_path']}',
                        height: 300,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                    ),
                    SizedBox(height: 16),
                    Text(
                      movie['title'],
                      style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Release Date: ${movie['release_date']}',
                      style: TextStyle(fontSize: 16, color: Colors.grey[700]),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Rating: ${movie['vote_average']}',
                      style: TextStyle(fontSize: 16, color: Colors.orange),
                    ),
                    SizedBox(height: 16),
                    Text(
                      'Overview',
                      style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 8),
                    Text(
                      movie['overview'],
                      style: TextStyle(fontSize: 16),
                    ),
                  ],
                ),
              ),
            );
          } else {
            return Center(child: Text('No details found.'));
          }
        },
      ),
    );
  }
}