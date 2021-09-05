import 'package:api/data/api_helper.dart';
import 'package:api/models/product_response.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Page'),
      ),
      body: Center(
        child: RaisedButton(
          onPressed: () async {
            List<ProductResponse> products =
                await ApiHelper.apiHelper.getCategoryProducts('jewelery');
            print(products);
          },
        ),
      ),
    );
  }
}
