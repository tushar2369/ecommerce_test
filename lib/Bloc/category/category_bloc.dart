import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:ecommerce/Model/CategoryModel.dart';
import 'package:ecommerce/Model/product_model.dart';
import 'package:ecommerce/Repository/CategoryRepo.dart';
import 'package:ecommerce/Repository/ProductRepo.dart';
import 'package:meta/meta.dart';

part 'category_event.dart';
part 'category_state.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  CategoryBloc() : super(CategoryInitial());

  @override
  Stream<CategoryState> mapEventToState(
    CategoryEvent event,
  ) async* {
    // TODO: implement mapEventToState
    if(event is GetCategory){
      yield CategoryOnLoading();
      List<int> catSize=<int>[];
      try{
        var response=await CategoryRepo().getCategory();
        List<String> _categories=categoryFromJson(response);
        for (int i=0;i<_categories.length;i++) {
          var resposee=await ProductRepo().getAllProduct(categoryName: _categories[i]);
          List<ProductModel> _products= productModelFromJson(resposee.toString());
          catSize.add(_products.length);
        }
        yield CategoryOnSuccess(_categories,catSize);
      }catch(e){
        yield CategoryOnFailed('Something Wrong Please check your internet connection!');
      }

    }

  }
}
