import 'package:ecommerce/Model/CartModel.dart';
import 'package:ecommerce/utils/database_helper.dart';

class CartRepo {
  DatabaseHelper _databaseHelper = DatabaseHelper();

  Future<List<CartModel>> getcarts() async {
    List<CartModel> carts = <CartModel>[];
    var result = await _databaseHelper.getCartList();

    for (var element in result) {
      carts.add(CartModel.fromMapObject(element));
    }
    return carts;
  }

  Future<int> addCart(CartModel? cartModel) async {
    List<CartModel> carts = <CartModel>[];
    var result = await _databaseHelper.insertCart(cartModel!);
    return result;
  }

  Future<int> updateCart(CartModel? cartModel) async {
    print("cart update : "+cartModel!.isSelected.toString());
    var result = await _databaseHelper.updateCart(cartModel);

    return result;
  }
  Future<int> deleteCart(int? id) async {
    var result = await _databaseHelper.deleteCart(id);
    return result;
  }


  Future<List<CartModel>> getcartsByPid(int? pid) async {
    List<CartModel> carts = <CartModel>[];
    var result = await _databaseHelper.getCartListById(pid);
    for (var element in result) {
      carts.add(CartModel.fromMapObject(element));
    }
    return carts;
  }
}
