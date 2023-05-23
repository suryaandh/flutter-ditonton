part of 'movie_top_rated_bloc.dart';

abstract class MovieTopRatedListState extends Equatable {
  const MovieTopRatedListState();

  @override
  List<Object> get props => [];
}

class MovieTopRatedListEmpty extends MovieTopRatedListState {}

class MovieTopRatedListLoading extends MovieTopRatedListState {}

class MovieTopRatedListError extends MovieTopRatedListState {
  final String message;

  MovieTopRatedListError(this.message);

  @override
  List<Object> get props => [message];
}

class MovieTopRatedListHasData extends MovieTopRatedListState {
  final List<Movie> result;

  MovieTopRatedListHasData(this.result);

  @override
  List<Object> get props => [result];
}
