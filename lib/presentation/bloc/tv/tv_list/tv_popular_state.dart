part of 'tv_popular_bloc.dart';

abstract class TvPopularState extends Equatable {
  const TvPopularState();

  @override
  List<Object> get props => [];
}

class TvPopularEmpty extends TvPopularState {}

class TvPopularLoading extends TvPopularState {}

class TvPopularError extends TvPopularState {
  final String message;

  TvPopularError(this.message);

  @override
  List<Object> get props => [message];
}

class TvPopularHasData extends TvPopularState {
  final List<Tv> result;

  TvPopularHasData(this.result);

  @override
  List<Object> get props => [result];
}
