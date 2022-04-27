import 'package:flutter/material.dart';
import 'package:xrstore/models/models.dart';

class HeroCarouselCard extends StatelessWidget {
  final Category category;
  final Product product;
  // ignore: use_key_in_widget_constructors
  const HeroCarouselCard({
    Key  key,
    this.category,
    this.product,
  }): super(key:key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if(product == null){
        Navigator.pushNamed(context, '/catalog',arguments: category);
        }
      },
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: Colors.grey[300],
          ),
          margin: const EdgeInsets.symmetric(
            horizontal: 5.0,
            vertical: 20,
          ),
            child: Stack(
              children: <Widget>[
                Image.network(
                    product == null ?category.imageUrl:product.imageUrl,
                    fit: BoxFit.fitHeight,
                    width: 1000.0
                ),
                Positioned(
                  bottom: 0.0,
                  left: 0.0,

                  child: Container(

                    padding: const EdgeInsets.symmetric(
                        vertical:10.0, horizontal: 20.0),
                    child: Text(
                        product == null ?category.name:'',
                        style: Theme.of(context).textTheme.headline2.copyWith(
                          color: Color(0xff3b4252),
                        )
                    ),
                  ),
                ),
              ],
            ),
          ),
      );
  }
}
