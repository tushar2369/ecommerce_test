import 'package:ecommerce/Bloc/product/products_bloc.dart';
import 'package:ecommerce/view/ProductDetails.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProductScreen extends StatefulWidget {
  String? _category;

  ProductScreen(this._category, {Key? key}) : super(key: key);

  @override
  _ProductScreenState createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {

  @override
  void initState() {
    // TODO: implement initState
    BlocProvider.of<ProductsBloc>(context).add(GetAllProducts(widget._category));
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget._category}'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(0.0),
          height: MediaQuery.of(context).size.height - 60,
          child: BlocBuilder<ProductsBloc, ProductsState>(
            builder: (context, state) {
              if(state is ProductOnSuccess){
                if(state.products!=null){
                   return ListView.builder(
                      itemCount: state.products!.length,
                      shrinkWrap: true,
                      physics:const ClampingScrollPhysics(),
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: (){
                            Navigator.push(context,  MaterialPageRoute(builder: (context)=>ProductDetailsScreen(state.products![index])));

                          },
                          child: Container(
                            width: double.infinity,
                            height: 140,
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
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
                                        ///Product Image............
                                        Positioned(
                                            left: 10,
                                            child: Column(
                                              mainAxisAlignment:
                                              MainAxisAlignment.center,
                                              crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                              children: [
                                                Container(
                                                  height: 100,
                                                  width: 100,
                                                  child: Image.network('${state.products![index].image}'),
                                                ),
                                              ],
                                            )),

                                        ///Product Name..........
                                        Positioned(
                                            top: 10,
                                            left: 120,
                                            child: Column(
                                              mainAxisAlignment:
                                              MainAxisAlignment.start,
                                              crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                Container(
                                                  width: ScreenUtil().setWidth(200),
                                                  child: Text('${state.products![index].title}',
                                                      style:const  TextStyle(
                                                          fontSize: 13,
                                                          fontWeight:
                                                          FontWeight.w700,),
                                                      maxLines: 2,
                                                      overflow:
                                                      TextOverflow.ellipsis),
                                                ),
                                                SizedBox(
                                                  height: 20,
                                                ),
                                              ],
                                            )),
                                        ///Product Category..........
                                        Positioned(
                                            top: 45,
                                            left: 120,
                                            child: Column(
                                              mainAxisAlignment:
                                              MainAxisAlignment.start,
                                              crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                Container(
                                                  width: ScreenUtil().setWidth(200),
                                                  child: Text('Category : ${state.products![index].category}',
                                                      style:const  TextStyle(
                                                        fontSize: 13,
                                                        color: Colors.grey,
                                                        fontWeight:
                                                        FontWeight.w400,),
                                                      maxLines: 1,
                                                      overflow:
                                                      TextOverflow.ellipsis),
                                                ),
                                                SizedBox(
                                                  height: 20,
                                                ),
                                              ],
                                            )),

                                        Positioned(
                                            bottom: 25,
                                            left: 120,
                                            child: Row(
                                              mainAxisAlignment:
                                              MainAxisAlignment.end,
                                              crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                              children: [
                                                ///Product Price............
                                                 Text(
                                                  " \u09F3 ${state.products![index].price.toString()}",
                                                  style: TextStyle(
                                                    color: Colors.red,
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.w800,
                                                    fontFamily: "Roboto",
                                                  ),
                                                  textAlign: TextAlign.center,
                                                ),
                                                SizedBox(
                                                  width: 8.0,
                                                ),


                                              ],
                                            )),

                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      });
                }else{
                  return const Center(child: Text('No Items Available'),);
                }
              }else if(state is ProductOnFailed){
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
    );
  }
}
