import 'dart:developer';

import 'package:global_configuration/global_configuration.dart';
import 'package:http/http.dart' as http;
class ProductRepo{
  Future<String> getAllProduct({required String categoryName}) async{
    String url="${GlobalConfiguration().getValue("base_url")}products/category/"+categoryName;
    log('Request url : '+url);
    const header={'Content-Type': 'application/json'};
    var response=await http.get(Uri.parse(url),headers: header);
    print(response.body);
    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw Exception('Failed to load album');
    }


  }
}