import 'package:api/data/api_helper.dart';
import 'package:api/data/db_helper.dart';
import 'package:api/models/product_response.dart';
import 'package:flutter/material.dart';

class HomeProvider extends ChangeNotifier {
  List<ProductResponse> cartProducts;
  List<ProductResponse> favouriteProducts;

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

  addToCart(ProductResponse productResponse) async {
    await DbHelper.dbHelper.addProductToCart(productResponse);
    getAllCartProdcts();
  }

  addToFavourite(ProductResponse productResponse) async {
    await DbHelper.dbHelper.addProductToFavourite(productResponse);
    getAllFavouriteProdcts();
  }

  deleteFromCart(int id) async {
    await DbHelper.dbHelper.deleteProductFromCart(id);
    getAllCartProdcts();
  }

  deleteFromFavourite(int id) async {
    await DbHelper.dbHelper.deleteProductFromFavourite(id);
    getAllFavouriteProdcts();
  }

  getAllCartProdcts() async {
    List<ProductResponse> products = await DbHelper.dbHelper.getAllCart();
    this.cartProducts = products;
    notifyListeners();
  }

  getAllFavouriteProdcts() async {
    List<ProductResponse> products = await DbHelper.dbHelper.getAllFavourite();
    this.favouriteProducts = products;
    notifyListeners();
  }
}
// cart
// favourite
