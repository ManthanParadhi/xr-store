import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/cart/cart_bloc.dart';
import '../blocs/wishlist/wishlist_bloc.dart';
import '../models/models.dart';
class CustomNavBar extends StatelessWidget {
  final String screen;
  final Product product;
  const CustomNavBar({
    Key key, this.screen, this.product
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      color: Color(0xff2e3440),
      child: Container(
        height: 70.0,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: _selectNavBar(context,screen),
        ),
      ),
    );
  }

  List<Widget> _selectNavBar(context, screen){
    switch(screen){
      case '/':
        return _buildNavBar(context);
      case '/catalog':
        return _buildNavBar(context);
      case '/wishlist':
        return _buildNavBar(context);
      case '/product':
        return _buildAddToCartNavBar(context,product);
      case '/cart':
        return _buildGoToCheckoutNavBar(context);
      case '/checkout':
        return _buildOrderNowNavBar(context);
      case '/signup':
        return _buildOrderNowNavBar(context);

    }
  }

  List<Widget> _buildNavBar(context){
    return [
      IconButton(onPressed: (){
        Navigator.popUntil(context,ModalRoute.withName('/'));
      }, icon: Icon(Icons.home, color: Color(0xffeceff4))),
      IconButton(onPressed: (){
        Navigator.pushNamed(context, '/cart');
      }, icon: Icon(Icons.shopping_cart, color: Color(0xffeceff4))),
      IconButton(onPressed: (){
        Navigator.pushNamed(context, '/signup');
      }, icon: Icon(Icons.person,color: Color(0xffeceff4))),
    ];
  }

  List<Widget> _buildAddToCartNavBar(context,product){
    return [
      IconButton(onPressed:(){}, icon: Icon(Icons.share), color:
      Color(0xffeceff4),),
      BlocBuilder<WishlistBloc, WishlistState>(
        builder: (context, state) {
          return IconButton(onPressed:(){
            context.read<WishlistBloc>().add(AddWishlistProduct(product));
            final snackBar = SnackBar(content: Text('Added to your Wishlist'));
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
          },
            icon: Icon(Icons.favorite),
            color: Color(0xffeceff4),);
        },
      ),
      BlocBuilder<CartBloc, CartState>(
        builder: (context, state) {
          if (state is CartLoading){
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is CartLoaded) {
            return ElevatedButton(onPressed: (){
              context.read<CartBloc>().add(CartProductAdded(product));
              Navigator.pushNamed(context, '/cart');
              final snackBar = SnackBar(content:
              Text('Added to your ''Cart')
              );
              ScaffoldMessenger.of(context).showSnackBar(snackBar);
            },
              style: ElevatedButton.styleFrom(primary: Color(0xffeceff4)),
              child: Text(
                'ADD TO CART',
                style: Theme.of(context).textTheme.headline3,),
            );
          }
          else{
            return Text('Something went Wrong!');
          }
        },
      ),
    ];
  }


  List<Widget> _buildGoToCheckoutNavBar(context){
    return [
      ElevatedButton(onPressed: (){
        Navigator.pushNamed(context, '/checkout');
      },
        style: ElevatedButton.styleFrom(primary: Colors.white),
        child: Text(
          'GO TO CHECKOUT',
          style: Theme.of(context).textTheme.headline3,),
      ),
    ];
  }


  List<Widget> _buildOrderNowNavBar(context){
    return [
      ElevatedButton(onPressed: (){},
        style: ElevatedButton.styleFrom(primary: Colors.white),
        child: Text(
          'ORDER NOW',
          style: Theme.of(context).textTheme.headline3,),
      ),
    ];
  }

}
