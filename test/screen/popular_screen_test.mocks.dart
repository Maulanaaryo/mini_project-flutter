// Mocks generated by Mockito 5.3.2 from annotations
// in mini_project_alterra/test/screen/popular_screen_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i6;
import 'dart:ui' as _i7;

import 'package:mini_project_alterra/common/state_enum.dart' as _i5;
import 'package:mini_project_alterra/data/entities/movie.dart' as _i4;
import 'package:mini_project_alterra/presentation/repositories/movie_repository.dart'
    as _i2;
import 'package:mini_project_alterra/presentation/providers/movie_popular_provider.dart'
    as _i3;
import 'package:mockito/mockito.dart' as _i1;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types
// ignore_for_file: subtype_of_sealed_class

class _FakeGetPopularMovies_0 extends _i1.SmartFake
    implements _i2.GetPopularMovies {
  _FakeGetPopularMovies_0(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

/// A class which mocks [MoviePopularProvider].
///
/// See the documentation for Mockito's code generation for more information.
class MockMoviePopularProvider extends _i1.Mock
    implements _i3.MoviePopularProvider {
  MockMoviePopularProvider() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i2.GetPopularMovies get getPopularMovies => (super.noSuchMethod(
        Invocation.getter(#getPopularMovies),
        returnValue: _FakeGetPopularMovies_0(
          this,
          Invocation.getter(#getPopularMovies),
        ),
      ) as _i2.GetPopularMovies);
  @override
  List<_i4.Movie> get movie => (super.noSuchMethod(
        Invocation.getter(#movie),
        returnValue: <_i4.Movie>[],
      ) as List<_i4.Movie>);
  @override
  _i5.RequestState get state => (super.noSuchMethod(
        Invocation.getter(#state),
        returnValue: _i5.RequestState.Empty,
      ) as _i5.RequestState);
  @override
  String get message => (super.noSuchMethod(
        Invocation.getter(#message),
        returnValue: '',
      ) as String);
  @override
  bool get hasListeners => (super.noSuchMethod(
        Invocation.getter(#hasListeners),
        returnValue: false,
      ) as bool);
  @override
  _i6.Future<void> fetchPopularMovies() => (super.noSuchMethod(
        Invocation.method(
          #fetchPopularMovies,
          [],
        ),
        returnValue: _i6.Future<void>.value(),
        returnValueForMissingStub: _i6.Future<void>.value(),
      ) as _i6.Future<void>);
  @override
  void addListener(_i7.VoidCallback? listener) => super.noSuchMethod(
        Invocation.method(
          #addListener,
          [listener],
        ),
        returnValueForMissingStub: null,
      );
  @override
  void removeListener(_i7.VoidCallback? listener) => super.noSuchMethod(
        Invocation.method(
          #removeListener,
          [listener],
        ),
        returnValueForMissingStub: null,
      );
  @override
  void dispose() => super.noSuchMethod(
        Invocation.method(
          #dispose,
          [],
        ),
        returnValueForMissingStub: null,
      );
  @override
  void notifyListeners() => super.noSuchMethod(
        Invocation.method(
          #notifyListeners,
          [],
        ),
        returnValueForMissingStub: null,
      );
}
