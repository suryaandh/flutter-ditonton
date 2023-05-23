import 'package:bloc/bloc.dart';
import 'package:ditonton/domain/entities/tv/tv.dart';
import 'package:ditonton/domain/usecases/tv/search_tv.dart';
import 'package:equatable/equatable.dart';
import 'package:rxdart/rxdart.dart';

part 'tv_search_event.dart';
part 'tv_search_state.dart';

class TvSearchBloc extends Bloc<TvSearchEvent, TvSearchState> {
  final SearchTV TvSearch;
  TvSearchBloc({required this.TvSearch}) : super(TvSearchEmpty()) {
    on<OnQueryChanged>((event, emit) async {
      final query = event.query;

      emit(TvSearchLoading());
      final result = await TvSearch.execute(query);

      result.fold(
        (failure) => emit(TvSearchError(failure.message)),
        (data) => emit(
          TvSearchHasData(data),
        ),
      );
    }, transformer: debounce(Duration(milliseconds: 500)));
  }

  EventTransformer<T> debounce<T>(Duration duration) =>
      (events, mapper) => events.debounceTime(duration).flatMap(mapper);
}
