import 'package:ditonton/data/models/tv/tv_detail_model.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final testTVResponse = TVDetailModel(
    popularity: 1,
    posterPath: 'posterPath',
    name: 'name',
    type: 'type',
    numberOfEpisodes: 1,
    numberOfSeasons: 1,
    seasons: [],
    episodeRunTime: [1],
    firstAirDate: 'firstAirDate',
    genres: [],
    id: 1,
    overview: 'overview',
    voteCount: 1,
    tagline: 'tagline',
    originalName: 'originalName',
    homepage: 'homepage',
    voteAverage: 1,
    originalLanguage: 'originalLanguage',
    backdropPath: 'backdropPath',
    status: 'status',
  );

  final testTVDetail = testTVResponse.toEntity();
  final testTVMap = testTVResponse.toJson();

  group('Model of TV Show Detail', () {
    test('should be a subclass of TVShowDetail entity', () async {
      final result = testTVResponse.toEntity();
      expect(result, testTVDetail);
    });

    test('should be a map of Tv', () async {
      final result = testTVResponse.toJson();
      expect(result, testTVMap);
    });

    test('should be a TVDetailResponse instance', () async {
      final result = TVDetailModel.fromJson(testTVMap);
      expect(result, testTVResponse);
    });
  });
}
