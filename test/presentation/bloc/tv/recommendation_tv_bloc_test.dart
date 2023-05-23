import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/entities/tv/tv.dart';
import 'package:ditonton/domain/usecases/tv/get_tv_recommendations.dart';
import 'package:ditonton/presentation/bloc/tv/tv_recommendations/tv_recommendations_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'recommendation_tv_bloc_test.mocks.dart';

@GenerateMocks([TvRecommendationsBloc, GetTVRecommendations])
void main() {
  late MockGetTvRecommendations mockGetTvRecommendation;
  late TvRecommendationsBloc tvRecommendationsBloc;

  setUp(() {
    mockGetTvRecommendation = MockGetTvRecommendations();
    tvRecommendationsBloc = TvRecommendationsBloc(
      getTvRecommendations: mockGetTvRecommendation,
    );
  });

  test("initial state should be empty", () {
    expect(tvRecommendationsBloc.state, TvRecommendationsEmpty());
  });

  const tvId = 1;
  final tvList = <Tv>[];

  blocTest<TvRecommendationsBloc, TvRecommendationsState>(
    'Should emit [Loading, Loaded] when data is gotten successfully',
    build: () {
      when(mockGetTvRecommendation.execute(tvId))
          .thenAnswer((_) async => Right(tvList));
      return tvRecommendationsBloc;
    },
    act: (bloc) => bloc.add(OnFetchTvRecommendations(tvId)),
    expect: () =>
        [TvRecommendationsLoading(), TvRecommendationsHasData(tvList)],
    verify: (bloc) {
      verify(mockGetTvRecommendation.execute(tvId));
    },
  );

  group(
    'Recommendation Tv BLoC Test',
    () {
      blocTest<TvRecommendationsBloc, TvRecommendationsState>(
        'Should emit [Loading, Error] when get recommendation is unsuccessful',
        build: () {
          when(mockGetTvRecommendation.execute(tvId))
              .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
          return tvRecommendationsBloc;
        },
        act: (bloc) => bloc.add(OnFetchTvRecommendations(tvId)),
        expect: () => [
          TvRecommendationsLoading(),
          TvRecommendationsError('Server Failure')
        ],
        verify: (bloc) {
          verify(mockGetTvRecommendation.execute(tvId));
        },
      );
    },
  );
}
