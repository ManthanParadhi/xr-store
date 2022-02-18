import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:xrstore/models/models.dart';

part 'wishlist_event.dart';
part 'wishlist_state.dart';

class WishlistBloc extends Bloc<WishlistEvent, WishlistState> {
  WishlistBloc() : super(WishlistLoading()){
// Start Wishlist
  on<StartWishlist>(
          (event, emit) async {
    emit(WishlistLoading());
    await Future<void>.delayed(const Duration(seconds: 1));
    emit(WishlistLoaded());

  });
// Add Wishlist Product
  on<AddWishlistProduct>(
          (event, emit) async {
        if (state is WishlistLoaded){
          emit(WishlistLoaded(wishlist: Wishlist(products:
          List.from(state.wishlist.products)..add(event.product),)));
        }

      });

    on<RemoveWishlistProduct>(
            (event, emit) async {
          if (state is WishlistLoaded){
            emit(WishlistLoaded(wishlist: Wishlist(products:List.from(state
                .wishlist.products)..remove(event.product),)));
          }

        });
  }

  //       else if (event is AddWishlistProduct) {
  //         yield* _mapAddWishlistProductToState(event, state);
  //       }
  //       else if (event is RemoveWishlistProduct) {
  //         yield* _mapRemoveWishlistProductToState(event, state);
  //       }
  //     }

  // }
  //   Stream<WishlistState> _mapAddWishlistProductToState(
  //   AddWishlistProduct event,
  //   WishlistState state,
  //   ) async* {
  //     if (state is WishlistLoaded){
  //       try {
  //         yield WishlistLoaded(wishlist: Wishlist(products: List.from(state
  //             .wishlist.products)..add(event.product),),);
  //       } catch (_){
  //         yield WishlistError();
  //       }
  //     }
  //   }
  //   Stream<WishlistState> _mapRemoveWishlistProductToState(
  //       RemoveWishlistProduct event,
  //       WishlistState state,
  //       ) async* {
  //     if (state is WishlistLoaded){
  //       try {
  //         yield WishlistLoaded(wishlist: Wishlist(products: List.from(state
  //             .wishlist.products)..remove(event.product),),);
  //       } on Exception{
  //         yield WishlistError();
  //       }
  //     }
  // }
}

