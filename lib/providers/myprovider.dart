import 'package:api/data/api_helper.dart';
import 'package:api/models/product_response.dart';
import 'package:flutter/material.dart';

class HomeProvider extends ChangeNotifier {
  List<String> allCategories;
  List<ProductResponse> allProducts;
  List<ProductResponse> categoryProducts;
  ProductResponse selectedProduct;
  String selectedCategory = '';
  getAllCategories() async {
    List<dynamic> categories = await ApiHelper.apiHelper.getAllCategories();
    allCategories = categories.map((e) => e.toString()).toList();
    notifyListeners();
    getCategoryProducts(allCategories.first);
  }

  getCategoryProducts(String category) async {
    categoryProducts = null;
    this.selectedCategory = category;
    notifyListeners();
    List<dynamic> products =
        await ApiHelper.apiHelper.getCategoryProducts(category);
    categoryProducts =
        products.map((e) => ProductResponse.fromJson(e)).toList();
    notifyListeners();
  }

  getAllProducts() async {
    List<dynamic> products = await ApiHelper.apiHelper.getAllProducts();
    allProducts = products.map((e) => ProductResponse.fromJson(e)).toList();
    notifyListeners();
  }

  getSpecificProduct(int id) async {
    selectedProduct = null;
    notifyListeners();
    dynamic response = await ApiHelper.apiHelper.getSpecificProduct(id);
    selectedProduct = ProductResponse.fromJson(response);
    notifyListeners();
  }
}
// cart
// favourite
