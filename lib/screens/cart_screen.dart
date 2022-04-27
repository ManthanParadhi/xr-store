import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:xrstore/blocs/cart/cart_bloc.dart';
import 'package:xrstore/models/models.dart';
import 'package:xrstore/widget/widget.dart';

class CartScreen extends StatelessWidget {
  static const String routeName = '/cart';
  static Route route(){
    return MaterialPageRoute(
        builder: (_)=> CartScreen()
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "Cart"),
      bottomNavigationBar:CustomNavBar(screen: routeName),
      body:
        BlocBuilder<CartBloc, CartState>(
          builder: (context, state) {
            if (state is CartLoading){
            return Center(child: CircularProgressIndicator(),);
            }
            if (state is CartLoaded){
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              state.cart.freeDeliveryString,
                              style: Theme.of(context).textTheme.headline5,
                            ),
                            ElevatedButton(onPressed: (){
                              Navigator.pushNamed(context, '/');
                            },
                              style: ElevatedButton.styleFrom(
                                primary: Color(0xff5e81ac),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)
                                ),
                                elevation: 0,
                              ),
                              child: Text(
                                'Add More Items',
                                style: Theme.of(context).textTheme.headline5.copyWith
                                  (color: Colors.white),
                              ),
                            ),
                          ],

                        ),
                        SizedBox(height: 10,),
                        SizedBox(
                          height: 400,
                          child: ListView.builder(
                              itemCount: state.cart.productQuantity(state
                                  .cart.products).keys.length,
                              itemBuilder: (BuildContext context,int index){
                                return CartProductCard(
                                    product: state.cart.productQuantity(state
                                        .cart.products).keys.elementAt(index),
                                  quantity:state.cart.productQuantity(state
                                      .cart.products).values.elementAt(index),
                                );
                              }),
                        )
                      ],
                    ),
                    OrderSummary()
                  ],
                ),
              );
            }
            else {
              return Text('Sorry! Something went wrong');
            }
  },
)
    );
  }
}



