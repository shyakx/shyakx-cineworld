import 'package:flutter/material.dart';
import '../services/movie_service.dart';
import 'dart:async';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final MovieService movieService = MovieService();
  final TextEditingController _searchController = TextEditingController();
  Timer? _debounce;
  Future<List<dynamic>>? searchResults;

  void searchMovies() {
    if (_debounce?.isActive ?? false) _debounce?.cancel();
    _debounce = Timer(Duration(milliseconds: 500), () {
      setState(() {
        searchResults = movieService.searchMovies(_searchController.text);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Search Movies'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _searchController,
              decoration: InputDecoration(
                labelText: 'Search for movies...',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.search),
              ),
              onChanged: (query) => searchMovies(),
            ),
            SizedBox(height: 16),
            Expanded(
              child: FutureBuilder<List<dynamic>>(
                future: searchResults,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(
                      child: Text(
                        'Error: ${snapshot.error}',
                        style: TextStyle(color: Colors.red),
                      ),
                    );
                  } else if (snapshot.hasData) {
                    if (snapshot.data!.isEmpty) {
                      return Center(child: Text('No movies found.'));
                    }
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
                              : Container(
                                  width: 50,
                                  height: 75,
                                  color: Colors.grey[300],
                                  child: Icon(Icons.movie),
                                ),
                          title: Text(movie['title']),
                          subtitle: Text('Rating: ${movie['vote_average']}'),
                        );
                      },
                    );
                  } else {
                    return Center(child: Text('No movies found.'));
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _debounce?.cancel();
    super.dispose();
  }
}