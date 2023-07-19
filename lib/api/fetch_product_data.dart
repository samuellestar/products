import 'dart:convert';
import 'package:forms/models/product_model.dart';
import 'package:http/http.dart' as http;

Future<List<ProductModel>> fetchData() async {
  final url = Uri.parse('https://dummyjson.com/products');
  final response = await http.get(url);

  if (response.statusCode == 200) {
    final List jsonMap = json.decode(response.body)["products"];
    return jsonMap.map((e) => ProductModel.fromJson(e)).toList();
  } else {
    throw Exception('Failed to fetch product');
  }
}
