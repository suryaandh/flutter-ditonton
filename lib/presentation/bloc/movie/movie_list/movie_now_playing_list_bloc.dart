import 'package:bloc/bloc.dart';
import 'package:ditonton/domain/entities/movie/movie.dart';
import 'package:ditonton/domain/usecases/movie/get_now_playing_movies.dart';
import 'package:equatable/equatable.dart';

part 'movie_now_playing_list_state.dart';
part 'movie_now_playing_list_event.dart';

class MovieNowPlayingListBloc
    extends Bloc<MovieNowPlayingListEvent, MovieNowPlayingListState> {
  final GetNowPlayingMovies getNowPlayingMovies;

  MovieNowPlayingListBloc(this.getNowPlayingMovies)
      : super(MovieNowPlayingListEmpty()) {
    on<OnFetchNowPlayingMovies>((event, emit) async {
      emit(MovieNowPlayingListLoading());

      final result = await getNowPlayingMovies.execute();
      result.fold((failure) {
        emit(MovieNowPlayingListError(failure.message));
      }, (data) {
        emit(MovieNowPlayingListHasData(data));
      });
    });
  }
}
