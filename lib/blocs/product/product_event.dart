part of 'product_bloc.dart';

abstract class ProductEvent extends Equatable {
  const ProductEvent();
}

class LoadProducts extends ProductEvent{
  @override
  // TODO: implement props
  List<Object> get props => [];
}
class UpdateProducts extends ProductEvent{
  final List<Product> products;
  UpdateProducts(this.products);

  @override
  // TODO: implement props
  List<Object> get props => [products];
}