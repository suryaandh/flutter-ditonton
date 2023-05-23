import 'package:bloc/bloc.dart';
import 'package:ditonton/domain/entities/movie/movie_detail.dart';
import 'package:ditonton/domain/usecases/movie/get_watchlist_status.dart';
import 'package:ditonton/domain/usecases/movie/remove_watchlist.dart';
import 'package:ditonton/domain/usecases/movie/save_watchlist.dart';
import 'package:equatable/equatable.dart';

part 'movie_watchlist_event.dart';
part 'movie_watchlist_state.dart';

class MovieWachlistStatusBloc
    extends Bloc<MovieWatchlistStatusEvent, MovieWatchlistStatusState> {
  static const movieWachlistAddSuccessMessage = 'Added to Watchlist';
  static const movieWachlistRemoveSuccessMessage = 'Removed from Watchlist';

  final GetWatchListStatus getWatchlistStatus;
  final SaveWatchlist saveWatchlist;
  final RemoveWatchlist removeWatchlist;

  MovieWachlistStatusBloc(
      {required this.getWatchlistStatus,
      required this.saveWatchlist,
      required this.removeWatchlist})
      : super(MovieWatchlistStatusState('', false)) {
    on<OnAddWatchlist>((event, emit) async {
      final result = await saveWatchlist.execute(event.movieDetail);
      String message = '';
      // bool status = state.status;
      result.fold((failure) {
        message = failure.message;
      }, (success) async {
        message = movieWachlistAddSuccessMessage;
        // status = await getWatchlistStatus.execute(event.movieDetail.id);
      });
      final status = await getWatchlistStatus.execute(event.movieDetail.id);
      emit(MovieWatchlistStatusState(message, status));
    });

    on<OnRemoveFromWatchlist>((event, emit) async {
      final result = await removeWatchlist.execute(event.movieDetail);
      String message = '';
      // bool status = state.status;
      result.fold((failure) {
        message = failure.message;
      }, (success) async {
        message = movieWachlistRemoveSuccessMessage;
        // status = await getWatchlistStatus.execute(event.movieDetail.id);
      });
      final status = await getWatchlistStatus.execute(event.movieDetail.id);
      emit(MovieWatchlistStatusState(message, status));
    });

    on<OnLoadWatchlistStatus>((event, emit) async {
      final result = await getWatchlistStatus.execute(event.id);
      emit(MovieWatchlistStatusState('', result));
    });
  }
}
