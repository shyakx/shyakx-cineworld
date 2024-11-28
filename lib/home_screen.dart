import 'package:flutter/material.dart';
import '../services/movie_service.dart';
import 'details_screen.dart';
import 'search_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final MovieService movieService = MovieService();
  late Future<List<dynamic>> movies;

  @override
  void initState() {
    super.initState();
    movies = movieService.fetchPopularMovies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('CineWorld'),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SearchScreen()),
              );
            },
          )
        ],
      ),
      body: FutureBuilder<List<dynamic>>(
        future: movies,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final movie = snapshot.data![index];
                return ListTile(
                  leading: Image.network(
                    'https://image.tmdb.org/t/p/w200${movie['poster_path']}',
                    fit: BoxFit.cover,
                  ),
                  title: Text(movie['title']),
                  subtitle: Text('Rating: ${movie['vote_average']}'),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DetailsScreen(
                          movieId: movie['id'],
                        ),
                      ),
                    );
                  },
                );
              },
            );
          } else {
            return Center(child: Text('No movies found.'));
          }
        },
      ),
    );
  }
}