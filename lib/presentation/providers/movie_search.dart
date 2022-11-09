import 'package:flutter/foundation.dart';
import 'package:mini_project_alterra/common/state_enum.dart';
import 'package:mini_project_alterra/data/entities/movie.dart';
import 'package:mini_project_alterra/presentation/repositories/movie_repository.dart';

class MoviesearchProvider extends ChangeNotifier {
  final SearchMovies searchMovies;

  MoviesearchProvider({required this.searchMovies});

  List<Movie> _search = [];
  List<Movie> get search => _search;

  RequestState _state = RequestState.Empty;
  RequestState get state => _state;

  String _message = '';
  String get message => _message;

  Future<void> fetchMovieSearch(String query) async {
    _state = RequestState.Loading;
    notifyListeners();

    final result = await searchMovies.execute(query);
    result.fold((failure) {
      _state = RequestState.Error;
      _message = failure.message;
      notifyListeners();
    }, (data) {
      _state = RequestState.Loaded;
      _search = data;
      notifyListeners();
    });
  }
}
