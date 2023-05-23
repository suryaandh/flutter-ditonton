import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/usecases/tv/get_popular_tv.dart';
import 'package:ditonton/presentation/bloc/tv/tv_list/tv_popular_bloc.dart';
import 'package:mockito/annotations.dart';
import 'package:ditonton/domain/entities/tv/tv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import 'tv_popular_bloc_test.mocks.dart';

@GenerateMocks([GetPopularTV, TvPopularBloc])
void main() {
  late MockGetPopularTv mockGetPopularTv;
  late TvPopularBloc tvPopularBloc;

  setUp(() {
    mockGetPopularTv = MockGetPopularTv();
    tvPopularBloc = TvPopularBloc(mockGetPopularTv);
  });

  final TvList = <Tv>[];

  test("initial state should be empty", () {
    expect(tvPopularBloc.state, TvPopularEmpty());
  });

  group(
    'Popular Tv BLoC Test',
    () {
      blocTest<TvPopularBloc, TvPopularState>(
        'Should emit [Loading, Loaded] when data is gotten successfully',
        build: () {
          when(mockGetPopularTv.execute())
              .thenAnswer((_) async => Right(TvList));
          return tvPopularBloc;
        },
        act: (bloc) => bloc.add(OnFetchPopularTv()),
        expect: () => [TvPopularLoading(), TvPopularHasData(TvList)],
        verify: (bloc) {
          verify(mockGetPopularTv.execute());
        },
      );

      blocTest<TvPopularBloc, TvPopularState>(
        'Should emit [Loading, Error] when get popular is unsuccessful',
        build: () {
          when(mockGetPopularTv.execute())
              .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
          return tvPopularBloc;
        },
        act: (bloc) => bloc.add(OnFetchPopularTv()),
        expect: () => [TvPopularLoading(), TvPopularError('Server Failure')],
        verify: (bloc) {
          verify(mockGetPopularTv.execute());
        },
      );
    },
  );
}
