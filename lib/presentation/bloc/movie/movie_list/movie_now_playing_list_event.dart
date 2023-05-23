part of 'movie_now_playing_list_bloc.dart';

abstract class MovieNowPlayingListEvent extends Equatable {
  const MovieNowPlayingListEvent();

  @override
  List<Object> get props => [];
}

class OnFetchNowPlayingMovies extends MovieNowPlayingListEvent {
  @override
  List<Object> get props => [];
}
