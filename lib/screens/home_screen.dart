import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:xrstore/widget/widget.dart';
import '../blocs/category/category_bloc.dart';
import '../blocs/product/product_bloc.dart';

class HomeScreen extends StatelessWidget {

  static const String routeName = '/';

  static Route route() {
    return MaterialPageRoute(
        builder: (_) => HomeScreen()
    );
  }

  @override
  Widget build(BuildContext context) {
 
     return Scaffold(
      appBar: const CustomAppBar(title: "XR Store"),
      bottomNavigationBar:const CustomNavBar(screen: '/'),
      body: SingleChildScrollView(
        child: Column(
          children: [
            BlocBuilder<CategoryBloc, CategoryState>(
              builder: (context, state) {
                if (state is CategoryLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                if (state is CategoryLoaded) {
                  return CarouselSlider(
                    options: CarouselOptions(
                      aspectRatio: 1.5,
                      viewportFraction: 0.9,
                      enlargeCenterPage: true,
                      enlargeStrategy: CenterPageEnlargeStrategy.height,
                    ),
                    items: state.categories.map((category) =>
                        HeroCarouselCard(category: category)).toList(),
                  );
                }
                else {
                  return const Text('Something went wrong');
                }
              },
            ),
            const SectionTitle(title: "Recommended"),
            BlocBuilder<ProductBloc, ProductState>(
              builder: (context, state) {
                if (state is ProductLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                if (state is ProductLoaded) {
                  return ProductCarousel(products:
                  state.products
                      .where((product) => product.isRecommended).toList()
                  );
                }
                else {
                  return const Text('Something went wrong');
                }
              },
            ),

            const SectionTitle(title: "Most Popular"),
            BlocBuilder<ProductBloc, ProductState>(
              builder: (context, state) {
                if (state is ProductLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                if (state is ProductLoaded) {
                  return ProductCarousel(products: state.products
                      .where((product) => product.isPopular).toList()
                  );
                }
                else {
                  return const Text('Something went wrong');
                }
              },
            ),


          ],
        ),
      ),
    );
  }


}