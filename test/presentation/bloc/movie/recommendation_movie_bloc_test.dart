import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/entities/movie/movie.dart';
import 'package:ditonton/domain/usecases/movie/get_movie_recommendations.dart';
import 'package:ditonton/presentation/bloc/movie/movie_recommendations/movie_recommendations_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'recommendation_movie_bloc_test.mocks.dart';

@GenerateMocks([MovieRecommendationsBloc, GetMovieRecommendations])
void main() {
  late MockGetMovieRecommendations mockGetMovieRecommendations;
  late MovieRecommendationsBloc movieRecommendationsBloc;

  setUp(() {
    mockGetMovieRecommendations = MockGetMovieRecommendations();
    movieRecommendationsBloc = MovieRecommendationsBloc(
      getMovieRecommendations: mockGetMovieRecommendations,
    );
  });

  test("initial state should be empty", () {
    expect(movieRecommendationsBloc.state, MovieRecommendationsEmpty());
  });

  const movieId = 1;
  final movieList = <Movie>[];

  blocTest<MovieRecommendationsBloc, MovieRecommendationsState>(
    'Should emit [Loading, Loaded] when data is gotten successfully',
    build: () {
      when(mockGetMovieRecommendations.execute(movieId))
          .thenAnswer((_) async => Right(movieList));
      return movieRecommendationsBloc;
    },
    act: (bloc) => bloc.add(OnFetchMovieRecommendations(movieId)),
    expect: () =>
        [MovieRecommendationsLoading(), MovieRecommedationsHasData(movieList)],
    verify: (bloc) {
      verify(mockGetMovieRecommendations.execute(movieId));
    },
  );

  group(
    'Recommendation Movies BLoC Test',
    () {
      blocTest<MovieRecommendationsBloc, MovieRecommendationsState>(
        'Should emit [Loading, Error] when get recommendation is unsuccessful',
        build: () {
          when(mockGetMovieRecommendations.execute(movieId))
              .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
          return movieRecommendationsBloc;
        },
        act: (bloc) => bloc.add(OnFetchMovieRecommendations(movieId)),
        expect: () => [
          MovieRecommendationsLoading(),
          MovieRecommendationsError('Server Failure')
        ],
        verify: (bloc) {
          verify(mockGetMovieRecommendations.execute(movieId));
        },
      );
    },
  );
}
