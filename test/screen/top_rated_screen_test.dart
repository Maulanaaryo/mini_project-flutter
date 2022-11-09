import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mini_project_alterra/common/state_enum.dart';
import 'package:mini_project_alterra/data/entities/movie.dart';
import 'package:mini_project_alterra/presentation/screen/top_rated_screen.dart';
import 'package:mini_project_alterra/presentation/providers/movie_top_provider.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';

import 'top_rated_screen_test.mocks.dart';

@GenerateMocks([MovieTopRatedProvider])
void main() {
  late MockMovieTopRatedProvider mockNotifier;

  setUp(() {
    mockNotifier = MockMovieTopRatedProvider();
  });

  Widget _makeTestableWidget(Widget body) {
    return ChangeNotifierProvider<MovieTopRatedProvider>.value(
      value: mockNotifier,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets('Page should display progress bar when loading',
      (WidgetTester tester) async {
    when(mockNotifier.state).thenReturn(RequestState.Loading);

    final progressFinder = find.byType(CircularProgressIndicator);
    final centerFinder = find.byType(Center);

    await tester.pumpWidget(_makeTestableWidget(const TopRatedMovieScreen()));

    expect(centerFinder, findsOneWidget);
    expect(progressFinder, findsOneWidget);
  });

  testWidgets('Page should display when data is loaded',
      (WidgetTester tester) async {
    when(mockNotifier.state).thenReturn(RequestState.Loaded);
    when(mockNotifier.movie).thenReturn(<Movie>[]);

    final listViewFinder = find.byType(ListView);

    await tester.pumpWidget(_makeTestableWidget(const TopRatedMovieScreen()));

    expect(listViewFinder, findsOneWidget);
  });

  testWidgets('Page should display text with message when Error',
      (WidgetTester tester) async {
    when(mockNotifier.state).thenReturn(RequestState.Error);
    when(mockNotifier.message).thenReturn('Error message');

    final textFinder = find.byKey(const Key('error_message'));

    await tester.pumpWidget(_makeTestableWidget(const TopRatedMovieScreen()));

    expect(textFinder, findsOneWidget);
  });
}