import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/usecases/tv/get_watchlist_tv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../dummy_data/dummy_objects.dart';
import '../../../helpers/test_helper.mocks.dart';

void main() {
  late GetWatchlistTV usecase;
  late MockTVShowRepository mockTVShowRepository;

  setUp(() {
    mockTVShowRepository = MockTVShowRepository();
    usecase = GetWatchlistTV(mockTVShowRepository);
  });

  test('should get list of tv shows from the repository', () async {
    // arrange
    when(mockTVShowRepository.getWatchlistTVShows())
        .thenAnswer((_) async => Right(testTVShowList));
    // act
    final result = await usecase.execute();
    // assert
    expect(result, Right(testTVShowList));
  });
}
