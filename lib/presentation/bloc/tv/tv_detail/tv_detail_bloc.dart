import 'package:bloc/bloc.dart';
import 'package:ditonton/domain/entities/tv/tv_detail.dart';
import 'package:ditonton/domain/usecases/tv/get_tv_detail.dart';
import 'package:equatable/equatable.dart';

part 'tv_detail_state.dart';
part 'tv_detail_event.dart';

class TvDetailBloc extends Bloc<TvDetailEvent, TvDetailState> {
  final GetTVDetail getTvDetail;
  TvDetailBloc({required this.getTvDetail}) : super(TvDetailEmpty()) {
    on<OnFetchTvDetail>((event, emit) async {
      emit(TvDetailLoading());

      final result = await getTvDetail.execute(event.id);

      result.fold(
        (failure) => emit(TvDetailError(failure.message)),
        (data) => emit(
          TvDetailHasData(data),
        ),
      );
    });
  }
}
