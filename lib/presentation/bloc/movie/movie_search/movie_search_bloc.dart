import 'package:ditonton/domain/entities/movie/movie.dart';
import 'package:ditonton/domain/usecases/movie/search_movies.dart';
import 'package:equatable/equatable.dart';
import 'package:bloc/bloc.dart';
import 'package:rxdart/rxdart.dart';

part 'movie_search_state.dart';
part 'movie_search_event.dart';

class MovieSearchBloc extends Bloc<MovieSearchEvent, MovieSearchState> {
  final SearchMovies searchMovies;

  MovieSearchBloc({required this.searchMovies}) : super(MovieSearchEmpty()) {
    on<OnQueryChanged>((event, emit) async {
      final query = event.query;
      print(query);

      emit(MovieSearchLoading());
      final result = await searchMovies.execute(query);

      result.fold(
        (failure) => emit(MovieSearchError(failure.message)),
        (data) => emit(
          MovieSearchHasData(data),
        ),
      );
    }, transformer: debounce(Duration(milliseconds: 500)));
  }

  EventTransformer<T> debounce<T>(Duration duration) =>
      (events, mapper) => events.debounceTime(duration).flatMap(mapper);
}
