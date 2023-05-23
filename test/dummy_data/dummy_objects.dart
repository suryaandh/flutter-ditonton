import 'package:ditonton/data/models/movie/genre_model.dart';
import 'package:ditonton/data/models/movie/movie_table.dart';
import 'package:ditonton/data/models/tv/season_model.dart';
import 'package:ditonton/data/models/tv/tv_detail_model.dart';
import 'package:ditonton/data/models/tv/tv_model.dart';
import 'package:ditonton/data/models/tv/tv_response.dart';
import 'package:ditonton/data/models/tv/tv_table.dart';
import 'package:ditonton/domain/entities/movie/genre.dart';
import 'package:ditonton/domain/entities/movie/movie.dart';
import 'package:ditonton/domain/entities/movie/movie_detail.dart';
import 'package:ditonton/domain/entities/tv/tv.dart';

final testMovie = Movie(
  adult: false,
  backdropPath: '/muth4OYamXf41G2evdrLEg8d3om.jpg',
  genreIds: [14, 28],
  id: 557,
  originalTitle: 'Spider-Man',
  overview:
      'After being bitten by a genetically altered spider, nerdy high school student Peter Parker is endowed with amazing powers to become the Amazing superhero known as Spider-Man.',
  popularity: 60.441,
  posterPath: '/rweIrveL43TaxUN0akQEaAXL6x0.jpg',
  releaseDate: '2002-05-01',
  title: 'Spider-Man',
  video: false,
  voteAverage: 7.2,
  voteCount: 13507,
);

final testMovieList = [testMovie];

final testMovieDetail = MovieDetail(
  adult: false,
  backdropPath: 'backdropPath',
  genres: [Genre(id: 1, name: 'Action')],
  id: 1,
  originalTitle: 'originalTitle',
  overview: 'overview',
  posterPath: 'posterPath',
  releaseDate: 'releaseDate',
  runtime: 120,
  title: 'title',
  voteAverage: 1,
  voteCount: 1,
);

final testWatchlistMovie = Movie.watchlist(
  id: 1,
  title: 'title',
  posterPath: 'posterPath',
  overview: 'overview',
);

final testMovieTable = MovieTable(
  id: 1,
  title: 'title',
  posterPath: 'posterPath',
  overview: 'overview',
);

final testMovieMap = {
  'id': 1,
  'overview': 'overview',
  'posterPath': 'posterPath',
  'title': 'title',
};

//tv

final testTVShowModel = TvModel(
  backdropPath: "/oC9SgtJTDCEpWnTBtVGoAvjl5hb.jpg",
  firstAirDate: "2006-09-18",
  genreIds: [10767],
  id: 1991,
  name: "Rachael Ray",
  originCountry: ["US"],
  originalLanguage: "en",
  originalName: "Rachael Ray",
  overview:
      "Rachael Ray, also known as The Rachael Ray Show, is an American talk show starring Rachael Ray that debuted in syndication in the United States and Canada on September 18, 2006. It is filmed at Chelsea Television Studios in New York City. The show's 8th season premiered on September 9, 2013, and became the last Harpo show in syndication to switch to HD with a revamped studio. In January 2012, CBS Television Distribution announced a two-year renewal for the show, taking it through the 2013–14 season.",
  popularity: 1765.863,
  posterPath: "/dsAJhCLYX1fiNRoiiJqR6Up4aJ.jpg",
  voteAverage: 5.8,
  voteCount: 29,
);

final testTVShowModelList = <TvModel>[testTVShowModel];

final testTVShow = testTVShowModel.toEntity();

final testTVShowList = <Tv>[testTVShow];

final testTVShowResponse = TVResponse(tvShowList: testTVShowModelList);

final testTVShowDetailResponse = TVDetailModel(
  backdropPath: '',
  firstAirDate: '',
  genres: [GenreModel(id: 1, name: 'Action')],
  id: 2,
  episodeRunTime: [],
  homepage: "https://google.com",
  numberOfEpisodes: 34,
  name: 'name',
  numberOfSeasons: 2,
  originalLanguage: 'en',
  originalName: 'name',
  overview: 'overview',
  popularity: 12.323,
  posterPath: '',
  seasons: [
    SeasonsModel(
      airDate: '',
      episodeCount: 7,
      id: 1,
      name: 'Winter',
      overview: 'overview',
      posterPath: 'posterPath',
      seasonNumber: 2,
    )
  ],
  status: 'status',
  tagline: 'tagline',
  type: 'Scripted',
  voteAverage: 3,
  voteCount: 3,
);
final testTVShowDetailResponseEntity = testTVShowDetailResponse.toEntity();

final testTVShowTable = TvTable.fromEntity(testTVShowDetailResponseEntity);

final testTVShowTableList = <TvTable>[testTVShowTable];

final testWatchlistTVShow = [testTVShowTable.toEntity()];

final testTVShowMaping = {
  'id': 1,
  'overview': 'overview',
  'posterPath': 'posterPath',
  'name': 'name',
};

final testTVShowDetail = TVDetailModel(
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

final testTVShowDetailEntity = testTVShowDetail.toEntity();
final testTVShowMap = testTVShowDetail.toJson();

//seasons
final testSeasonModel = SeasonsModel(
  id: 1,
  name: 'season',
  posterPath: 'poster',
  episodeCount: 2,
  seasonNumber: 2,
  airDate: '',
  overview: '',
);

final testSeason = testSeasonModel.toEntity();

final testSeasonMap = testSeasonModel.toJson();
