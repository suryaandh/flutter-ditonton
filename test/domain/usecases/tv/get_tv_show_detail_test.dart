import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/usecases/tv/get_tv_detail.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../dummy_data/dummy_objects.dart';
import '../../../helpers/test_helper.mocks.dart';

void main() {
  late GetTVDetail usecase;
  late MockTVShowRepository mockTVShowRepository;

  setUp(() {
    mockTVShowRepository = MockTVShowRepository();
    usecase = GetTVDetail(mockTVShowRepository);
  });
  final tId = 2;

  group('Get TV Shows Detail Test', () {
    test('should get tv show detail from the repository', () async {
      //arrage
      when(mockTVShowRepository.getTVShowDetail(tId))
          .thenAnswer((_) async => Right(testTVShowDetailEntity));
      //act
      final result = await usecase.execute(tId);
      //assert
      expect(result, Right(testTVShowDetailEntity));
    });
  });
}
