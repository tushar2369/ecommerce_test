part of 'category_bloc.dart';

@immutable
abstract class CategoryState {}

class CategoryInitial extends CategoryState {}
class CategoryOnLoading extends CategoryState{}

class CategoryOnSuccess extends CategoryState{
  List<String>? categories;
  List<int>? catSize;
  CategoryOnSuccess(this.categories,this.catSize);
}

class CategoryOnFailed extends CategoryState{
  String? message;
  CategoryOnFailed(this.message);
}