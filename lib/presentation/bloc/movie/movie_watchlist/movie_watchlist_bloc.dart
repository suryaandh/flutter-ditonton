import 'package:bloc/bloc.dart';
import 'package:ditonton/domain/entities/movie/movie.dart';
import 'package:ditonton/domain/usecases/movie/get_watchlist_movies.dart';
import 'package:equatable/equatable.dart';

part 'movie_watchlist_state.dart';
part 'movie_watchlist_event.dart';

class MovieWatchlistBloc
    extends Bloc<MovieWatchlistEvent, MovieWatchlistState> {
  final GetWatchlistMovies getWatchlistMovies;

  MovieWatchlistBloc({required this.getWatchlistMovies})
      : super(MovieWatchlistEmpty()) {
    on<OnFetchWatchlistMovie>((event, emit) async {
      emit(MovieWatchlistLoading());

      final result = await getWatchlistMovies.execute();
      result.fold(
        (failure) => emit(MovieWatchlistError(failure.message)),
        (data) => emit(
          MovieWatchlistHasData(data),
        ),
      );
    });
  }
}
