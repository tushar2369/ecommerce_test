import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:ecommerce/Model/product_model.dart';
import 'package:ecommerce/Repository/ProductRepo.dart';
import 'package:meta/meta.dart';

part 'products_event.dart';
part 'products_state.dart';

class ProductsBloc extends Bloc<ProductsEvent, ProductsState> {
  ProductsBloc() : super(ProductsInitial());

  @override
  Stream<ProductsState> mapEventToState(
    ProductsEvent event,
  ) async* {

    if(event is GetAllProducts){
      yield ProductOnLoading();
      try{
        var response=await ProductRepo().getAllProduct(categoryName:event._categoryName!);
        List<ProductModel> _products=await productModelFromJson(response.toString());
        yield ProductOnSuccess(_products);
      }catch(e){
        yield ProductOnFailed('Something Wrong Please check your internet connection!'+e.toString());
      }
    }

  }
}
