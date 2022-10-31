import 'package:flutter/foundation.dart';
import 'package:mini_project_alterra/common/state_enum.dart';
import 'package:mini_project_alterra/domain/entities/movie.dart';
import 'package:mini_project_alterra/domain/usescases/get_top_rated.dart';

class MovieTopRatedProvider extends ChangeNotifier {
  final GetTopRatedMovies getTopRatedMovies;

  MovieTopRatedProvider(this.getTopRatedMovies);

  RequestState _state = RequestState.Empty;
  RequestState get state => _state;

  List<Movie> _movie = [];
  List<Movie> get movie => _movie;

  String _message = '';
  String get message => _message;

  Future<void> fetchTopRatedMovies() async {
    _state = RequestState.Loading;
    notifyListeners();

    final result = await getTopRatedMovies.execute();

    result.fold(
      (failure) {
        _message = failure.message;
        _state = RequestState.Error;
        notifyListeners();
      },
      (data) {
        _movie = data;
        _state = RequestState.Loaded;
        notifyListeners();
      },
    );
  }
}
