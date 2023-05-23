import 'package:bloc/bloc.dart';
import 'package:ditonton/domain/entities/tv/tv.dart';
import 'package:ditonton/domain/usecases/tv/get_now_playing_tv.dart';
import 'package:equatable/equatable.dart';

part 'tv_now_playing_event.dart';
part 'tv_now_playing_state.dart';

class TvNowPlayingBloc extends Bloc<TvNowPlayingEvent, TvNowPlayingState> {
  final GetNowPlayingTV getNowPlayingTV;
  TvNowPlayingBloc(this.getNowPlayingTV) : super(TvNowPlayingEmpty()) {
    on<OnFetchTvNowPlaying>((event, emit) async {
      emit(TvNowPlayingLoading());

      final result = await getNowPlayingTV.execute();
      result.fold(
        (failure) => emit(TvNowPlayingError(failure.message)),
        (data) => emit(
          TvNowPlayingHasData(data),
        ),
      );
    });
  }
}
