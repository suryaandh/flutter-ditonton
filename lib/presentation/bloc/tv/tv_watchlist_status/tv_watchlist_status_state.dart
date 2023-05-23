part of 'tv_watchlist_status_bloc.dart';

class TvWatchlistStatusState extends Equatable {
  final bool status;
  final String message;
  const TvWatchlistStatusState(this.status, this.message);

  @override
  List<Object> get props => [status, message];
}
