import 'package:api/models/product_response.dart';
import 'package:api/providers/myprovider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FavouriteProducts extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(title: Text('Favourite')),
      body: Consumer<HomeProvider>(
        builder: (context, provider, x) {
          List<ProductResponse> products = provider.favouriteProducts;
          return products == null
              ? Center(
                  child: Text('No Favourites'),
                )
              : GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 10,
                      crossAxisSpacing: 10),
                  itemCount: products.length,
                  itemBuilder: (context, index) {
                    return Stack(
                      children: [
                        CachedNetworkImage(
                            fit: BoxFit.cover, imageUrl: products[index].image),
                        Positioned.fill(
                            child: Align(
                          alignment: Alignment.topLeft,
                          child: Container(
                            margin: EdgeInsets.all(5),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.white,
                            ),
                            child: IconButton(
                                onPressed: () {
                                  provider
                                      .deleteFromFavourite(products[index].id);
                                },
                                icon: Icon(Icons.delete)),
                          ),
                        ))
                      ],
                    );
                  });
        },
      ),
    );
  }
}
