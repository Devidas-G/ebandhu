import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';
import 'package:stream_transform/stream_transform.dart';

import '../../../../core/common/usecase.dart';
import '../../domain/entities/product.dart';
import '../../domain/usecases/usecases.dart';

part 'wishlist_event.dart';
part 'wishlist_state.dart';

EventTransformer<E> throttleDroppable<E>(Duration duration) {
  return (events, mapper) {
    return droppable<E>().call(events.throttle(duration), mapper);
  };
}

const throttleDuration = Duration(milliseconds: 100);

class WishlistBloc extends Bloc<WishlistEvent, WishlistState> {
  //usecases
  final FetchWishlist fetchWishlist;
  final AddToWishlist addToWishlist;
  final RemoveFromWishlist removeFromWishlist;
  final ClearWishlist clearWishlist;

  WishlistBloc({
    required this.fetchWishlist,
    required this.addToWishlist,
    required this.removeFromWishlist,
    required this.clearWishlist,
  }) : super(WishlistInitial()) {
    on<FetchWishlistEvent>(
      _fetchWishlist,
      transformer: throttleDroppable(throttleDuration),
    );
    on<AddProductToWishlistEvent>(
      _addToWishlist,
      transformer: throttleDroppable(throttleDuration),
    );
    on<RemoveProductFromWishlistEvent>(
      _removeFromWishlist,
      transformer: throttleDroppable(throttleDuration),
    );
    on<ClearWishlistEvent>(
      _clearWishlist,
      transformer: throttleDroppable(throttleDuration),
    );
  }

  Future<void> _fetchWishlist(
    FetchWishlistEvent event,
    Emitter<WishlistState> emit,
  ) async {
    emit(WishlistLoading());
    final result = await fetchWishlist(NoParams());
    result.fold(
      (failure) => emit(WishlistError(failure.message)),
      (products) => emit(WishlistLoaded(products)),
    );
  }

  Future<void> _addToWishlist(
    AddProductToWishlistEvent event,
    Emitter<WishlistState> emit,
  ) async {
    emit(WishlistLoading());
    final result = await addToWishlist(event.product);
    result.fold(
      (failure) => emit(WishlistError(failure.message)),
      (products) => emit(WishlistLoaded(products)),
    );
  }

  Future<void> _removeFromWishlist(
    RemoveProductFromWishlistEvent event,
    Emitter<WishlistState> emit,
  ) async {
    emit(WishlistLoading());
    final result = await removeFromWishlist(event.productId);
    result.fold(
      (failure) => emit(WishlistError(failure.message)),
      (products) => emit(WishlistLoaded(products)),
    );
  }

  Future<void> _clearWishlist(
    ClearWishlistEvent event,
    Emitter<WishlistState> emit,
  ) async {
    emit(WishlistLoading());
    final result = await clearWishlist(NoParams());
    result.fold(
      (failure) => emit(WishlistError(failure.message)),
      (success) => emit(WishlistLoaded([])),
    );
  }
}
