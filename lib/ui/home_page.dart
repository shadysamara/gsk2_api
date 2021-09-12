import 'dart:ui';

import 'package:api/data/api_helper.dart';
import 'package:api/data/sp_helper.dart';
import 'package:api/models/product_response.dart';
import 'package:api/providers/myprovider.dart';
import 'package:api/ui/cart.dart';
import 'package:api/ui/favourite_products.dart';
import 'package:api/ui/product_details.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        // bottomNavigationBar: BottomNavigationBar,
        backgroundColor: Colors.grey[300],
        appBar: AppBar(
          title: Text('Home Page'),
          actions: [
            IconButton(
              icon: Icon(Icons.favorite),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return FavouriteProducts();
                }));
              },
            ),
            IconButton(
              icon: Icon(Icons.shopping_bag),
              onPressed: () {
                // Provider.of<HomeProvider>(context, listen: false)
                //     .getFavourite();
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return CartPage();
                }));
              },
            )
          ],
        ),
        body: Consumer<HomeProvider>(
          builder: (context, provider, x) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                provider.allProducts == null
                    ? Container(
                        color: Colors.white,
                        height: 200,
                        child: Center(
                          child: CircularProgressIndicator(),
                        ),
                      )
                    : Container(
                        height: 200,
                        color: Colors.white,
                        padding: EdgeInsets.symmetric(vertical: 20),
                        child: CarouselSlider(
                            items: provider.allProducts
                                .map((e) =>
                                    CachedNetworkImage(imageUrl: e.image))
                                .toList(),
                            options: CarouselOptions(
                              height: 400,
                              aspectRatio: 16 / 9,
                              viewportFraction: 0.8,
                              initialPage: 0,
                              enableInfiniteScroll: true,
                              autoPlay: true,
                            )),
                      ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  child: Text(
                    'All Categories',
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 22),
                  ),
                ),
                Container(
                  height: 70,
                  child: provider.allCategories == null
                      ? Center(
                          child: CircularProgressIndicator(),
                        )
                      : SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: provider.allCategories
                                .map((e) => GestureDetector(
                                      onTap: () {
                                        provider.getCategoryProducts(e);
                                      },
                                      child: Container(
                                        margin:
                                            EdgeInsets.symmetric(horizontal: 2),
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 10, vertical: 15),
                                        decoration: BoxDecoration(
                                            color:
                                                provider.selectedCategory == e
                                                    ? Colors.orangeAccent
                                                    : Colors.blueAccent,
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        child: Text(
                                            e[0].toUpperCase() + e.substring(1),
                                            style: TextStyle(
                                                fontSize: 20,
                                                color: Colors.white)),
                                      ),
                                    ))
                                .toList(),
                          ),
                        ),
                ),
                Expanded(
                    // margin: EdgeInsets.all(10),
                    child: provider.categoryProducts == null
                        ? Center(
                            child: CircularProgressIndicator(),
                          )
                        : Container(
                            margin: EdgeInsets.all(10),
                            child: GridView.builder(
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 2,
                                        crossAxisSpacing: 10,
                                        mainAxisSpacing: 10),
                                itemCount: provider.categoryProducts.length,
                                itemBuilder: (context, index) {
                                  return GestureDetector(
                                    onTap: () {
                                      provider.getSpecificProduct(
                                          provider.categoryProducts[index].id);
                                      Navigator.of(context).push(
                                          MaterialPageRoute(builder: (context) {
                                        return ProductDetails();
                                      }));
                                    },
                                    child: Container(
                                      padding: EdgeInsets.all(5),
                                      color: Colors.white,
                                      child: Column(
                                        children: [
                                          Expanded(
                                            flex: 2,
                                            child: CachedNetworkImage(
                                              imageUrl: provider
                                                  .categoryProducts[index]
                                                  .image,
                                            ),
                                          ),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(provider
                                                  .categoryProducts[index]
                                                  .title),
                                              Row(
                                                children: [
                                                  Text('Price: ' +
                                                      provider
                                                          .categoryProducts[
                                                              index]
                                                          .price
                                                          .toString() +
                                                      '\$'),
                                                  Spacer(),
                                                  IconButton(
                                                      onPressed: () {
                                                        provider.addToFavourite(
                                                            provider.categoryProducts[
                                                                index]);
                                                      },
                                                      icon: Icon(
                                                        Icons.favorite,
                                                        color: provider
                                                                    .favouriteProducts
                                                                    ?.any((element) =>
                                                                        element
                                                                            .id ==
                                                                        provider
                                                                            .categoryProducts[index]
                                                                            .id) ??
                                                                false
                                                            ? Colors.red
                                                            : Colors.black,
                                                      ))
                                                ],
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                }),
                          ))
              ],
            );
          },
        ));
  }
}
