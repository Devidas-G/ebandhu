import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';
import 'package:stream_transform/stream_transform.dart';

import '../../../../core/common/usecase.dart';
import '../../domain/entities/product.dart';
import '../../domain/usecases/usecases.dart';

part 'home_event.dart';
part 'home_state.dart';

EventTransformer<E> throttleDroppable<E>(Duration duration) {
  return (events, mapper) {
    return droppable<E>().call(events.throttle(duration), mapper);
  };
}

const throttleDuration = Duration(milliseconds: 100);

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  //Domain usecases
  final FetchContent fetchContent;
  HomeBloc({required this.fetchContent}) : super(HomeInitial()) {
    on<FetchContentEvent>(
      _fetchContent,
      transformer: throttleDroppable(throttleDuration),
    );
  }

  Future<void> _fetchContent(
    FetchContentEvent event,
    Emitter<HomeState> emit,
  ) async {
    emit(HomeLoading());
    final result = await fetchContent(NoParams());
    result.fold(
      (failure) => emit(HomeError(failure.message)),
      (products) => emit(HomeLoaded(products)),
    );
  }
}
