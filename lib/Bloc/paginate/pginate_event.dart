part of 'pginate_bloc.dart';

@immutable
abstract class PginateEvent {}
class GetProducts extends PginateEvent{
  BuildContext? _context;
  int? limit;
  GetProducts(this._context,{this.limit});
}