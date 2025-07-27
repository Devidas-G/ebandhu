import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';
import 'package:stream_transform/stream_transform.dart';

import '../../domain/entities/product.dart';
import '../../domain/usecases/usecases.dart';

part 'product_event.dart';
part 'product_state.dart';

EventTransformer<E> throttleDroppable<E>(Duration duration) {
  return (events, mapper) {
    return droppable<E>().call(events.throttle(duration), mapper);
  };
}

const throttleDuration = Duration(milliseconds: 100);

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  //usecases
  final FetchProduct fetchProduct;
  ProductBloc({required this.fetchProduct}) : super(ProductInitial()) {
    on<FetchProductEvent>(
      _fetchProduct,
      transformer: throttleDroppable(throttleDuration),
    );
  }

  Future<void> _fetchProduct(
    FetchProductEvent event,
    Emitter<ProductState> emit,
  ) async {
    emit(ProductLoading());
    final result = await fetchProduct(event.productId);
    result.fold(
      (failure) => emit(ProductError(failure.message)),
      (product) => emit(ProductLoaded(product)),
    );
  }
}
