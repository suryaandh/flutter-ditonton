import 'package:bloc/bloc.dart';
import 'package:ditonton/domain/entities/tv/tv.dart';
import 'package:ditonton/domain/usecases/tv/get_popular_tv.dart';
import 'package:equatable/equatable.dart';

part 'tv_popular_event.dart';
part 'tv_popular_state.dart';

class TvPopularBloc extends Bloc<TvPopularEvent, TvPopularState> {
  final GetPopularTV getPopularTv;
  TvPopularBloc(this.getPopularTv) : super(TvPopularEmpty()) {
    on<OnFetchPopularTv>((event, emit) async {
      emit(TvPopularLoading());

      final result = await getPopularTv.execute();

      result.fold(
        (failure) => emit(TvPopularError(failure.message)),
        (data) => emit(
          TvPopularHasData(data),
        ),
      );
    });
  }
}
