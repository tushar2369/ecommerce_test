part of 'cart_bloc.dart';

@immutable
abstract class CartEvent {}
class GetAllCarts extends CartEvent{
  BuildContext? _context;
  GetAllCarts(this._context);
}

class AddCart extends CartEvent{
  BuildContext? _context;
  CartModel? _cartModel;
  AddCart(this._context, this._cartModel);
}


class UpdateCart extends CartEvent{
  BuildContext? _context;
  CartModel? _cartModel;
  UpdateCart(this._context, this._cartModel);
}

class CheckOutCart extends CartEvent{
  BuildContext? _context;
  CheckOutCart(this._context);
}

class DeleteCart extends CartEvent{
  BuildContext? _context;
  int? _id;
  DeleteCart(this._context, this._id);
}