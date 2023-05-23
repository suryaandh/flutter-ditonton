import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/entities/tv/tv.dart';
import 'package:ditonton/domain/usecases/tv/get_now_playing_tv.dart';
import 'package:ditonton/presentation/bloc/tv/tv_list/tv_now_playing_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'tv_now_playing_bloc_test.mocks.dart';

@GenerateMocks([TvNowPlayingBloc, GetNowPlayingTV])
void main() {
  late MockGetNowPlayingTv mockGetNowPlayingTv;
  late TvNowPlayingBloc tvNowPlayingBloc;

  setUp(() {
    mockGetNowPlayingTv = MockGetNowPlayingTv();
    tvNowPlayingBloc = TvNowPlayingBloc(mockGetNowPlayingTv);
  });

  final tvList = <Tv>[];

  test("initial state should be empty", () {
    expect(tvNowPlayingBloc.state, TvNowPlayingEmpty());
  });

  group(
    'On Air Tv BLoC Test',
    () {
      blocTest<TvNowPlayingBloc, TvNowPlayingState>(
        'Should emit [Loading, Loaded] when data is gotten successfully',
        build: () {
          when(mockGetNowPlayingTv.execute())
              .thenAnswer((_) async => Right(tvList));
          return tvNowPlayingBloc;
        },
        act: (bloc) => bloc.add(OnFetchTvNowPlaying()),
        expect: () => [TvNowPlayingLoading(), TvNowPlayingHasData(tvList)],
        verify: (bloc) {
          verify(mockGetNowPlayingTv.execute());
        },
      );

      blocTest<TvNowPlayingBloc, TvNowPlayingState>(
        'Should emit [Loading, Error] when get now playing is unsuccessful',
        build: () {
          when(mockGetNowPlayingTv.execute())
              .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
          return tvNowPlayingBloc;
        },
        act: (bloc) => bloc.add(OnFetchTvNowPlaying()),
        expect: () =>
            [TvNowPlayingLoading(), TvNowPlayingError('Server Failure')],
        verify: (bloc) {
          verify(mockGetNowPlayingTv.execute());
        },
      );
    },
  );
}
