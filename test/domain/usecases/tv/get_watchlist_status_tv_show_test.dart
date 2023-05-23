import 'package:ditonton/domain/usecases/tv/get_watchlist_status_tv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../helpers/test_helper.mocks.dart';

void main() {
  late GetWatchListStatusTV usecase;
  late MockTVShowRepository mockTVShowRepository;

  setUp(() {
    mockTVShowRepository = MockTVShowRepository();
    usecase = GetWatchListStatusTV(mockTVShowRepository);
  });

  test('should get watchlist status of tv show from repository', () async {
    // arrange
    when(mockTVShowRepository.isAddedToWatchlist(1))
        .thenAnswer((_) async => true);
    // act
    final result = await usecase.execute(1);
    // assert
    expect(result, true);
  });
}
