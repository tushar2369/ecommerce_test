part of 'pginate_bloc.dart';

@immutable
abstract class PginateState {}

class PginateInitial extends PginateState {}
class PaginateOnLoading extends PginateState{}
class PaginateOnSuccess extends PginateState{
  List<ProductModel>? products;

  PaginateOnSuccess(this.products);
}