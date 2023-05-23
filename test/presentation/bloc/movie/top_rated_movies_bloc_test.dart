import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/entities/movie/movie.dart';
import 'package:ditonton/domain/usecases/movie/get_top_rated_movies.dart';
import 'package:ditonton/presentation/bloc/movie/movie_list/movie_top_rated_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'top_rated_movies_bloc_test.mocks.dart';

@GenerateMocks([GetTopRatedMovies, MovieTopRatedListBloc])
void main() {
  late MockGetTopRatedMovies mockGetTopRatedMovies;
  late MovieTopRatedListBloc movieTopRatedListBloc;

  setUp(() {
    mockGetTopRatedMovies = MockGetTopRatedMovies();
    movieTopRatedListBloc = MovieTopRatedListBloc(mockGetTopRatedMovies);
  });

  final movieList = <Movie>[];

  test("initial state should be empty", () {
    expect(movieTopRatedListBloc.state, MovieTopRatedListEmpty());
  });

  group(
    'Top Rated Movies BLoC Test',
    () {
      blocTest<MovieTopRatedListBloc, MovieTopRatedListState>(
        'Should emit [Loading, Loaded] when data is gotten successfully',
        build: () {
          when(mockGetTopRatedMovies.execute())
              .thenAnswer((_) async => Right(movieList));
          return movieTopRatedListBloc;
        },
        act: (bloc) => bloc.add(OnFetchTopRatedList()),
        expect: () =>
            [MovieTopRatedListLoading(), MovieTopRatedListHasData(movieList)],
        verify: (bloc) {
          verify(mockGetTopRatedMovies.execute());
        },
      );

      blocTest<MovieTopRatedListBloc, MovieTopRatedListState>(
        'Should emit [Loading, Error] when get top rated is unsuccessful',
        build: () {
          when(mockGetTopRatedMovies.execute())
              .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
          return movieTopRatedListBloc;
        },
        act: (bloc) => bloc.add(OnFetchTopRatedList()),
        expect: () => [
          MovieTopRatedListLoading(),
          MovieTopRatedListError('Server Failure')
        ],
        verify: (bloc) {
          verify(mockGetTopRatedMovies.execute());
        },
      );
    },
  );
}
