part of 'movie_popular_list_bloc.dart';

abstract class MoviePopularListState extends Equatable {
  const MoviePopularListState();

  @override
  List<Object> get props => [];
}

class MoviePopularListEmpty extends MoviePopularListState {}

class MoviePopularListLoading extends MoviePopularListState {}

class MoviePopularListError extends MoviePopularListState {
  final String message;

  MoviePopularListError(this.message);

  @override
  List<Object> get props => [message];
}

class MoviePopularListHasData extends MoviePopularListState {
  final List<Movie> result;

  MoviePopularListHasData(this.result);

  @override
  List<Object> get props => [result];
}
