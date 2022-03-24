part of 'cart_bloc.dart';

@immutable
abstract class CartState {}

class CartInitial extends CartState {}
class CartOnLoading extends CartState {}
class CartOnSuccess extends CartState{
  List<CartModel>? carts;
  CartOnSuccess(this.carts);
}

class CartOnFailed extends CartState{
  String? message;

  CartOnFailed(this.message);
}