import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/usecases/tv/get_top_rated_tv.dart';
import 'package:ditonton/presentation/bloc/tv/tv_list/tv_top_rated_bloc.dart';
import 'package:mockito/annotations.dart';
import 'package:ditonton/domain/entities/tv/tv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import 'top_rated_tv_bloc_test.mocks.dart';

@GenerateMocks([GetTopRatedTV, TvTopRatedBloc])
void main() {
  late MockGetTopRatedTv mockGetTopRatedTv;
  late TvTopRatedBloc tvTopRatedBloc;

  setUp(() {
    mockGetTopRatedTv = MockGetTopRatedTv();
    tvTopRatedBloc = TvTopRatedBloc(mockGetTopRatedTv);
  });

  final tvList = <Tv>[];

  test("initial state should be empty", () {
    expect(tvTopRatedBloc.state, TvTopRatedEmpty());
  });

  group(
    'Top Rated Movies BLoC Test',
    () {
      blocTest<TvTopRatedBloc, TvTopRatedState>(
        'Should emit [Loading, Loaded] when data is gotten successfully',
        build: () {
          when(mockGetTopRatedTv.execute())
              .thenAnswer((_) async => Right(tvList));
          return tvTopRatedBloc;
        },
        act: (bloc) => bloc.add(OnFetchTvTopRated()),
        expect: () => [TvTopRatedLoading(), TvTopRatedHasData(tvList)],
        verify: (bloc) {
          verify(mockGetTopRatedTv.execute());
        },
      );

      blocTest<TvTopRatedBloc, TvTopRatedState>(
        'Should emit [Loading, Error] when get top rated is unsuccessful',
        build: () {
          when(mockGetTopRatedTv.execute())
              .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
          return tvTopRatedBloc;
        },
        act: (bloc) => bloc.add(OnFetchTvTopRated()),
        expect: () => [TvTopRatedLoading(), TvTopRatedError('Server Failure')],
        verify: (bloc) {
          verify(mockGetTopRatedTv.execute());
        },
      );
    },
  );
}
