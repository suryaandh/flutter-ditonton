import 'package:ditonton/common/exception.dart';
import 'package:ditonton/data/datasources/db/database_helper.dart';
import 'package:ditonton/data/models/tv/tv_table.dart';

abstract class TVLocalDataSource {
  Future<String> insertWatchlist(TvTable tvShow);
  Future<String> removeWatchlist(TvTable tvShow);
  Future<TvTable?> getTVShowById(int id);
  Future<List<TvTable>> getWatchlistTVShows();
}

class TVLocalDataSourceImpl implements TVLocalDataSource {
  final DatabaseHelper databaseHelper;

  TVLocalDataSourceImpl({required this.databaseHelper});

  @override
  Future<TvTable?> getTVShowById(int id) async {
    final result = await databaseHelper.getTVShowById(id);
    if (result != null) {
      return TvTable.fromMap(result);
    } else
      return null;
  }

  @override
  Future<List<TvTable>> getWatchlistTVShows() async {
    final result = await databaseHelper.getWatchlistTVShows();
    return result.map((data) => TvTable.fromMap(data)).toList();
  }

  @override
  Future<String> insertWatchlist(TvTable tvShow) async {
    try {
      await databaseHelper.insertTVShowWatchlist(tvShow);
      return 'Added to Watchlist';
    } catch (e) {
      throw DatabaseException(e.toString());
    }
  }

  @override
  Future<String> removeWatchlist(TvTable tvShow) async {
    try {
      await databaseHelper.removeTVShowWatchlist(tvShow);
      return 'Removed from Watchlist';
    } catch (e) {
      throw DatabaseException(e.toString());
    }
  }
}
