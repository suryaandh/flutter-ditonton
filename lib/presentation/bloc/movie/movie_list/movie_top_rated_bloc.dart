import 'package:ditonton/domain/entities/movie/movie.dart';
import 'package:ditonton/domain/usecases/movie/get_top_rated_movies.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'movie_top_rated_event.dart';
part 'movie_top_rated_state.dart';

class MovieTopRatedListBloc
    extends Bloc<MovieTopRatedListEvent, MovieTopRatedListState> {
  final GetTopRatedMovies getTopRatedMovies;
  MovieTopRatedListBloc(this.getTopRatedMovies)
      : super(MovieTopRatedListEmpty()) {
    on<OnFetchTopRatedList>((event, emit) async {
      emit(MovieTopRatedListLoading());

      final result = await getTopRatedMovies.execute();
      result.fold(
        (failure) => emit(MovieTopRatedListError(failure.message)),
        (data) => emit(
          MovieTopRatedListHasData(data),
        ),
      );
    });
  }
}
