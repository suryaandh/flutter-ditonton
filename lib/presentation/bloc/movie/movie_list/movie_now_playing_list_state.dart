part of 'movie_now_playing_list_bloc.dart';

abstract class MovieNowPlayingListState extends Equatable {
  const MovieNowPlayingListState();

  @override
  List<Object> get props => [];
}

class MovieNowPlayingListEmpty extends MovieNowPlayingListState {}

class MovieNowPlayingListLoading extends MovieNowPlayingListState {}

class MovieNowPlayingListError extends MovieNowPlayingListState {
  final String message;

  MovieNowPlayingListError(this.message);

  @override
  List<Object> get props => [message];
}

class MovieNowPlayingListHasData extends MovieNowPlayingListState {
  final List<Movie> result;

  MovieNowPlayingListHasData(this.result);

  @override
  List<Object> get props => [result];
}
