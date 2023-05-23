part of 'movie_watchlist_bloc.dart';

class MovieWatchlistStatusState extends Equatable {
  final String message;
  final bool status;
  const MovieWatchlistStatusState(this.message, this.status);

  @override
  List<Object> get props => [message, status];
}
