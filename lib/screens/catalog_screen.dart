import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:xrstore/models/models.dart';
import 'package:xrstore/widget/widget.dart';

import '../blocs/product/product_bloc.dart';

class CatalogScreen extends StatelessWidget {
  static const String routeName = '/catalog';
  static Route route( {Category category}){
    return MaterialPageRoute(
        builder: (_)=> CatalogScreen(category: category),
    );
  }
  final Category category;
  const CatalogScreen({ this.category});

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: CustomAppBar(title: category.name),
      bottomNavigationBar:const CustomNavBar(screen: routeName,),
      body: BlocBuilder<ProductBloc, ProductState>(
        builder: (context, state) {
          if (state is ProductLoading){
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if(state is ProductLoaded){
            return  GridView.builder(
         padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 20.0),
           gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
               crossAxisCount: 2, childAspectRatio: 1.15),
           itemCount: state.products.where((product) => product.category ==
               category.name).toList().length,
           itemBuilder: (BuildContext context, int index){
             return ProductCard(
                 product: state.products.where((product) => product.category
                     == category.name).toList()[index],
               widthFactor: 2.2,
             );
          });
          }
          else{return const Text('Something went wrong');}
        },
      ),
    );
  }
}
