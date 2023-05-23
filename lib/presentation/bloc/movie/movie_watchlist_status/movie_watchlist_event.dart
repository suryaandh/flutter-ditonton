part of 'movie_watchlist_bloc.dart';

abstract class MovieWatchlistStatusEvent extends Equatable {
  const MovieWatchlistStatusEvent();

  @override
  List<Object> get props => [];
}

class OnAddWatchlist extends MovieWatchlistStatusEvent {
  final MovieDetail movieDetail;

  OnAddWatchlist(this.movieDetail);

  @override
  List<Object> get props => [movieDetail];
}

class OnRemoveFromWatchlist extends MovieWatchlistStatusEvent {
  final MovieDetail movieDetail;

  OnRemoveFromWatchlist(this.movieDetail);

  @override
  List<Object> get props => [movieDetail];
}

class OnLoadWatchlistStatus extends MovieWatchlistStatusEvent {
  final int id;

  OnLoadWatchlistStatus(this.id);

  @override
  List<Object> get props => [id];
}
