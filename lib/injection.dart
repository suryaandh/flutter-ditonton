import 'package:ditonton/data/datasources/db/database_helper.dart';
import 'package:ditonton/data/datasources/movie/movie_local_data_source.dart';
import 'package:ditonton/data/datasources/movie/movie_remote_data_source.dart';
import 'package:ditonton/data/datasources/ssl/ssl_pining.dart';
import 'package:ditonton/data/datasources/tv/tv_local_data_source.dart';
import 'package:ditonton/data/datasources/tv/tv_remote_data_source.dart';
import 'package:ditonton/data/repositories/movie_repository_impl.dart';
import 'package:ditonton/data/repositories/tv_repository_impl.dart';
import 'package:ditonton/domain/repositories/movie_repository.dart';
import 'package:ditonton/domain/repositories/tv_repository.dart';
import 'package:ditonton/domain/usecases/movie/get_movie_detail.dart';
import 'package:ditonton/domain/usecases/movie/get_movie_recommendations.dart';
import 'package:ditonton/domain/usecases/movie/get_now_playing_movies.dart';
import 'package:ditonton/domain/usecases/movie/get_popular_movies.dart';
import 'package:ditonton/domain/usecases/movie/get_top_rated_movies.dart';
import 'package:ditonton/domain/usecases/movie/get_watchlist_movies.dart';
import 'package:ditonton/domain/usecases/movie/get_watchlist_status.dart';
import 'package:ditonton/domain/usecases/movie/remove_watchlist.dart';
import 'package:ditonton/domain/usecases/movie/save_watchlist.dart';
import 'package:ditonton/domain/usecases/movie/search_movies.dart';
import 'package:ditonton/domain/usecases/tv/get_now_playing_tv.dart';
import 'package:ditonton/domain/usecases/tv/get_popular_tv.dart';
import 'package:ditonton/domain/usecases/tv/get_top_rated_tv.dart';
import 'package:ditonton/domain/usecases/tv/get_tv_recommendations.dart';
import 'package:ditonton/domain/usecases/tv/get_tv_detail.dart';
import 'package:ditonton/domain/usecases/tv/get_watchlist_status_tv.dart';
import 'package:ditonton/domain/usecases/tv/get_watchlist_tv.dart';
import 'package:ditonton/domain/usecases/tv/remove_watchlist_tv.dart';
import 'package:ditonton/domain/usecases/tv/save_watchlist_tv.dart';
import 'package:ditonton/domain/usecases/tv/search_tv.dart';
import 'package:ditonton/presentation/bloc/movie/movie_detail_bloc/movie_detail_bloc.dart';
import 'package:ditonton/presentation/bloc/movie/movie_list/movie_now_playing_list_bloc.dart';
import 'package:ditonton/presentation/bloc/movie/movie_list/movie_popular_list_bloc.dart';
import 'package:ditonton/presentation/bloc/movie/movie_list/movie_top_rated_bloc.dart';
import 'package:ditonton/presentation/bloc/movie/movie_recommendations/movie_recommendations_bloc.dart';
import 'package:ditonton/presentation/bloc/movie/movie_search/movie_search_bloc.dart';
import 'package:ditonton/presentation/bloc/movie/movie_watchlist/movie_watchlist_bloc.dart';
import 'package:ditonton/presentation/bloc/movie/movie_watchlist_status/movie_watchlist_bloc.dart';
import 'package:ditonton/presentation/bloc/tv/tv_detail/tv_detail_bloc.dart';
import 'package:ditonton/presentation/bloc/tv/tv_list/tv_now_playing_bloc.dart';
import 'package:ditonton/presentation/bloc/tv/tv_list/tv_popular_bloc.dart';
import 'package:ditonton/presentation/bloc/tv/tv_list/tv_top_rated_bloc.dart';
import 'package:ditonton/presentation/bloc/tv/tv_recommendations/tv_recommendations_bloc.dart';
import 'package:ditonton/presentation/bloc/tv/tv_search/tv_search_bloc.dart';
import 'package:ditonton/presentation/bloc/tv/tv_watchlist/tv_watchlist_bloc.dart';
import 'package:ditonton/presentation/bloc/tv/tv_watchlist_status/tv_watchlist_status_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:get_it/get_it.dart';

final locator = GetIt.instance;

void init() {
  // BLOC
  //MOVIE
  locator.registerFactory(
    () => MovieDetailBloc(getMovieDetail: locator()),
  );
  locator.registerFactory(
    () => MovieNowPlayingListBloc(locator()),
  );
  locator.registerFactory(
    () => MoviePopularListBloc(locator()),
  );
  locator.registerFactory(
    () => MovieTopRatedListBloc(locator()),
  );
  locator.registerFactory(
    () => MovieRecommendationsBloc(getMovieRecommendations: locator()),
  );
  locator.registerFactory(
    () => MovieSearchBloc(searchMovies: locator()),
  );
  locator.registerFactory(
    () => MovieWatchlistBloc(getWatchlistMovies: locator()),
  );
  locator.registerFactory(
    () => MovieWachlistStatusBloc(
      getWatchlistStatus: locator(),
      removeWatchlist: locator(),
      saveWatchlist: locator(),
    ),
  );

  //TV SERIES
  locator.registerFactory(
    () => TvDetailBloc(getTvDetail: locator()),
  );
  locator.registerFactory(
    () => TvNowPlayingBloc(locator()),
  );
  locator.registerFactory(
    () => TvRecommendationsBloc(getTvRecommendations: locator()),
  );
  locator.registerFactory(
    () => TvSearchBloc(TvSearch: locator()),
  );
  locator.registerFactory(
    () => TvPopularBloc(locator()),
  );
  locator.registerFactory(
    () => TvTopRatedBloc(locator()),
  );
  locator.registerFactory(
    () => TvWatchlistBloc(locator()),
  );
  locator.registerFactory(() => TvWatchlistStatusBloc(
      saveWatchlistTV: locator(),
      removeWatchlistTV: locator(),
      getWatchListStatusTV: locator()));

  // use case
  //MOVIE
  locator.registerLazySingleton(() => GetNowPlayingMovies(locator()));
  locator.registerLazySingleton(() => GetPopularMovies(locator()));
  locator.registerLazySingleton(() => GetTopRatedMovies(locator()));
  locator.registerLazySingleton(() => GetMovieDetail(locator()));
  locator.registerLazySingleton(() => GetMovieRecommendations(locator()));
  locator.registerLazySingleton(() => SearchMovies(locator()));
  locator.registerLazySingleton(() => GetWatchListStatus(locator()));
  locator.registerLazySingleton(() => SaveWatchlist(locator()));
  locator.registerLazySingleton(() => RemoveWatchlist(locator()));
  locator.registerLazySingleton(() => GetWatchlistMovies(locator()));

  //TV SERIES
  locator.registerLazySingleton(() => GetNowPlayingTV(locator()));
  locator.registerLazySingleton(() => GetTVDetail(locator()));
  locator.registerLazySingleton(() => GetTVRecommendations(locator()));
  locator.registerLazySingleton(() => GetPopularTV(locator()));
  locator.registerLazySingleton(() => GetTopRatedTV(locator()));
  locator.registerLazySingleton(() => SearchTV(locator()));
  locator.registerLazySingleton(() => SaveWatchlistTV(locator()));
  locator.registerLazySingleton(() => GetWatchListStatusTV(locator()));
  locator.registerLazySingleton(() => RemoveWatchlistTV(locator()));
  locator.registerLazySingleton(() => GetWatchlistTV(locator()));

  // repository
  //MOVIE
  locator.registerLazySingleton<MovieRepository>(
    () => MovieRepositoryImpl(
      remoteDataSource: locator(),
      localDataSource: locator(),
    ),
  );

  //TV SERIES
  locator.registerLazySingleton<TVRepository>(
    () => TVRepositoryImpl(
      remoteDataSource: locator(),
      localDataSource: locator(),
    ),
  );

  // data sources
  //MOVIE
  locator.registerLazySingleton<MovieRemoteDataSource>(
      () => MovieRemoteDataSourceImpl(client: locator()));
  locator.registerLazySingleton<MovieLocalDataSource>(
      () => MovieLocalDataSourceImpl(databaseHelper: locator()));

  //TV SERIES
  locator.registerLazySingleton<TVRemoteDataSource>(
      () => TVRemoteDataSourceImpl(client: locator()));
  locator.registerLazySingleton<TVLocalDataSource>(
      () => TVLocalDataSourceImpl(databaseHelper: locator()));

  // helper
  locator.registerLazySingleton<DatabaseHelper>(() => DatabaseHelper());

  // external
  locator.registerLazySingleton(() => SSLPinning.client);
}
