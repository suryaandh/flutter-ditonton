import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/entities/tv/tv.dart';
import 'package:ditonton/domain/usecases/tv/get_top_rated_tv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../helpers/test_helper.mocks.dart';

void main() {
  late GetTopRatedTV usecase;
  late MockTVShowRepository mockTVShowRepository;

  setUp(() {
    mockTVShowRepository = MockTVShowRepository();
    usecase = GetTopRatedTV(mockTVShowRepository);
  });

  final testTVShow = <Tv>[];

  test('should get list of tv shows from repository', () async {
    // arrange
    when(mockTVShowRepository.getTopRatedTVShows())
        .thenAnswer((_) async => Right(testTVShow));
    // act
    final result = await usecase.execute();
    // assert
    expect(result, Right(testTVShow));
  });
}
