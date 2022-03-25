import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:ecommerce/Bloc/product/products_bloc.dart';
import 'package:ecommerce/Model/product_model.dart';
import 'package:ecommerce/Repository/ProductRepo.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';

part 'pginate_event.dart';
part 'pginate_state.dart';

class PginateBloc extends Bloc<PginateEvent, PginateState> {
  PginateBloc() : super(PginateInitial());

  @override
  Stream<PginateState> mapEventToState(
    PginateEvent event,
  ) async* {
    // TODO: implement mapEventToState
    if(event is GetProducts){
      try{
        var response=await ProductRepo().getAllProductByPage(limit: event.limit);
        List<ProductModel> _products=await productModelFromJson(response.toString());
        yield PaginateOnSuccess(_products);
      }catch(e){
       // yield ProductOnFailed('Something Wrong Please check your internet connection!'+e.toString());
      }
    }

  }
}
