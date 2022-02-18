import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:xrstore/blocs/cart/cart_bloc.dart';
import 'package:xrstore/blocs/wishlist/wishlist_bloc.dart';
import 'package:xrstore/models/models.dart';

class ProductCard extends StatelessWidget {
  final Product product;
  final double widthFactor;
  final double leftPosition;
  final bool isWishlist;
  const ProductCard({
    Key key,
    this.product,
    this.widthFactor = 2.5,
    this.leftPosition = 5,
    this.isWishlist = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        Navigator.pushNamed(context, '/product',arguments: product,);
      },
      child: Stack(
        children: [
          Container(
            width: MediaQuery.of(context).size.width / widthFactor,
            height: 150,
            child: Image.network(
              product.imageUrl,
              fit: BoxFit.cover,
            ),
          ),
          Positioned(
            top: 60,
            left: leftPosition,
            child: Container(
              width: MediaQuery.of(context).size.width / widthFactor - 5 -
                  leftPosition,
              height: 80,
              decoration: BoxDecoration(
                color: Colors.black.withAlpha(50),
              ),
            ),
          ),
          Positioned(
            top: 65,
            left: leftPosition + 5,
            child: Container(
              width: MediaQuery.of(context).size.width / widthFactor - 15 -
                  leftPosition,
              height: 70,
              decoration: BoxDecoration(
                color: Colors.black,
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Expanded(
                      flex: 3,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(product.name,
                            style:  Theme.of(context).textTheme.headline5.copyWith(color: Colors.white,),
                          ),

                          Text('\₹${product.price}',
                            style:  Theme.of(context).textTheme.headline6.copyWith(color: Colors.white,),
                          )
                        ],
                      ),
                    ),
                    BlocBuilder<CartBloc, CartState>(
                      builder: (context, state) {
                        if (state is CartLoading){
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                       if (state is CartLoaded) {
                          return Expanded(
                              child: IconButton(
                                  onPressed: () {
                                    context.read<CartBloc>().add(CartProductAdded(product));
                                    final snackBar = SnackBar(content: Text
                                      ('Added to your Cart'));
                                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                                  },
                                  icon: Icon(
                                    Icons.add_circle,
                                    color: Colors.white,
                                  )));
                        }
                       else{
                         return Text('Something went Wrong!');
                       }

                      },
),
                    isWishlist ? Expanded(
                        child: BlocBuilder<WishlistBloc, WishlistState>(
                        builder: (context, state) {
                          return IconButton(
                            onPressed: (){
                              context.read<WishlistBloc>().add
                                (RemoveWishlistProduct(product));
                              const snackBar = SnackBar(content: Text
                                ('Removed from your Wishlist'));
                              ScaffoldMessenger.of(context).showSnackBar(snackBar);
                            },
                            icon: Icon(Icons.delete, color: Colors.white,)
                        );
  },
)
                    )
                        :SizedBox(),

                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

