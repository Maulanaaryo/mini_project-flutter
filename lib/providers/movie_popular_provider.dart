import 'package:flutter/foundation.dart';
import 'package:mini_project_alterra/common/state_enum.dart';
import 'package:mini_project_alterra/domain/entities/movie.dart';
import 'package:mini_project_alterra/domain/usescases/get_popular.dart';

class MoviePopularProvider extends ChangeNotifier {
  final GetPopularMovies getPopularMovies;

  MoviePopularProvider(this.getPopularMovies);

  RequestState _state = RequestState.Empty;
  RequestState get state => _state;

  List<Movie> _movie = [];
  List<Movie> get movie => _movie;

  String _message = '';
  String get message => _message;

  Future<void> fetchPopularMovies() async {
    _state = RequestState.Loading;
    notifyListeners();

    final result = await getPopularMovies.execute();

    result.fold(
      (failure) {
        _message = failure.message;
        _state = RequestState.Error;
        notifyListeners();
      },
      (moviesData) {
        _movie = moviesData;
        _state = RequestState.Loaded;
        notifyListeners();
      },
    );
  }
}