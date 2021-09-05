import 'package:api/models/product_response.dart';
import 'package:dio/dio.dart';

class ApiHelper {
  ApiHelper._();
  static ApiHelper apiHelper = ApiHelper._();
  Dio dio = Dio();
  Future<List<dynamic>> getAllCategories() async {
    String url = 'https://fakestoreapi.com/products/categories';
    Response response = await dio.get(url);
    List<dynamic> categories = response.data;
    return categories;
  }

  Future<List<dynamic>> getCategoryProducts(String categoryName) async {
    String url = 'https://fakestoreapi.com/products/category/$categoryName';
    Response response = await dio.get(url);
    List<dynamic> products = response.data;
    return products;
  }

  Future<List<dynamic>> getAllProducts() async {
    String url = 'https://fakestoreapi.com/products';
    Response response = await dio.get(url);
    List<dynamic> products = response.data;
    return products;
  }

  Future<dynamic> getSpecificProduct(int id) async {
    String url = 'https://fakestoreapi.com/products/$id';
    Response response = await dio.get(url);
    return response.data;
  }
}
