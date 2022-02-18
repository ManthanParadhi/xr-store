import 'package:equatable/equatable.dart';
import 'package:xrstore/models/models.dart';

class Wishlist extends Equatable{
  final List<Product> products;
  const Wishlist({this.products = const <Product>[]});
  @override
  // TODO: implement props
  List<Object> get props => [products];

}