import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:path_provider/path_provider.dart';

class SplashScreen extends StatelessWidget {
  static const String routeName = '/splash';
  static Route route(){
    return MaterialPageRoute(
        builder: (_)=> SplashScreen()
    );
  }
  
  @override
  Widget build(BuildContext context) {
    Timer(const Duration(seconds: 1), ()=>Navigator.popAndPushNamed(context, '/'));
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
