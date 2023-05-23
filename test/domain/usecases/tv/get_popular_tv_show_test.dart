import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/entities/tv/tv.dart';
import 'package:ditonton/domain/usecases/tv/get_popular_tv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../helpers/test_helper.mocks.dart';

void main() {
  late GetPopularTV usecase;
  late MockTVShowRepository repository;

  setUp(() {
    repository = MockTVShowRepository();
    usecase = GetPopularTV(repository);
  });

  final testTVShow = <Tv>[];

  group('Get Popular TVShows', () {
    test(
        'should get list of tv shows form the reposiroty exeecute function is called',
        () async {
      //arrange
      when(repository.getPopularTVShows())
          .thenAnswer((_) async => Right(testTVShow));
      //act
      final result = await usecase.execute();
      //assert
      expect(result, Right(testTVShow));
    });
  });
}
