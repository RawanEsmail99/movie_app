import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:movie_app/Constants.dart';
import 'package:movie_app/models/PopularResponse.dart';
import 'package:movie_app/models/RecommendedResponse.dart';
import 'package:movie_app/models/ReleasesResponse.dart';
import 'package:movie_app/models/movie_by_genre.dart';
import 'package:movie_app/models/movie_genre_list.dart';

class ApiManager {
  static Future<PopularResponse> getPopular() async {
    //api.themoviedb.org/3/movie/popular
    Uri url = Uri.https('api.themoviedb.org', '/3/movie/popular');
    http.Response response = await http
        .get(url, headers: {'Authorization': Constants.Authorization});
    var json = jsonDecode(response.body);
    PopularResponse popularResponse = PopularResponse.fromJson(json);
    return popularResponse;
  }

  static Future<ReleasesResponse> getReleases() async {
    Uri url = Uri.https('api.themoviedb.org', '/3/movie/upcoming');
    http.Response response = await http
        .get(url, headers: {'Authorization': Constants.Authorization});
    var json = jsonDecode(response.body);
    ReleasesResponse releasesResponse = ReleasesResponse.fromJson(json);
    return releasesResponse;
  }

  static Future<RecommendedResponse> getRecommended() async {
    Uri url = Uri.https('api.themoviedb.org', '/3/movie/top_rated');
    http.Response response = await http
        .get(url, headers: {'Authorization': Constants.Authorization});
    var json = jsonDecode(response.body);
    RecommendedResponse recommendedResponse =
        RecommendedResponse.fromJson(json);
    return recommendedResponse;
  }

  static Future<Map<String, dynamic>>getDetails(int id)async{
    final response = await http.get(Uri.parse('${Constants.baseUrl}$id'),
        headers: {
          'Authorization': 'Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJkYTZmZjA1N2IxZmI4N2ZhYjE1YmNkM2Q1NjkzNzIyZiIsIm5iZiI6MTcyNDYzNzg1Mi44MDA2NTksInN1YiI6IjY2Y2IyMDIwZGQzZjRhMTViNDJkNjE0NiIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.GIP7i44m0vHe9j-nIW3-cNx0ZFhZ-_Xcvd9fUicyF7s',
        }
    );
    if(response.statusCode == 200)
    {
      return json.decode(response.body);
    }
    else{
      throw Exception('Failed to load Top Rated movies');
    }

  }

  static Future<GenreList> fetchGenres() async {
    final response = await http.get(
      Uri.parse('https://api.themoviedb.org/3/genre/movie/list?language=en-US'),
      headers: {
        'Authorization': 'Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJkYTZmZjA1N2IxZmI4N2ZhYjE1YmNkM2Q1NjkzNzIyZiIsIm5iZiI6MTcyNDc2NTI4My45OTQ3Niwic3ViIjoiNjZjYjIwMjBkZDNmNGExNWI0MmQ2MTQ2Iiwic2NvcGVzIjpbImFwaV9yZWFkIl0sInZlcnNpb24iOjF9.5uDjLgS0zELwSSvp6PqCm16RUjx7PTxu8ykHd1i16ok',
      },
    );

    if (response.statusCode == 200) {
      return GenreList.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load genres');
    }
  }

  static Future<MovieList> fetchMoviesByGenres(List<int> genreIds) async {
    final genres = genreIds.join(',');
    final response = await http.get(
      Uri.parse(
          'https://api.themoviedb.org/3/discover/movie?language=en-US&with_genres=$genres'),
      headers: {
        'Authorization':
        'Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJkYTZmZjA1N2IxZmI4N2ZhYjE1YmNkM2Q1NjkzNzIyZiIsIm5iZiI6MTcyNDc2NTI4My45OTQ3Niwic3ViIjoiNjZjYjIwMjBkZDNmNGExNWI0MmQ2MTQ2Iiwic2NvcGVzIjpbImFwaV9yZWFkIl0sInZlcnNpb24iOjF9.5uDjLgS0zELwSSvp6PqCm16RUjx7PTxu8ykHd1i16ok',
      },
    );

    if (response.statusCode == 200) {
      return MovieList.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load movies');
    }
  }


  static Future<List> fetchSimilarMovies(int id)async{
    final response = await http.get(Uri.parse('${Constants.baseUrl}$id/similar'),
        headers: {
          'Authorization': 'Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJkYTZmZjA1N2IxZmI4N2ZhYjE1YmNkM2Q1NjkzNzIyZiIsIm5iZiI6MTcyNDYzNzg1Mi44MDA2NTksInN1YiI6IjY2Y2IyMDIwZGQzZjRhMTViNDJkNjE0NiIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.GIP7i44m0vHe9j-nIW3-cNx0ZFhZ-_Xcvd9fUicyF7s',
        }
    );
    if(response.statusCode == 200)
    {
      Map<String,dynamic> data = jsonDecode(response.body);
      List<dynamic> movie = data['results'];
      return movie;
    }
    else{
      throw Exception('Failed to load Top Rated movies');
    }
  }
}
