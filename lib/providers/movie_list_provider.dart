import 'package:flutter/foundation.dart';
import 'package:mini_project_alterra/common/state_enum.dart';
import 'package:mini_project_alterra/domain/entities/movie.dart';
import 'package:mini_project_alterra/domain/usescases/get_now_playing.dart';
import 'package:mini_project_alterra/domain/usescases/get_popular.dart';
import 'package:mini_project_alterra/domain/usescases/get_top_rated.dart';

class MovieListProvider extends ChangeNotifier {
  var _nowPlayingMovies = <Movie>[];
  List<Movie> get nowPlayingMovies => _nowPlayingMovies;

  RequestState _nowPlayingState = RequestState.Empty;
  RequestState get nowPlayingState => _nowPlayingState;

  var _popularMovies = <Movie>[];
  List<Movie> get popularMovies => _popularMovies;

  RequestState _popularState = RequestState.Empty;
  RequestState get popularState => _popularState;

  var _topRatedMovies = <Movie>[];
  List<Movie> get topRatedMovies => _topRatedMovies;

  RequestState _topRatedState = RequestState.Empty;
  RequestState get topRatedState => _topRatedState;

  String _message = '';
  String get message => _message;

  final GetNowPlayingMovies getNowPlayingMovies;
  final GetPopularMovies getPopularMovies;
  final GetTopRatedMovies getTopRatedMovies;

  MovieListProvider({
    required this.getNowPlayingMovies,
    required this.getPopularMovies,
    required this.getTopRatedMovies,
  });

  Future<void> fetchNowPlayingMovies() async {
    _nowPlayingState = RequestState.Loading;
    notifyListeners();

    final result = await getNowPlayingMovies.execute();
    result.fold((failure) {
      _nowPlayingState = RequestState.Error;
      _message = failure.message;
      notifyListeners();
    }, (data) {
      _nowPlayingState = RequestState.Loaded;
      _nowPlayingMovies = data;
      notifyListeners();
    });
  }

  Future<void> fetchPopularMovies() async {
    _popularState = RequestState.Loading;
    notifyListeners();

    final result = await getPopularMovies.execute();
    result.fold((failure) {
      _popularState = RequestState.Error;
      _message = failure.message;
      notifyListeners();
    }, (data) {
      _popularState = RequestState.Loaded;
      _popularMovies = data;
      notifyListeners();
    });
  }

  Future<void> fetchTopRatedMovies() async {
    _topRatedState = RequestState.Loading;
    notifyListeners();

    final result = await getTopRatedMovies.execute();
    result.fold((failure) {
      _topRatedState = RequestState.Error;
      _message = failure.message;
      notifyListeners();
    }, (data) {
      _topRatedState = RequestState.Loaded;
      _topRatedMovies = data;
      notifyListeners();
    });
  }
}