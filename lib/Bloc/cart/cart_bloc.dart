import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:ecommerce/Model/CartModel.dart';
import 'package:ecommerce/Repository/CartRepo.dart';
import 'package:ecommerce/view/ConfirmCheckoutScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc() : super(CartInitial());
  List<CartModel>? carts;
  @override
  Stream<CartState> mapEventToState(
    CartEvent event,
  ) async* {
    // TODO: implement mapEventToState

    if(event is GetAllCarts){
     // yield CartOnLoading();
      try{
        List<CartModel> _carts=await CartRepo().getcarts();
        print("Cart Size : "+_carts.length.toString());
        carts=_carts;
        yield CartOnSuccess(carts);
      }catch(e){
        yield CartOnFailed('Something wrong');
      }
    }

    if(event is AddCart){
      try{
        List<CartModel> preCart=await CartRepo().getcartsByPid(event._cartModel!.productId);
        if(preCart.length>0){
          preCart[0].quantity=preCart[0].quantity!+1;
          add(UpdateCart(event._context, preCart[0]));
        }else{
          int result=await CartRepo().addCart(event._cartModel!);
          add( GetAllCarts(event._context));
          ScaffoldMessenger.of(event._context!).showSnackBar( const SnackBar(content:Text('Product add to cart success')));
        }

      }catch(e){

      }
    }

    if(event is UpdateCart){
      try{
        print("Update event : "+event._cartModel!.quantity.toString());
        int result=await CartRepo().updateCart(event._cartModel!);
        if(result==1){
          print("update success : "+result.toString());
          add( GetAllCarts(event._context));
         // ScaffoldMessenger.of(event._context!).showSnackBar( const SnackBar(content:Text('Cart Update Success')));

        }
      }catch(e){

      }
    }


    if(event is CheckOutCart){
      try{
        double totalPrice=0.0;
        int i=0;
        for (var element in carts!) {
          if(element.isSelected==1){
            i++;
            totalPrice=totalPrice+(element.quantity!*element.price!);
            int result=await CartRepo().deleteCart(element.id);
          }
        }
        if(i>0){
          add( GetAllCarts(event._context));
          ScaffoldMessenger.of(event._context!).showSnackBar(  SnackBar(content:Text('Checkout Success .Price : '+totalPrice.toString())));

          Navigator.push(event._context!, new MaterialPageRoute(builder: (context)=>ConfirmCheckout(totalPrice)));

        }else{
          ScaffoldMessenger.of(event._context!).showSnackBar(  SnackBar(content:Text('No items in your cart ')));
        }
      }catch(e){

      }
    }

  }
}
