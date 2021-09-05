import 'package:api/providers/myprovider.dart';
import 'package:api/ui/home_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(ChangeNotifierProvider<HomeProvider>(
    create: (context) => HomeProvider(),
    child: MaterialApp(
      home: HomePage(),
    ),
  ));
}
