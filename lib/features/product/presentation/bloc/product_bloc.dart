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
  final FavoriteStatus favoriteStatus;
  ProductBloc({required this.fetchProduct, required this.favoriteStatus})
    : super(ProductInitial()) {
    on<FetchProductEvent>(
      _fetchProduct,
      transformer: throttleDroppable(throttleDuration),
    );
    on<CheckFavoriteStatusEvent>(
      _checkFavoriteStatus,
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

  Future<void> _checkFavoriteStatus(
    CheckFavoriteStatusEvent event,
    Emitter<ProductState> emit,
  ) async {
    final result = await favoriteStatus(event.productId);
    result.fold(
      (failure) {
        // Optionally emit an error or just ignore.
      },
      (isFavorite) {
        if (state is ProductLoaded) {
          emit((state as ProductLoaded).copyWith(isFavorite: isFavorite));
        }
      },
    );
  }
}
