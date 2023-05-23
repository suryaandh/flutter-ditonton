import 'package:ditonton/domain/entities/movie/movie.dart';
import 'package:ditonton/domain/usecases/movie/get_popular_movies.dart';
import 'package:equatable/equatable.dart';
import 'package:bloc/bloc.dart';

part 'movie_popular_list_event.dart';
part 'movie_popular_list_state.dart';

class MoviePopularListBloc
    extends Bloc<MoviePopularListEvent, MoviePopularListState> {
  final GetPopularMovies getPopularMovies;
  MoviePopularListBloc(this.getPopularMovies) : super(MoviePopularListEmpty()) {
    on<OnFetchPopularList>((event, emit) async {
      emit(MoviePopularListLoading());

      final result = await getPopularMovies.execute();
      result.fold(
        (failure) => emit(
          MoviePopularListError(failure.message),
        ),
        (data) => emit(
          MoviePopularListHasData(data),
        ),
      );
    });
  }
}
