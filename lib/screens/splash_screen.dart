import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';


class SplashScreen extends StatelessWidget {
  static const String routeName = '/splash';
  static Route route(){
    return MaterialPageRoute(
        builder: (_)=> SplashScreen()
    );
  }
  @override
  Widget build(BuildContext context) {
    Timer(Duration(seconds: 2), ()=>Navigator.popAndPushNamed(context, '/'));
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: SvgPicture.asset('assets/images/logo.svg'),
            ),
          ],
        ),
      );

  }
}
