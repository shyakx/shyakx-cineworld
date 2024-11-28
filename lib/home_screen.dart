import 'package:flutter/material.dart';
import '../services/movie_service.dart';
import 'search_screen.dart';
import 'movie_details.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final MovieService movieService = MovieService();
  late Future<List<dynamic>> trendingMovies;

  @override
  void initState() {
    super.initState();
    trendingMovies = movieService.fetchTrendingMovies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('CineWorld'),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => SearchScreen())),
          ),
        ],
      ),
      body: FutureBuilder<List<dynamic>>(
        future: trendingMovies,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No movies found.'));
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final movie = snapshot.data![index];
                return ListTile(
                  leading: movie['poster_path'] != null
                      ? Image.network(
                          'https://image.tmdb.org/t/p/w200${movie['poster_path']}',
                          fit: BoxFit.cover,
                        )
                      : Container(width: 50, height: 75, color: Colors.grey[300], child: Icon(Icons.movie)),
                  title: Text(movie['title']),
                  subtitle: Text('Rating: ${movie['vote_average']}'),
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => MovieDetailsScreen(movie: movie),
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
