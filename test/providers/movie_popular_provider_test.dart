import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mini_project_alterra/common/state_enum.dart';
import 'package:mini_project_alterra/domain/entities/movie.dart';
import 'package:mini_project_alterra/providers/movie_popular_provider.dart';
import 'package:mini_project_alterra/screen/popular_screen.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';

import 'movie_popular_provider_test.mocks.dart';

@GenerateMocks([MoviePopularProvider])
void main() {
  late MockMoviePopularProvider mockMoviePopularProvider;

  setUp(() {
    mockMoviePopularProvider = MockMoviePopularProvider();
  });

Widget _makeTestableWidget(Widget body) {
    return ChangeNotifierProvider<MoviePopularProvider>.value(
      value: mockMoviePopularProvider,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets('Page should display center progress bar when loading',
      (WidgetTester tester) async {
    when(mockMoviePopularProvider.state).thenReturn(RequestState.Loading);

    final progressBarFinder = find.byType(CircularProgressIndicator);
    final centerFinder = find.byType(Center);

    await tester.pumpWidget(_makeTestableWidget(const PopularMovieScreen()));

    expect(centerFinder, findsOneWidget);
    expect(progressBarFinder, findsOneWidget);
  });

  testWidgets('Page should display ListView when data is loaded',
      (WidgetTester tester) async {
    when(mockMoviePopularProvider.state).thenReturn(RequestState.Loaded);
    when(mockMoviePopularProvider.movie).thenReturn(<Movie>[]);

    final listViewFinder = find.byType(ListView);

    await tester.pumpWidget(_makeTestableWidget(const PopularMovieScreen()));

    expect(listViewFinder, findsOneWidget);
  });

  testWidgets('Page should display text with message when Error',
      (WidgetTester tester) async {
    when(mockMoviePopularProvider.state).thenReturn(RequestState.Error);
    when(mockMoviePopularProvider.message).thenReturn('Error message');

    final textFinder = find.byKey(const Key('error_message'));

    await tester.pumpWidget(_makeTestableWidget(const PopularMovieScreen()));

    expect(textFinder, findsOneWidget);
  });
}
