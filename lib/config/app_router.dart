import 'package:flutter/material.dart';
import 'package:xrstore/models/models.dart';
import 'package:xrstore/screens/screens.dart';

class AppRouter{
  static Route onGenerateRoute(RouteSettings settings){
    print('This is route: ${settings.name}');

    switch (settings.name){
      case '/':
        return HomeScreen.route();
      case HomeScreen.routeName:
        return HomeScreen.route();
      case SplashScreen.routeName:
        return SplashScreen.route();
      case SignupScreen.routeName:
        return SignupScreen.route();
      case CartScreen.routeName:
        return CartScreen.route();
      case ProductScreen.routeName:
        return ProductScreen.route(product: settings.arguments as Product);
      case CatalogScreen.routeName:
        return CatalogScreen.route(category: settings.arguments as Category);
      case WishlistScreen.routeName:
        return WishlistScreen.route();
      case CheckoutScreen.routeName:
        return CheckoutScreen.route();

      default:
        return _errorRoute();
    }
  }

  static Route _errorRoute(){
    return MaterialPageRoute(
        builder: (_)=> Scaffold(
          appBar: AppBar(title: Text('Error'),),
        )
    );
  }
}