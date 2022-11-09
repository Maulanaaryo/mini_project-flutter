import 'package:flutter/foundation.dart';
import 'package:mini_project_alterra/common/state_enum.dart';
import 'package:mini_project_alterra/data/entities/movie.dart';
import 'package:mini_project_alterra/presentation/repositories/movie_repository.dart';

class MovieTopRatedProvider extends ChangeNotifier {
  final GetTopRatedMovies getTopRatedMovies;

  MovieTopRatedProvider({required this.getTopRatedMovies});

  List<Movie> _movie = [];
  List<Movie> get movie => _movie;

  RequestState _state = RequestState.Empty;
  RequestState get state => _state;

  String _message = '';
  String get message => _message;

  Future<void> fetchTopRatedMovies() async {
    _state = RequestState.Loading;
    notifyListeners();

    final result = await getTopRatedMovies.execute();

    result.fold(
      (failure) {
        _state = RequestState.Error;
        _message = failure.message;
        notifyListeners();
      },
      (data) {
        _state = RequestState.Loaded;
        _movie = data;
        notifyListeners();
      },
    );
  }
}
