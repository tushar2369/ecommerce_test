import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:ecommerce/Model/CategoryModel.dart';
import 'package:ecommerce/Repository/CategoryRepo.dart';
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
      try{
        var response=await CategoryRepo().getCategory();
        List<String> _categories=categoryFromJson(response);
        yield CategoryOnSuccess(_categories);
      }catch(e){
        yield CategoryOnFailed('Something Wrong Please check your internet connection!');
      }

    }

  }
}
