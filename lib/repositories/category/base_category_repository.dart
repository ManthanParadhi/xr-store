import 'package:xrstore/models/models.dart';

abstract class BaseCategoryRepository{
  Stream<List<Category>> getAllCategories();
}