import 'package:bloc/bloc.dart';
import 'package:ditonton/domain/entities/tv/tv.dart';
import 'package:ditonton/domain/usecases/tv/get_top_rated_tv.dart';
import 'package:equatable/equatable.dart';

part 'tv_top_rated_event.dart';
part 'tv_top_rated_state.dart';

class TvTopRatedBloc extends Bloc<TvTopRatedEvent, TvTopRatedState> {
  final GetTopRatedTV getTopRatedTV;
  TvTopRatedBloc(this.getTopRatedTV) : super(TvTopRatedEmpty()) {
    on<OnFetchTvTopRated>((event, emit) async {
      emit(TvTopRatedLoading());

      final result = await getTopRatedTV.execute();

      result.fold(
        (failure) => emit(TvTopRatedError(failure.message)),
        (data) => emit(
          TvTopRatedHasData(data),
        ),
      );
    });
  }
}
