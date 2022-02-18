import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class Product extends Equatable{
  final String name;
  final String category;
  final String imageUrl;
  final double price;
  final bool isRecommended;
  final bool isPopular;

  const Product({
   this.name,
    this.category,
    this.imageUrl,
    this.price,
    this.isPopular,
    this.isRecommended,
});
  @override
  List<Object> get props => [
    name,
    category,
    imageUrl,
    price,
    isPopular,
    isRecommended,
  ];
  static Product fromSnapshot(DocumentSnapshot snap){
    Product product = Product(name: snap['name'], category: snap['category'],
        imageUrl: snap['imageUrl'], price: double.parse(snap['price'].toString()),
        isPopular: snap['isPopular'], isRecommended: snap['isRecommended']);
    return product;
  }
}



