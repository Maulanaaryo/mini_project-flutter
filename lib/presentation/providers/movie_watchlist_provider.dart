import 'package:flutter/foundation.dart';
import 'package:mini_project_alterra/common/state_enum.dart';
import 'package:mini_project_alterra/data/entities/movie.dart';
import 'package:mini_project_alterra/presentation/repositories/movie_repository.dart';

class MovieWatchlistProvider extends ChangeNotifier {
  final GetWatchlistMovies getWatchlistMovies;

  MovieWatchlistProvider({required this.getWatchlistMovies});

  var _moviesWatchlist = <Movie>[];
  List<Movie> get moviesWatchlist => _moviesWatchlist;

  var _watchlistState = RequestState.Empty;
  RequestState get watchlistState => _watchlistState;

  String _message = '';
  String get message => _message;

  Future<void> fetchWatchlistMovies() async {
    _watchlistState = RequestState.Loading;
    notifyListeners();

    final result = await getWatchlistMovies.execute();
    result.fold((failure) {
      _watchlistState = RequestState.Error;
      _message = failure.message;
      notifyListeners();
    }, (data) {
      _watchlistState = RequestState.Loaded;
      _moviesWatchlist = data;
      notifyListeners();
    });
  }
}
