part of 'products_bloc.dart';

@immutable
abstract class ProductsEvent {}


class GetAllProducts extends ProductsEvent{
   String? _categoryName;
  GetAllProducts(this._categoryName);
}