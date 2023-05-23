import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/entities/tv/tv.dart';
import 'package:ditonton/domain/usecases/tv/search_tv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../helpers/test_helper.mocks.dart';

void main() {
  late MockTVShowRepository mockTVShowRepository;
  late SearchTV usecase;

  setUp(() {
    mockTVShowRepository = MockTVShowRepository();
    usecase = SearchTV(mockTVShowRepository);
  });

  final testTVShow = <Tv>[];
  final tQuery = 'Spiderman';

  group('Search TV Shows', () {
    test('sould get list of tv shows from the repository', () async {
      //arrage
      when(mockTVShowRepository.searchTVShows(tQuery))
          .thenAnswer((_) async => Right(testTVShow));
      //act
      final result = await usecase.execute(tQuery);
      //assert
      expect(result, Right(testTVShow));
    });
  });
}
