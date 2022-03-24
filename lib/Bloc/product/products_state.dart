part of 'products_bloc.dart';

@immutable
abstract class ProductsState {}

class ProductsInitial extends ProductsState {}
class ProductOnLoading extends ProductsState{}

class ProductOnSuccess extends ProductsState{
  List<ProductModel>? products;
  ProductOnSuccess(this.products);
}

class ProductOnFailed extends ProductsState{
  String? message;
  ProductOnFailed(this.message);
}