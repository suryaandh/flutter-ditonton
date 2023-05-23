import 'package:bloc/bloc.dart';
import 'package:ditonton/domain/entities/tv/tv.dart';
import 'package:ditonton/domain/usecases/tv/get_tv_recommendations.dart';
import 'package:equatable/equatable.dart';

part 'tv_recommendations_event.dart';
part 'tv_recommendations_state.dart';

class TvRecommendationsBloc
    extends Bloc<TvRecommendationsEvent, TvRecommendationsState> {
  final GetTVRecommendations getTvRecommendations;
  TvRecommendationsBloc({required this.getTvRecommendations})
      : super(TvRecommendationsEmpty()) {
    on<OnFetchTvRecommendations>((event, emit) async {
      emit(TvRecommendationsLoading());

      final result = await getTvRecommendations.execute(event.id);

      result.fold(
        (failure) => emit(TvRecommendationsError(failure.message)),
        (data) => emit(
          TvRecommendationsHasData(data),
        ),
      );
    });
  }
}
