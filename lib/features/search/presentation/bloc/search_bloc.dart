import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';
import 'package:stream_transform/stream_transform.dart';

import '../../domain/entities/product.dart';
import '../../domain/usecases/usecases.dart';

part 'search_event.dart';
part 'search_state.dart';

EventTransformer<E> throttleDroppable<E>(Duration duration) {
  return (events, mapper) {
    return droppable<E>().call(events.throttle(duration), mapper);
  };
}

const throttleDuration = Duration(milliseconds: 100);

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  //usecases
  final SearchProducts searchProducts;
  SearchBloc({required this.searchProducts}) : super(SearchInitial()) {
    on<SearchQueryChanged>(
      _searchQueryChanged,
      transformer: throttleDroppable(throttleDuration),
    );
  }

  Future<void> _searchQueryChanged(
    SearchQueryChanged event,
    Emitter<SearchState> emit,
  ) async {
    final query = event.query;
    if (query.isEmpty) {
      emit(SearchInitial());
      return;
    }

    emit(SearchLoading());
    final result = await searchProducts(query);
    result.fold(
      (failure) => emit(SearchError(failure.message)),
      (products) => emit(SearchLoaded(products)),
    );
  }
}
