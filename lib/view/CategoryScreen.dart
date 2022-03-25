import 'package:carousel_slider/carousel_slider.dart';
import 'package:ecommerce/Bloc/cart/cart_bloc.dart';
import 'package:ecommerce/Bloc/category/category_bloc.dart';
import 'package:ecommerce/Repository/CategoryRepo.dart';
import 'package:ecommerce/view/AllProductsScreen.dart';
import 'package:ecommerce/view/CartScreen.dart';
import 'package:ecommerce/view/ProductScreen.dart';
import 'package:ecommerce/view/ProfileScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({Key? key}) : super(key: key);

  @override
  _CategoryScreenState createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  @override
  void initState() {
    // TODO: implement initState
    BlocProvider.of<CategoryBloc>(context).add(GetCategory());
    BlocProvider.of<CartBloc>(context).add(GetAllCarts(context));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: const Text(
          "eCommerce",
          style: TextStyle(
            fontSize: 18,
          ),
        ),
        elevation: 5,
        centerTitle: true,
        actions: [
          GestureDetector(
            onTap: () {
              Navigator.push(context,
                  new MaterialPageRoute(builder: (context) => CartScreen()));
            },
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 5.0),
              child: Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Icon(Icons.shopping_cart,
                        color: Theme.of(context).buttonColor),
                  ),
                  Positioned(
                    top: 0,
                    right: 0,
                    child: Container(
                      height: 18,
                      width: 18,
                      decoration: BoxDecoration(
                          color: Colors.red.withOpacity(0.8),
                          borderRadius: BorderRadius.circular(20)),
                      child:
                          Center(child: BlocBuilder<CartBloc, CartState>(
                        builder: (context, state) {
                          if(state is CartOnSuccess && state.carts!=null){
                            return Text('${state.carts!.length}');
                          }else{
                            return const Text('0');
                          }

                        },
                      )),
                    ),
                  )
                ],
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const ProfileScreen()));
            },
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 8.0, horizontal: 5.0),
              child: Icon(Icons.person_outline,
                  color: Theme.of(context).buttonColor),
            ),
          ),
        ],
      ),
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.max,
            children: [
              ///Slider.........................
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * .20,
                child: CarouselSlider(
                    options: CarouselOptions(
                        autoPlay: true,
                        viewportFraction: 1.0,
                        onPageChanged: (index, reson) {
                          setState(() {
                            //_currentIndex=index;
                          });
                        }),
                    items: List.generate(
                        2,
                        (index) => Stack(
                              children: [
                                Container(
                                  height:
                                      MediaQuery.of(context).size.height * 30,
                                  width: MediaQuery.of(context).size.width,
                                  margin: EdgeInsets.all(16.0),
                                  child: ClipRRect(
                                      borderRadius: BorderRadius.circular(10.0),
                                      child: Image.asset(
                                        'assets/images/baner.jpg',
                                        fit: BoxFit.fill,
                                      )),
                                ),
                                Positioned(
                                    top: 75,
                                    left: 25,
                                    child: Container(
                                      child: Text(
                                        '',
                                        style: TextStyle(
                                            color: Colors.blueAccent,
                                            fontSize: 34,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ))
                              ],
                            ))),
              ),
              SizedBox(
                height: ScreenUtil().setHeight(15),
              ),

              ///Category heading ......................
              Container(
                padding: EdgeInsets.only(left: 16),
                child: Column(
                  children: [
                    Container(
                      padding: EdgeInsets.only(right: 16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Category',
                            style: TextStyle(
                                fontSize: 17,
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                          ),
                          GestureDetector(
                            onTap: () {
                              // Navigator.of(context).push(MaterialPageRoute(builder: (context)=>AllCategory()));
                            },
                            child: Text(
                              'Show All',
                              style: TextStyle(
                                fontSize: 13,
                                color: Theme.of(context).accentColor,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              ///Category ......................
              BlocBuilder<CategoryBloc, CategoryState>(
                builder: (context, state) {
                  if (state is CategoryOnSuccess && state.categories != null) {
                    return Container(
                      height: ScreenUtil().setHeight(340),
                      padding: const EdgeInsets.all(16),
                      child: GridView.builder(
                        itemCount: state.categories!.length,
                        gridDelegate:
                            const SliverGridDelegateWithMaxCrossAxisExtent(
                                maxCrossAxisExtent: 200,
                                childAspectRatio: 2 / 2,
                                crossAxisSpacing: 10,
                                mainAxisSpacing: 10),
                        itemBuilder: (BuildContext context, index) {
                          var t = state.categories![1].toString();
                          return GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => ProductScreen(
                                          state.categories![index])));
                            },
                            child: Container(
                              padding: const EdgeInsets.all(20),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: Theme.of(context)
                                    .accentColor
                                    .withOpacity(0.8),
                              ),
                              child: Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      state.categories![index]
                                          .toString()
                                          .capitalized(),
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    const SizedBox(
                                      height: 8.0,
                                    ),
                                    Text(
                                      state.catSize![index].toString(),
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 22,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                        primary: false,
                      ),
                    );
                  } else if (state is CategoryOnFailed) {
                    return Center(
                      child: Text('${state.message}'),
                    );
                  } else {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                },
              ),

              ///All Products................
             GestureDetector(
               onTap: (){
                 Navigator.push(context, new MaterialPageRoute(builder: (context)=>AllProductsScreen()));
               },
               child: Container(
                 height: 60,
                 margin: const EdgeInsets.all(16),
                 width: double.infinity,
                 decoration: BoxDecoration(
                   borderRadius: BorderRadius.circular(12.0),
                   color: Theme.of(context).primaryColor.withOpacity(0.2),
                 ),
                 child: Center(
                   child: Text('ALL PRODUCT',style: TextStyle(
                       fontSize: 22,fontWeight:
                   FontWeight.bold,letterSpacing: 3,

                   ),textAlign: TextAlign.center,),
                 ),
               ),
             )
            ],
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
