import 'package:bloc/bloc.dart';
import 'package:ditonton/domain/entities/tv/tv.dart';
import 'package:ditonton/domain/usecases/tv/get_watchlist_tv.dart';
import 'package:equatable/equatable.dart';

part 'tv_watchlist_event.dart';
part 'tv_watchlist_state.dart';

class TvWatchlistBloc extends Bloc<TvWatchlistEvent, TvWatchlistState> {
  final GetWatchlistTV getWatchlistTV;

  TvWatchlistBloc(this.getWatchlistTV) : super(TvWatchlistEmpty()) {
    on<OnFetchTvWatchlist>((event, emit) async {
      emit(TvWatchlistLoading());

      final result = await getWatchlistTV.execute();

      result.fold(
        (failure) => emit(TvWatchlistError(failure.message)),
        (data) => emit(
          TvWatchlistHasData(data),
        ),
      );
    });
  }
}
