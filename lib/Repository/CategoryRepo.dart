
import 'dart:convert';
import 'dart:developer';

import 'package:ecommerce/Model/CategoryModel.dart';
import 'package:global_configuration/global_configuration.dart';
import 'package:http/http.dart' as http;
class CategoryRepo{
  Future<String> getCategory() async{
    String url="${GlobalConfiguration().getValue("base_url")}products/categories";
    log('Request url : '+url);
    const header={'Content-Type': 'application/json'};
    var response=await http.get(Uri.parse(url),headers: header);
    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw Exception('Failed to load album');
    }


  }
}