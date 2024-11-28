CineWorld 🎥
A Flutter-based Movie Discovery App

CineWorld is a mobile application that allows users to discover trending movies, search for specific titles, and view detailed information about their favorite films. Built using the TMDB (The Movie Database) API, CineWorld offers a seamless and engaging user experience for movie enthusiasts.

Features
🌟 Home Screen
Displays a list of trending movies fetched from the TMDB API.
Includes movie posters, titles, and ratings.
Allows users to navigate to detailed information about a selected movie.
🔍 Search Screen
Provides a search bar to find movies by title.
Displays search results dynamically with posters, titles, and ratings.
Error handling for scenarios like "No results found" or API request failures.
🎬 Movie Details Screen
Shows detailed information about a selected movie, including:
Poster, title, rating, release date, and description.
Fetches and displays data dynamically.
API Used
TMDB (The Movie Database) API
Base URL: https://api.themoviedb.org/3
Purpose: Fetch movie data, including trending lists, search results, and detailed movie information.
Authentication: Integrated using an API key.
Endpoints Used:
/trending/movie/week: Fetches trending movies.
/search/movie: Searches for movies based on a query string.
/movie/{movie_id}: Fetches detailed information about a specific movie.
Screenshots
[Include screenshots here of the Home Screen, Search Screen, and Movie Details Screen]
Setup Instructions
Prerequisites
Install Flutter.
Obtain a free TMDB API key from The Movie Database.
Steps to Run
Clone the repository:

bash
Copy code
git clone https://github.com/yourusername/cineworld.git
cd cineworld
Add your TMDB API key:

Open lib/services/movie_service.dart.
Replace YOUR_API_KEY with your TMDB API key.
Install dependencies:

bash
Copy code
flutter pub get
Run the app:

bash
Copy code
flutter run
File Structure
graphql
Copy code
lib/
├── main.dart              # Entry point of the application
├── screens/               # Contains screen widgets
│   ├── home_screen.dart   # Home Screen widget
│   ├── search_screen.dart # Search Screen widget
│   └── movie_details.dart # Movie Details Screen widget
├── services/              # Contains API-related logic
│   └── movie_service.dart # Handles TMDB API requests
└── models/                # (Optional) Contains models for movie data
Challenges Faced
API Integration:

Understanding TMDB API documentation and query parameters.
Resolved by exploring examples and testing different endpoints.
Error Handling:

Handled API failures gracefully using try-catch blocks.
Added user-friendly messages for no results or connection errors.
Responsive UI:

Ensured the layout works well on different screen sizes using Flexible and Expanded widgets.
Search Optimization:

Added a debounce mechanism to reduce API calls for every keystroke.
Future Enhancements
Add user authentication for personalized features.
Introduce movie recommendations based on user preferences.
Expand functionality to include TV shows and celebrity profiles.
Enable offline support for saved movie data.
License
This project is licensed under the MIT License. See the LICENSE file for details.

Author
Steven SHYAKA

GitHub: shyakx
