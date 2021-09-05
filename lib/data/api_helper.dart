import 'package:api/models/product_response.dart';
import 'package:dio/dio.dart';

class ApiHelper {
  ApiHelper._();
  static ApiHelper apiHelper = ApiHelper._();
  Dio dio = Dio();
  Future<List<String>> getAllCategories() async {
    String url = 'https://fakestoreapi.com/products/categories';
    Response response = await dio.get(url);
    List<dynamic> categories = response.data;
    return categories.map((e) => e.toString()).toList();
  }

  Future<List<ProductResponse>> getCategoryProducts(String categoryName) async {
    String url = 'https://fakestoreapi.com/products/category/$categoryName';
    Response response = await dio.get(url);
    List<dynamic> products = response.data;
    return products.map((e) => ProductResponse.fromJson(e)).toList();
  }
}
