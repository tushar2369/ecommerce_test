
import 'dart:convert';

List<ProductModel> productModelFromJson(String str) => List<ProductModel>.from(json.decode(str).map((x) => ProductModel.fromJson(x)));

String productModelToJson(List<ProductModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ProductModel {
  int? id;
  String? title;
  double? price;
  String? description;
  String? category;
  String? image;
  Rating? rating;

  ProductModel({
      this.id, 
      this.title, 
      this.price, 
      this.description, 
      this.category, 
      this.image, 
      this.rating});

  ProductModel.fromJson(dynamic json) {
    id = json["id"];
    title = json["title"];
    price = json["price"].toDouble();
    description = json["description"];
    category = json["category"];
    image = json["image"];
    rating = json["rating"] != null ? Rating.fromJson(json["rating"]) : null;
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["id"] = id;
    map["title"] = title;
    map["price"] = price;
    map["description"] = description;
    map["category"] = category;
    map["image"] = image;
    if (rating != null) {
      map["rating"] = rating?.toJson();
    }
    return map;
  }

}

class Rating {
  double? rate;
  int? count;

  Rating({
      this.rate, 
      this.count});

  Rating.fromJson(dynamic json) {
    rate = json["rate"].toDouble() ?? 0.0;
    count = json["count"]??0;
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["rate"] = rate;
    map["count"] = count;
    return map;
  }

}