import 'package:flutter/material.dart';

class MovieDetailsScreen extends StatelessWidget {
  final dynamic movie;

  MovieDetailsScreen({required this.movie});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(movie['title']),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(  // Wrap the body with SingleChildScrollView to allow scrolling
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Display the movie poster
              movie['poster_path'] != null
                  ? Image.network(
                      'https://image.tmdb.org/t/p/w500${movie['poster_path']}',
                      height: 300,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    )
                  : Container(
                      width: double.infinity,
                      height: 300,
                      color: Colors.grey[300],
                      child: Icon(Icons.movie, size: 50),
                    ),
              SizedBox(height: 16),
              
              // Movie title and other details
              Text(
                movie['title'],
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Text(
                'Release Date: ${movie['release_date']}',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 8),
              Text(
                'Rating: ${movie['vote_average']}',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 16),

              // Overview
              Text(
                'Overview:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Text(
                movie['overview'] ?? 'No overview available.',
                style: TextStyle(fontSize: 16),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
