import 'package:firebase_core/firebase_core.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:xrstore/blocs/cart/cart_bloc.dart';
import 'package:xrstore/blocs/category/category_bloc.dart';
import 'package:xrstore/blocs/checkout/checkout_bloc.dart';
import 'package:xrstore/blocs/wishlist/wishlist_bloc.dart';
import 'package:xrstore/config/app_router.dart';
import 'package:xrstore/repositories/category/category_repository.dart';
import 'package:xrstore/repositories/checkout/checkout_repository.dart';
import 'package:xrstore/repositories/product/product_repository.dart';

import 'blocs/product/product_bloc.dart';
import 'config/theme.dart';
import 'screens/screens.dart';

Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  // Bloc.observer = SimpleBlocObserver();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => WishlistBloc()..add(StartWishlist())),
        BlocProvider(create: (_) => CartBloc()..add(CartStarted())),
        BlocProvider(create: (context)=>CheckoutBloc(cartBloc: context
            .read<CartBloc>(), checkoutRepository: CheckoutRepository())),
        BlocProvider(create: (_) => CategoryBloc(categoryRepository:
        CategoryRepository(),)..add(LoadCategories())),
        BlocProvider(create: (_) => ProductBloc(productRepository:
        ProductRepository(),)..add(LoadProducts()))
      ],
      child: MaterialApp(
        title: 'XRStore',
        theme: theme(),
        onGenerateRoute: AppRouter.onGenerateRoute,
        initialRoute: SplashScreen.routeName,
        home: HomeScreen(),
      ),
    );
  }
}



