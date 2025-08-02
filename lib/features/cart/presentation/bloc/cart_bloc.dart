import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:stream_transform/stream_transform.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';

import '../../../../core/common/usecase.dart';
import '../../domain/entities/product.dart';
import '../../domain/usecases/usecases.dart';

part 'cart_event.dart';
part 'cart_state.dart';

EventTransformer<E> throttleDroppable<E>(Duration duration) {
  return (events, mapper) {
    return droppable<E>().call(events.throttle(duration), mapper);
  };
}

const throttleDuration = Duration(milliseconds: 100);

class CartBloc extends Bloc<CartEvent, CartState> {
  //usecases
  final FetchCart fetchCart;
  final AddItemToCart addItemToCart;
  final RemoveItemFromCart removeItemFromCart;
  final ClearCart clearCart;

  CartBloc({
    required this.fetchCart,
    required this.addItemToCart,
    required this.removeItemFromCart,
    required this.clearCart,
  }) : super(CartInitial()) {
    on<FetchCartEvent>(
      _fetchCart,
      transformer: throttleDroppable(throttleDuration),
    );
    on<AddItemEvent>(
      _addItemToCart,
      transformer: throttleDroppable(throttleDuration),
    );
    on<RemoveItemEvent>(
      _removeItemFromCart,
      transformer: throttleDroppable(throttleDuration),
    );
    on<ClearCartEvent>(
      _clearCart,
      transformer: throttleDroppable(throttleDuration),
    );
  }

  Future<void> _fetchCart(FetchCartEvent event, Emitter<CartState> emit) async {
    emit(CartLoading());
  }

  Future<void> _addItemToCart(
    AddItemEvent event,
    Emitter<CartState> emit,
  ) async {
    emit(CartLoading());
    final result = await addItemToCart(event.item);
    result.fold(
      (failure) => emit(CartError(failure.message)),
      (products) => emit(CartLoaded(products)),
    );
  }

  Future<void> _removeItemFromCart(
    RemoveItemEvent event,
    Emitter<CartState> emit,
  ) async {
    emit(CartLoading());
    final result = await removeItemFromCart(event.productId);
    result.fold(
      (failure) => emit(CartError(failure.message)),
      (products) => emit(CartLoaded(products)),
    );
  }

  Future<void> _clearCart(ClearCartEvent event, Emitter<CartState> emit) async {
    emit(CartLoading());
    final result = await clearCart(NoParams());
    result.fold(
      (failure) => emit(CartError(failure.message)),
      (success) => emit(CartLoaded([])),
    );
  }
}
