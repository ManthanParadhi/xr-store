import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:xrstore/blocs/cart/cart_bloc.dart';
import 'package:xrstore/models/models.dart';
import 'package:xrstore/repositories/checkout/checkout_repository.dart';

part 'checkout_event.dart';
part 'checkout_state.dart';

class CheckoutBloc extends Bloc<CheckoutEvent, CheckoutState> {

  final CartBloc _cartBloc;
  final CheckoutRepository _checkoutRepository;
  StreamSubscription _cartSubscribtion;
  StreamSubscription _checkoutSubscribtion;

  CheckoutBloc({
    CartBloc cartBloc,
    CheckoutRepository checkoutRepository,
}) : _cartBloc = cartBloc,
  _checkoutRepository = checkoutRepository,
        super(
        cartBloc.state is CartLoaded
            ?CheckoutLoaded(
          products: (cartBloc.state as CartLoaded).cart.products,
  subtotal: (cartBloc.state as CartLoaded).cart.subtotalString,
  deliveryFee: (cartBloc.state as CartLoaded).cart.deliveryFeeString,
  total: (cartBloc.state as CartLoaded).cart.totalString,
      ):
            CheckoutLoading()) {
    _cartSubscribtion = cartBloc.stream.listen((state) {
      if(state is CartLoaded){
        add(UpdateCheckout(cart: state.cart));
      }
    });

    on<UpdateCheckout>((event, emit) {
      if(state is CheckoutLoaded){
        emit(CheckoutLoaded(
            email:event.email,
          fullName: event.fullName,
          address: event.address,
          city: event.city,
          country: event.country,
          zipCode: event.zipCode,
          products: event.cart?.products,
          subtotal: event.cart?.subtotalString,
          deliveryFee: event.cart?.deliveryFeeString,
          total: event.cart?.totalString,

        ));
      }
    });

    on<ConfirmCheckout>((event, emit) async*{
      _checkoutSubscribtion?.cancel();
      if(state is CheckoutLoaded){
        try{
          await _checkoutRepository.addCheckout(event.checkout);
          print('Done');
          emit(CheckoutLoading());
        }
        catch(_){}
      }
    });
  }
}
