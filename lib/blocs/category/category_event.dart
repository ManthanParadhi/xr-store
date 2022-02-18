part of 'category_bloc.dart';

abstract class CategoryEvent extends Equatable {
  const CategoryEvent();
}
class LoadCategories extends CategoryEvent{
  @override
  // TODO: implement props
  List<Object> get props => [];
}
class UpdateCategories extends CategoryEvent{
  final List<Category> categories;
  UpdateCategories(this.categories);

  @override
  // TODO: implement props
  List<Object> get props => [categories];
}