import 'package:bloc/bloc.dart';
import 'package:ditonton/domain/entities/tv/tv_detail.dart';
import 'package:ditonton/domain/usecases/tv/get_watchlist_status_tv.dart';
import 'package:ditonton/domain/usecases/tv/remove_watchlist_tv.dart';
import 'package:ditonton/domain/usecases/tv/save_watchlist_tv.dart';
import 'package:equatable/equatable.dart';

part 'tv_watchlist_status_event.dart';
part 'tv_watchlist_status_state.dart';

class TvWatchlistStatusBloc
    extends Bloc<TvWatchlistStatusEvent, TvWatchlistStatusState> {
  static const watchlistAddSuccessMessage = 'Added to Watchlist';
  static const watchlistRemoveSuccessMessage = 'Removed from Watchlist';
  final SaveWatchlistTV saveWatchlistTV;
  final RemoveWatchlistTV removeWatchlistTV;
  final GetWatchListStatusTV getWatchListStatusTV;
  TvWatchlistStatusBloc(
      {required this.saveWatchlistTV,
      required this.removeWatchlistTV,
      required this.getWatchListStatusTV})
      : super(TvWatchlistStatusState(false, '')) {
    on<OnAddToWatchlistTv>((event, emit) async {
      final result = await saveWatchlistTV.execute(event.tvDetail);
      String msg = '';
      result.fold((failure) {
        msg = failure.message;
      }, (success) {
        msg = watchlistAddSuccessMessage;
      });
      final status = await getWatchListStatusTV.execute(event.tvDetail.id);
      emit(TvWatchlistStatusState(status, msg));
    });

    on<OnRemoveFromWatchlistTv>((event, emit) async {
      final result = await removeWatchlistTV.execute(event.tvDetail);
      String msg = '';
      result.fold((failure) {
        msg = failure.message;
      }, (success) {
        msg = watchlistRemoveSuccessMessage;
      });
      final status = await getWatchListStatusTV.execute(event.tvDetail.id);
      emit(TvWatchlistStatusState(status, msg));
    });

    on<OnLoadWatchlistTvStatus>((event, emit) async {
      final result = await getWatchListStatusTV.execute(event.id);
      emit(TvWatchlistStatusState(result, state.message));
    });
  }
}
