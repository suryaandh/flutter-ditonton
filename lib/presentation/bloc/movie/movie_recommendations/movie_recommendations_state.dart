part of 'movie_recommendations_bloc.dart';

abstract class MovieRecommendationsState extends Equatable {
  const MovieRecommendationsState();

  @override
  List<Object> get props => [];
}

class MovieRecommendationsEmpty extends MovieRecommendationsState {}

class MovieRecommendationsLoading extends MovieRecommendationsState {}

class MovieRecommendationsError extends MovieRecommendationsState {
  final String message;

  MovieRecommendationsError(this.message);

  @override
  List<Object> get props => [message];
}

class MovieRecommedationsHasData extends MovieRecommendationsState {
  final List<Movie> result;

  MovieRecommedationsHasData(this.result);

  @override
  List<Object> get props => [result];
}
