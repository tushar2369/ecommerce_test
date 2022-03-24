class CartModel {
  int? _id;
  int? _productId;
  String? _title;
  String? _image;
  int? _quantity;
  double? _price;
  int? _isSelected;

  CartModel(this._productId, this._title, this._image, this._quantity, this._price,this._isSelected);


  CartModel.withId(this._id, this._productId, this._title, this._image, this._quantity,
      this._price, this._isSelected);

  int? get id => _id;

  int? get productId => _productId;

  int? get quantity => _quantity;

  double? get price => _price;

  String? get title => _title;

  String? get image => _image;
  int? get isSelected=>_isSelected;

  set productId(int? id) {
    this._productId = id;
  }

  set quantity(int? qut) {
    this._quantity = qut;
  }

  set price(double? price) {
    this._price = price;
  }

  set title(String? title) {
    this._title = title;
  }

  set image(String? image) {
    this._image = image;
  }

  set isSelected(int? selected) {
    this._isSelected = selected;
  }

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    if (_id != null) {
      map['id'] = _id;
    }

    map['productId'] = _productId;
    map['quantity'] = _quantity;
    map['price'] = _price;
    map['title'] = _title;
    map['image'] = _image;
    map['isSelected'] = _isSelected;
    return map;
  }

  CartModel.fromMapObject(Map<String,dynamic> map){
    _id=map['id'];
    _productId=map['productId'];
    _quantity=map['quantity'];
    _price=map['price'];
    _title=map['title'];
    _image=map['image'];
    _isSelected=map['isSelected'];
  }
}
