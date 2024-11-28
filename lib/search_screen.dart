import 'package:flutter/material.dart';
import '../services/movie_service.dart';
import 'movie_details.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final MovieService movieService = MovieService();
  final TextEditingController _searchController = TextEditingController();
  Future<List<dynamic>>? searchResults;

  void searchMovies(String query) {
    setState(() {
      if (query.isNotEmpty) {
        searchResults = movieService.searchMovies(query);
      } else {
        searchResults = null;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Search Movies'),
      ),
      resizeToAvoidBottomInset: true, // Ensure proper layout when keyboard appears
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(), // Dismiss the keyboard when tapping outside
        child: SingleChildScrollView( // Wrap the whole body in a scrollable view
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                // Search TextField
                TextField(
                  controller: _searchController,
                  decoration: InputDecoration(
                    labelText: 'Search for movies...',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.search),
                  ),
                  onChanged: searchMovies,
                ),
                SizedBox(height: 16),
                // Handle search results display
                searchResults == null
                    ? Center(child: Text('Start typing to search for movies.'))
                    : FutureBuilder<List<dynamic>>(
                        future: searchResults,
                        builder: (context, snapshot) {
                          if (snapshot.connectionState == ConnectionState.waiting) {
                            return Center(child: CircularProgressIndicator());
                          } else if (snapshot.hasError) {
                            return Center(child: Text('Error: ${snapshot.error}'));
                          } else if (snapshot.hasData) {
                            return snapshot.data!.isEmpty
                                ? Center(child: Text('No results found.'))
                                : ListView.builder(
                                    shrinkWrap: true, // Make the ListView take only necessary space
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
                                        onTap: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (_) => MovieDetailsScreen(movie: movie),
                                            ),
                                          );
                                        },
                                      );
                                    },
                                  );
                          } else {
                            return Center(child: Text('No results found.'));
                          }
                        },
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}