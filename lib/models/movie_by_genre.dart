class Movie {
  final int id;
  final double vote_average;
  final String title;
  final String overview;
  final String posterPath;

  Movie({
    required this.vote_average,
    required this.id,
    required this.title,
    required this.overview,
    required this.posterPath,
  });

  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
      id: json['id'],
      vote_average: json['vote_average'],
      title: json['title'],
      overview: json['overview'],
      posterPath: json['poster_path'] ?? '', // Handle null poster paths
    );
  }
}

class MovieList {
  final List<Movie> movies;

  MovieList({required this.movies});

  factory MovieList.fromJson(Map<String, dynamic> json) {
    return MovieList(
      movies: List<Movie>.from(
        json['results'].map((movie) => Movie.fromJson(movie)),
      ),
    );
  }
}