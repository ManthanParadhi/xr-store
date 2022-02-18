import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:xrstore/models/models.dart';

part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc() : super(CartLoading()) {
    on<CartStarted>(
            (event, emit) async {
      emit(CartLoading());
      await Future<void>.delayed(const Duration(seconds: 1));
      emit(CartLoaded());
    });
    on<CartProductAdded>(
            (event, emit) async{
      if (state is CartLoaded){
        emit(CartLoaded(cart: Cart(products:
        List.from(state.cart.products)..add(event.product),)));
      }
    });
    on<CartProductRemoved>((
        event, emit) async{
      if (state is CartLoaded){
        emit(CartLoaded(cart: Cart(products: List.from(state.cart.products)
          ..remove(event.product),)));
      }
    });
  }
}
