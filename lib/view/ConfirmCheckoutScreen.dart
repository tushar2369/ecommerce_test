
import 'package:ecommerce/view/CategoryScreen.dart';
import 'package:flutter/material.dart';

class ConfirmCheckout extends StatelessWidget {
   double? price;
   ConfirmCheckout(this.price,{Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Thank you for your order!',style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),),
              SizedBox(height: 10,),
              Text('Total price : '+price.toString(),style: TextStyle(fontSize: 18),),
              SizedBox(height: 30,),
              ElevatedButton(
                onPressed: (){
                  Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(builder: (c) => CategoryScreen()),
                          (route) => false);
                },
                child: Text('Go Back'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
