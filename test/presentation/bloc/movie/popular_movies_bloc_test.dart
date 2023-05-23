import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/entities/movie/movie.dart';
import 'package:ditonton/domain/usecases/movie/get_popular_movies.dart';
import 'package:ditonton/presentation/bloc/movie/movie_list/movie_popular_list_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:bloc_test/bloc_test.dart';

import 'popular_movies_bloc_test.mocks.dart';

@GenerateMocks([MoviePopularListBloc, GetPopularMovies])
void main() {
  late MockGetPopularMovies mockGetPopularMovies;
  late MoviePopularListBloc moviePopularListBloc;

  setUp(() {
    mockGetPopularMovies = MockGetPopularMovies();
    moviePopularListBloc = MoviePopularListBloc(mockGetPopularMovies);
  });

  final movieList = <Movie>[];

  test("initial state should be empty", () {
    expect(moviePopularListBloc.state, MoviePopularListEmpty());
  });

  group('Popular Movies BLoC Test', () {
    blocTest<MoviePopularListBloc, MoviePopularListState>(
        'Should emit [loading, loaded] when data is loaded successfully',
        build: () {
          when(mockGetPopularMovies.execute())
              .thenAnswer((_) async => Right(movieList));
          return moviePopularListBloc;
        },
        act: (bloc) => bloc.add(OnFetchPopularList()),
        expect: () =>
            [MoviePopularListLoading(), MoviePopularListHasData(movieList)],
        verify: (bloc) {
          verify(mockGetPopularMovies.execute());
        });

    blocTest<MoviePopularListBloc, MoviePopularListState>(
        'Should emit [loading, error] when data is failed to loaded',
        build: () {
          when(mockGetPopularMovies.execute())
              .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
          return moviePopularListBloc;
        },
        act: (bloc) => bloc.add(OnFetchPopularList()),
        expect: () => [
              MoviePopularListLoading(),
              MoviePopularListError('Server Failure')
            ],
        verify: (bloc) {
          verify(mockGetPopularMovies.execute());
        });
  });
}
