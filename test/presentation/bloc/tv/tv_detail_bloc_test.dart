import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/usecases/tv/get_tv_detail.dart';
import 'package:ditonton/presentation/bloc/tv/tv_detail/tv_detail_bloc.dart';
import 'package:mockito/annotations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import 'tv_detail_bloc_test.mocks.dart';
import '../../../dummy_data/dummy_objects.dart';

@GenerateMocks([GetTVDetail, TvDetailBloc])
void main() {
  late MockGetTvDetail mockGetTvDetail;
  late TvDetailBloc tvDetailBloc;
  setUp(() {
    mockGetTvDetail = MockGetTvDetail();
    tvDetailBloc = TvDetailBloc(getTvDetail: mockGetTvDetail);
  });

  const tvId = 1;

  test("initial state should be empty", () {
    expect(tvDetailBloc.state, TvDetailEmpty());
  });

  // group(
  //   'Top Rated Movies BLoC Test',
  //   () {
  //     blocTest<TvDetailBloc, TvDetailState>(
  //       'Should emit [Loading, Loaded] when data is gotten successfully',
  //       build: () {
  //         when(mockGetTvDetail.execute(tvId))
  //             .thenAnswer((_) async => Right(testTVShowModel));
  //         return tvDetailBloc;
  //       },
  //       act: (bloc) => bloc.add(OnFetchTvDetail(tvId)),
  //       expect: () => [TvDetailLoading(), TvDetailHasData(testTVShowModel)],
  //       verify: (bloc) {
  //         verify(mockGetTvDetail.execute(tvId));
  //       },
  //     );

  blocTest<TvDetailBloc, TvDetailState>(
    'Should emit [Loading, Error] when get detail is unsuccessful',
    build: () {
      when(mockGetTvDetail.execute(tvId))
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      return tvDetailBloc;
    },
    act: (bloc) => bloc.add(OnFetchTvDetail(tvId)),
    expect: () => [TvDetailLoading(), TvDetailError('Server Failure')],
    verify: (bloc) {
      verify(mockGetTvDetail.execute(tvId));
    },
  );
}
