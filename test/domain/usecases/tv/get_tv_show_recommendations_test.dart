import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/entities/tv/tv.dart';
import 'package:ditonton/domain/usecases/tv/get_tv_recommendations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../helpers/test_helper.mocks.dart';

void main() {
  late GetTVRecommendations usecase;
  late MockTVShowRepository repository;
  setUp(() {
    repository = MockTVShowRepository();
    usecase = GetTVRecommendations(repository);
  });

  group('Get TV Show Recommendations', () {
    final tId = 1;
    final testTVShows = <Tv>[];
    test('should get list tv show recommendation from the repository',
        () async {
      //arrage
      when(repository.getTVShowRecommendations(tId))
          .thenAnswer((_) async => Right(testTVShows));
      //act
      final result = await usecase.execute(tId);
      //assert
      expect(result, right(testTVShows));
    });
  });
}
