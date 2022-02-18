import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../models/product_model.dart';
import '../../repositories/product/product_repository.dart';

part 'product_event.dart';
part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final ProductRepository _productRepository;
  StreamSubscription _productSubscription;

  ProductBloc({
    ProductRepository productRepository
  })
      : _productRepository = productRepository,
        super(ProductLoading()) {
    on<LoadProducts>((event, emit) {
      _productSubscription?.cancel();
      _productSubscription = _productRepository.getAllProducts().listen(
            (products) => add(UpdateProducts(products)),
      );
    });
    on<UpdateProducts>((event, emit) {
      emit(ProductLoaded(products: event.products));
    });
  }
}
