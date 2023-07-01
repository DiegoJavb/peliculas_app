import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:peliculas_app/models/models.dart';

class MoviesProvider extends ChangeNotifier {
  final String _apiKey = 'fb5cd3b52f92c1b77bf6d447055b31a8';
  final String _baseUrl = 'api.themoviedb.org';
  final String _language = 'es-ES';

  List<Movie> onDisplayMovies = [];
  List<Movie> popularMovies = [];
  MoviesProvider() {
    print('Movies provider inicializado');
    getOnDisplayMovies();
    getPopularMovies();
  }

  getOnDisplayMovies() async {
    final url = Uri.https(
      _baseUrl,
      '3/movie/now_playing',
      {
        'api_key': _apiKey,
        'language': _language,
        'page': '1',
      },
    );
    final response = await http.get(url);
    final nowPlayingResponse = NowPlayingResponse.fromRawJson(response.body);
    onDisplayMovies = nowPlayingResponse.results;
    notifyListeners();
  }

  getPopularMovies() async {
    final url = Uri.https(
      _baseUrl,
      '3/movie/popular',
      {
        'api_key': _apiKey,
        'language': _language,
        'page': '1',
      },
    );
    final response = await http.get(url);
    final popularResponse = PopularResponse.fromRawJson(response.body);
    popularMovies = [...popularMovies, ...popularResponse.results];
    print(popularMovies[0]);
    notifyListeners();
  }
}
