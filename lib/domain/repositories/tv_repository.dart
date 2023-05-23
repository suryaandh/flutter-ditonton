import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/entities/tv/tv.dart';
import 'package:ditonton/domain/entities/tv/tv_detail.dart';

abstract class TVRepository {
  Future<Either<Failure, List<Tv>>> getNowPlayingTVShows();
  Future<Either<Failure, TVDetail>> getTVShowDetail(int id);
  Future<Either<Failure, List<Tv>>> getPopularTVShows();
  Future<Either<Failure, List<Tv>>> getTopRatedTVShows();
  Future<Either<Failure, List<Tv>>> getTVShowRecommendations(int id);
  Future<Either<Failure, List<Tv>>> searchTVShows(String query);
  Future<Either<Failure, String>> saveWatchlist(TVDetail tvShow);
  Future<Either<Failure, String>> removeWatchlist(TVDetail tvShow);
  Future<bool> isAddedToWatchlist(int id);
  Future<Either<Failure, List<Tv>>> getWatchlistTVShows();
}
