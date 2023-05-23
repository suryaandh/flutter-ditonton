part of 'tv_watchlist_status_bloc.dart';

abstract class TvWatchlistStatusEvent extends Equatable {
  const TvWatchlistStatusEvent();

  @override
  List<Object> get props => [];
}

class OnAddToWatchlistTv extends TvWatchlistStatusEvent {
  final TVDetail tvDetail;

  OnAddToWatchlistTv(this.tvDetail);

  @override
  List<Object> get props => [tvDetail];
}

class OnRemoveFromWatchlistTv extends TvWatchlistStatusEvent {
  final TVDetail tvDetail;

  OnRemoveFromWatchlistTv(this.tvDetail);

  @override
  List<Object> get props => [tvDetail];
}

class OnLoadWatchlistTvStatus extends TvWatchlistStatusEvent {
  final int id;

  OnLoadWatchlistTvStatus(this.id);

  @override
  List<Object> get props => [id];
}
