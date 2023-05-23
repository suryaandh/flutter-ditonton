import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/entities/movie/movie.dart';
import 'package:ditonton/domain/usecases/movie/get_now_playing_movies.dart';
import 'package:ditonton/presentation/bloc/movie/movie_list/movie_now_playing_list_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'now_playing_movie_bloc_test.mocks.dart';

@GenerateMocks([MovieNowPlayingListBloc, GetNowPlayingMovies])
void main() {
  late MockGetNowPlayingMovies mockGetNowPlayingMovies;
  late MovieNowPlayingListBloc movieNowPlayingListBloc;

  setUp(() {
    mockGetNowPlayingMovies = MockGetNowPlayingMovies();
    movieNowPlayingListBloc = MovieNowPlayingListBloc(mockGetNowPlayingMovies);
  });

  final movieList = <Movie>[];

  test("initial state should be empty", () {
    expect(movieNowPlayingListBloc.state, MovieNowPlayingListEmpty());
  });

  group(
    'Now Playing Movies BLoC Test',
    () {
      blocTest<MovieNowPlayingListBloc, MovieNowPlayingListState>(
        'Should emit [Loading, Loaded] when data is gotten successfully',
        build: () {
          when(mockGetNowPlayingMovies.execute())
              .thenAnswer((_) async => Right(movieList));
          return movieNowPlayingListBloc;
        },
        act: (bloc) => bloc.add(OnFetchNowPlayingMovies()),
        expect: () => [
          MovieNowPlayingListLoading(),
          MovieNowPlayingListHasData(movieList)
        ],
        verify: (bloc) {
          verify(mockGetNowPlayingMovies.execute());
        },
      );

      blocTest<MovieNowPlayingListBloc, MovieNowPlayingListState>(
        'Should emit [Loading, Error] when get now playing is unsuccessful',
        build: () {
          when(mockGetNowPlayingMovies.execute())
              .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
          return movieNowPlayingListBloc;
        },
        act: (bloc) => bloc.add(OnFetchNowPlayingMovies()),
        expect: () => [
          MovieNowPlayingListLoading(),
          MovieNowPlayingListError('Server Failure')
        ],
        verify: (bloc) {
          verify(mockGetNowPlayingMovies.execute());
        },
      );
    },
  );
}
