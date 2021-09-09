import 'dart:io';

import 'package:api/models/product_response.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DbHelper {
  DbHelper._();
  static DbHelper dbHelper = DbHelper._();
  Database database;
  initDatabase() async {
    database = await connectToDatabase();
  }

  Future<Database> connectToDatabase() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = directory.path + '/myEcommerce.db';
    Database database =
        await openDatabase(path, version: 1, onCreate: (db, version) {
      db.execute(
          '''CREATE TABLE Cart (id INTEGER PRIMARY KEY, title TEXT, price REAL, description TEXT,category TEXT,image TEXT)''');
      db.execute(
          '''CREATE TABLE Favourite (id INTEGER PRIMARY KEY, title TEXT, price REAL, description TEXT,category TEXT,image TEXT)''');
    });
    return database;
  }

  addProductToCart(ProductResponse productResponse) async {
    int x = await database.insert('Cart', productResponse.todBJson());
    print(x);
  }

  addProductToFavourite(ProductResponse productResponse) async {
    int x = await database.insert('Favourite', productResponse.todBJson());
    print(x);
  }

  Future<List<ProductResponse>> getAllCart() async {
    List<Map<String, Object>> list = await database.query('Cart');
    return list.map((e) => ProductResponse.fromJson(e)).toList();
  }

  Future<List<ProductResponse>> getAllFavourite() async {
    List<Map<String, Object>> list = await database.query('Favourite');
    return list.map((e) => ProductResponse.fromJson(e)).toList();
  }

  deleteProductFromCart(int id) async {
    database.delete('Cart', where: 'id=?', whereArgs: [id]);
  }

  deleteProductFromFavourite(int id) async {
    database.delete('Favourite', where: 'id=?', whereArgs: [id]);
  }
}
