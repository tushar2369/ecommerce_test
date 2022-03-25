import 'package:ecommerce/Bloc/cart/cart_bloc.dart';
import 'package:ecommerce/Bloc/category/category_bloc.dart';
import 'package:ecommerce/Bloc/product/products_bloc.dart';
import 'package:ecommerce/utils/CustomColors.dart';
import 'package:ecommerce/view/CategoryScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:global_configuration/global_configuration.dart';

import 'Bloc/paginate/pginate_bloc.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await GlobalConfiguration().loadFromAsset("app_settings");
  runApp(
      MultiBlocProvider(
          providers: [
            BlocProvider<CategoryBloc>(
              create: (context) =>
                  CategoryBloc(),
            ),
            BlocProvider<ProductsBloc>(
              create: (context) =>
                  ProductsBloc(),
            ),
            BlocProvider<CartBloc>(
              create: (context) =>
                  CartBloc(),
            ),
            BlocProvider<PginateBloc>(
              create: (context) =>
                  PginateBloc(),
            ),
          ],
          child: MyApp())
  );
}


class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}


class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    ///Set color status bar
    SystemChrome.setSystemUIOverlayStyle( const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent //or set color with: Color(0xFF0000FF)
    ));
    return ScreenUtilInit(
        builder: ()=>
            MaterialApp(
              title: 'eCommerce',/**/
              theme: ThemeData(
                brightness: Brightness.light,
                backgroundColor: Colors.white,
                primaryColorLight: Colors.white,
                primaryColorBrightness: Brightness.light,
                primaryColor: primaryColor,
                accentColor: secondaryColor,
                visualDensity: VisualDensity.adaptivePlatformDensity,
              ),
              debugShowCheckedModeBanner: false,
              // home: OtpVerification(phoneNumber: '0170132',)
              // home: PhoneVerification(phoneNumber:'01703262527',password:'123456')
              home:const CategoryScreen(),

              // initialRoute: '/',
              // onGenerateRoute: RouteGenerator.generateroute,
            )
    );
  }
}
