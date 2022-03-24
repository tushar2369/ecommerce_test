import 'package:ecommerce/Bloc/cart/cart_bloc.dart';
import 'package:ecommerce/Model/CartModel.dart';
import 'package:ecommerce/Model/product_model.dart';
import 'package:ecommerce/utils/database_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProductDetailsScreen extends StatefulWidget {
  ProductModel _pDetails;

  ProductDetailsScreen(this._pDetails, {Key? key}) : super(key: key);

  @override
  _ProductDetailsScreenState createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  DatabaseHelper databaseHelper=DatabaseHelper();
  @override
  void initState() {
    // TODO: implement initState
    //databaseHelper.insertCart(CartModel(widget._pDetails.id, widget._pDetails.title, widget._pDetails.image, 1, widget._pDetails.price,1));
   // databaseHelper.getCartList();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: Container(
        margin: EdgeInsets.only(bottom: 50),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [
              ///Slider...................................
              Container(
                  width: MediaQuery.of(context).size.width,
                  padding: const EdgeInsets.all(0.0),
                  child: Stack(
                    alignment: Alignment.bottomCenter,
                    children: [
                      Container(
                        height: MediaQuery.of(context).size.height * .50,
                        child: Image.network('${widget._pDetails.image}'),
                      ),
                    ],
                  )),

              ///Price ,Product Name
              Container(
                decoration: BoxDecoration(color: Colors.white, boxShadow: [
                  BoxShadow(
                    color: Color(0xFF656565).withOpacity(0.15),
                    blurRadius: 1.0,
                    spreadRadius: 0.2,
                  )
                ]),
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: 15.0, top: 10.0, right: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Expanded(
                            child: Text(
                              '${widget._pDetails.title}',
                              style: TextStyle(fontSize: 17),
                              maxLines: 3,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.end,
                      ),
                      Padding(padding: EdgeInsets.only(top: 5.0)),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Expanded(
                            child: Text(
                              'Category : ${widget._pDetails.category.toString().capitalized()}',
                              style: TextStyle(
                                  fontSize: 17, color: Colors.grey),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.end,
                      ),
                      Padding(padding: EdgeInsets.only(top: 5.0)),
                      ///Rating And Price .........................
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Container(
                            child: Row(
                              children: [
                                Text('Rating '),
                                SizedBox(width: 8.0,),
                                RatingBar.builder(
                                  initialRating: widget._pDetails.rating!.rate!,
                                  minRating: 0,
                                  direction: Axis.horizontal,
                                  allowHalfRating: true,
                                  itemCount: 5,
                                  itemSize: 20,
                                  itemPadding: EdgeInsets.symmetric(horizontal: 1.0),
                                  itemBuilder: (context, _) => Icon(
                                    Icons.star,
                                    color: Colors.amber,
                                    size: 2,
                                  ),
                                  onRatingUpdate: (rating) {
                                    print(rating);
                                  },
                                )
                              ],
                            ),
                          ),
                          Text(
                            '\u09F3${widget._pDetails.price}',
                            style: TextStyle(fontSize: 15.0,color: Theme.of(context).accentColor,fontWeight: FontWeight.w600),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                      const Padding(padding: EdgeInsets.only(bottom: 5.0)),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: ScreenUtil().setHeight(22),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Expanded(
                      child: Text(
                        'Description : ${widget._pDetails.description.toString().capitalized()}',
                        style: TextStyle(fontSize: 17, color: Colors.grey),
                        maxLines: 15,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                ),
              ),
            ],
          ),
        ),
      ),
      bottomSheet: GestureDetector(
        onTap: (){

         CartModel  cart= CartModel(widget._pDetails.id, widget._pDetails.title, widget._pDetails.image, 1, widget._pDetails.price,1);
         BlocProvider.of<CartBloc>(context).add(AddCart(context, cart));
         },
        child: Container(
          height: 50,
          width: double.infinity,
          color: Theme.of(context).primaryColor,
          child: Center(
            child: Text('Add To Cart',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 18),),
          ),
        ),
      ),
    );
  }
}

extension Capitalized on String {
  String capitalized() =>
      this.substring(0, 1).toUpperCase() + this.substring(1).toLowerCase();
}
