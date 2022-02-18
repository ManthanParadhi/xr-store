import 'package:xrstore/models/models.dart';

abstract class BaseProduceRepository{
  Stream<List<Product>> getAllProducts();
}