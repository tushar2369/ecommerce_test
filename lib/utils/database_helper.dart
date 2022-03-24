import 'dart:io';

import 'package:ecommerce/Model/CartModel.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static DatabaseHelper? _databaseHelper;
  static Database? _database;

  String cartTable = 'cart_table';
  String id = 'id';
  String productId = 'productId';
  String quantity = 'quantity';
  String price = 'price';
  String title = 'title';
  String image = 'image';
  String isSelected = 'isSelected';

  DatabaseHelper._createIntance();

  factory DatabaseHelper() {
    if (_databaseHelper == null) {
      _databaseHelper = DatabaseHelper._createIntance();
    }

    return _databaseHelper!;
  }

  Future<Database> get database async{
    _database ??= await initializeDatabase();
    return _database!;
  }

  initializeDatabase()async{
    Directory directory=await getApplicationDocumentsDirectory();
    String path=directory.path+'ecomerce.db';
    var cartDatabase=openDatabase(path,version: 1,onCreate: _createDb);
    return cartDatabase;
  }
  void _createDb(Database db, int version) async {
    await db.execute(
        'CREATE TABLE $cartTable($id INTEGER PRIMARY KEY AUTOINCREMENT,$productId INTEGER,'
        '$quantity INTEGER, $price DOUBLE , $title TEXT,$image TEXT,$isSelected INTEGER )');
  }

  Future<List<Map<String,dynamic>>>getCartList()async{
    Database db=await this.database;
    var result=await db.rawQuery('SELECT * FROM $cartTable');
    print('Succecss Result '+result.toString());
    return result;
  }

  Future<int> insertCart(CartModel cartModel)async{
    Database db=await this.database;
    var result =await db.insert(cartTable, cartModel.toMap());
    return result;
  }

  Future<int> updateCart(CartModel cartModel)async{
    Database db=await this.database;
    print("update id : "+cartModel.id.toString());
    print("update quantity : "+cartModel.quantity.toString());
    var result =await db.update(cartTable, cartModel.toMap(),where: '$id=?',whereArgs: [cartModel.id]);
    print(result);
    return result;
  }

  Future<int> deleteCart(int? idd)async{
    Database db=await this.database;
    var result =await db.rawDelete('DELETE FROM $cartTable WHERE $id=$idd');
    print(result);
    return result;
  }


  Future<List<Map<String,dynamic>>>getCartListById(int? pid)async{
    Database db=await this.database;
    var result=await db.rawQuery('SELECT * FROM $cartTable WHERE $productId=$pid');
    print('Succecss Result '+result.toString());
    return result;
  }

}
