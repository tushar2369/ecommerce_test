
import 'package:ecommerce/Bloc/cart/cart_bloc.dart';
import 'package:ecommerce/Model/CartModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  void initState() {
    // TODO: implement initState
    BlocProvider.of<CartBloc>(context).add(GetAllCarts(context));
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cart'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.only(bottom: 0.0),
          height: MediaQuery.of(context).size.height - 120,
          child: BlocBuilder<CartBloc, CartState>(
            builder: (context, state) {
              if(state is CartOnSuccess){
                if(state.carts!=null){
                  return ListView.builder(
                      itemCount: state.carts!.length,
                      shrinkWrap: true,
                      physics:const ClampingScrollPhysics(),
                      itemBuilder: (context, index) {
                        return Container(
                          width: double.infinity,
                          height: 140,
                          padding: new EdgeInsets.all(8.0),
                          child: Row(

                            children: [
                              Checkbox(
                                value: state.carts![index].isSelected==1?true:false,
                                onChanged: (val){
                                  int select;
                                  if(val==true){
                                    select=1;
                                  }else{
                                    select=0;
                                  }
                                  CartModel  cart= CartModel.withId(state.carts![index].id,state.carts![index].productId, state.carts![index].title, state.carts![index].image, 1, state.carts![index].price,select);
                                  BlocProvider.of<CartBloc>(context).add(UpdateCart(context, cart));

                                },
                              ),

                              Flexible(
                                child: Card(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  color: Colors.white,
                                  elevation: 0,
                                  child: Stack(
                                    alignment: Alignment.centerLeft,
                                    children: <Widget>[

                                      Positioned(
                                          left: 0,
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            children: [
                                              Container(
                                                height: 100,
                                                width: 60,
                                                child: Image.network(state.carts![index].image!,fit: BoxFit.fill,),
                                              ),

                                            ],
                                          )
                                      ),
                                      Positioned(
                                          top: 10,
                                          left: 80,
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Container(
                                                width: 345*0.60,
                                                child: Text(
                                                    '${state.carts![index].title}'
                                                    ,style: TextStyle(
                                                    fontSize: 13,
                                                    fontWeight: FontWeight.w700
                                                ),maxLines: 2, overflow: TextOverflow.ellipsis
                                                ),
                                              ),
                                              SizedBox(height: 15,),
                                              ///Quantity Update...............
                                              Row(
                                                children: [
                                                  Padding(
                                                      padding: const EdgeInsets.symmetric(horizontal: 0.0,vertical: 0),
                                                      child: Row(
                                                        children: [
                                                          GestureDetector(
                                                            onTap: (){

                                                            },
                                                            child: Container(
                                                              height:20,
                                                              width: 20,
                                                              decoration: BoxDecoration(
                                                                  borderRadius: BorderRadius.circular(8.0),
                                                                  border: Border.all(width: 1.0,color: Colors.grey)
                                                              ),
                                                              child: Icon(Icons.add,size: 10,),
                                                            ),
                                                          ),


                                                          Container(
                                                            height: 20,
                                                            width: 20,
                                                            margin: EdgeInsets.symmetric(horizontal: 2.0),
                                                            child: Center(
                                                              child: Text('${state.carts![index].quantity}',style: TextStyle(fontSize: 12,color: Theme.of(context).accentColor,fontWeight: FontWeight.bold),),
                                                            ),
                                                          ),

                                                          GestureDetector(
                                                            onTap: (){
                                                              /*if(_totalQuantity>1) {
                                                                setState(() {
                                                                  _totalQuantity=_totalQuantity-1;
                                                                  print('total quantity '+_totalQuantity.toString());
                                                                });
                                                                BlocProvider.of<CartBloc>(context).add(CartDecrease(
                                                                    widget._cartData.specificationId.toString(),
                                                                    widget._cartData.productId.toString()));

                                                              }*/
                                                            },
                                                            child: Container(
                                                              height:20,
                                                              width: 20,
                                                              decoration: BoxDecoration(
                                                                  borderRadius: BorderRadius.circular(8.0),
                                                                  border: Border.all(width: 1.0,color: Colors.grey)
                                                              ),
                                                              child: Icon(Icons.remove,size: 10,),
                                                            ),
                                                          )

                                                        ],
                                                      )
                                                  ),


                                                ],
                                              ),

                                            ],
                                          )
                                      ),


                                      Positioned(
                                          bottom: 10,
                                          left: 80,
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.end,
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            children: [
                                              Text(
                                                " \u09F3${state.carts![index].price}",
                                                style: TextStyle(
                                                  color: Colors.black,

                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w400,
                                                  fontFamily: "Roboto",
                                                ),
                                                textAlign: TextAlign.center,
                                              ),
                                              SizedBox(width: 8.0,),
                                              ///Discount Price.............
                                              Container(
                                                child: Text(
                                                  " \u09F3${0.0}",
                                                  style: TextStyle(
                                                      color: Color(
                                                        0xff999999,
                                                      ),
                                                      fontSize: 12,
                                                      fontWeight: FontWeight.w400,
                                                      fontFamily: "Roboto",
                                                      decoration: TextDecoration.lineThrough
                                                  ),
                                                ),
                                              ),

                                              ///Delete item...........
                                            ],
                                          )
                                      ),

                                      Positioned(
                                        bottom: 10,
                                        right: 12.0,
                                        child: GestureDetector(
                                          onTap: (){
                                            // print('Hiiiiiiii');
                                           // BlocProvider.of<CartBloc>(context).add(CartItemDelete(widget._cartData.specificationId.toString(),widget._cartData.productId.toString()));
                                          },
                                          child: Container(
                                            child: Icon(Icons.delete_outlined,size:18,color: Color(0xffFF647C),
                                            ),
                                          ),
                                        ),
                                      )

                                      // Positioned(
                                      //   bottom: 10,
                                      //     right: 12,
                                      //     child: GestureDetector(
                                      //           onTap: (){
                                      //             Navigator.of(context).push(new MaterialPageRoute(builder: (context)=>Summary(orderID: widget._cartData.orderId.toString(),)));
                                      //           },
                                      //       child: Container(
                                      //           child: Text('Check Out',style: TextStyle(color: Color(0xff6979F8)),
                                      //           )
                                      //       ),
                                      //     )
                                      // ),


                                    ],
                                  ),

                                ),
                              ),
                            ],
                          ),

                        );
                      });
                }else{
                  return const Center(child: Text('No Items Available'),);
                }
              }else if(state is CartOnFailed){
                return Center(child: Text('${state.message!}'),);
              }else{
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          ),
        ),
      ),
      bottomSheet: GestureDetector(
        onTap: (){

          //CartModel  cart= CartModel(widget._pDetails.id, widget._pDetails.title, widget._pDetails.image, 1, widget._pDetails.price,1);
          BlocProvider.of<CartBloc>(context).add(CheckOutCart(context));
        },
        child: Container(
          height: 50,
          width: double.infinity,
          color: Theme.of(context).primaryColor,
          child: Center(
            child: Text('Checkout',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 18),),
          ),
        ),
      ),
    );
  }
}
