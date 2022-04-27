import 'package:flutter/material.dart';
class CustomAppBar extends StatelessWidget with PreferredSizeWidget {
  final String title;
  const CustomAppBar({Key key,this.title}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Color(0xff2e3440),
      elevation: 0,
      centerTitle: true,
      title: Text(
        '$title',
        style: TextStyle(
          letterSpacing: 2.0,
          fontSize: 24.0,
          color: Color(0xffeceff4),
          fontFamily: 'Avenir',
          fontWeight: FontWeight.bold,
        ),
      ),
      actions: [IconButton(onPressed: (){Navigator.pushNamed(context, '/wishlist');}, icon: Icon(Icons.favorite))],
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(50.0);
}
