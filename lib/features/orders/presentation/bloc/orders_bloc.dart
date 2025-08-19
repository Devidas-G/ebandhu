import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';
import 'package:stream_transform/stream_transform.dart';

import '../../../../core/common/usecase.dart';
import '../../domain/entities/order.dart';
import '../../orders.dart';

part 'orders_event.dart';
part 'orders_state.dart';

EventTransformer<E> throttleDroppable<E>(Duration duration) {
  return (events, mapper) {
    return droppable<E>().call(events.throttle(duration), mapper);
  };
}

const throttleDuration = Duration(milliseconds: 100);

class OrdersBloc extends Bloc<OrdersEvent, OrdersState> {
  //usecases
  final FetchOrders fetchOrders;

  OrdersBloc({required this.fetchOrders}) : super(OrdersInitial()) {
    on<OrdersFetchEvent>(
      _onOrdersFetchEvent,
      transformer: throttleDroppable(throttleDuration),
    );
  }

  Future<void> _onOrdersFetchEvent(
    OrdersFetchEvent event,
    Emitter<OrdersState> emit,
  ) async {
    emit(OrdersLoading());
    final result = await fetchOrders(NoParams());
    result.fold(
      (failure) => emit(OrdersError(failure.message)),
      (orders) => emit(OrdersLoaded(orders)),
    );
  }
}
