import 'package:api/data/db_helper.dart';
import 'package:api/providers/myprovider.dart';
import 'package:api/ui/home_page.dart';
import 'package:api/ui/splach_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  DbHelper.dbHelper.initDatabase();
  runApp(ChangeNotifierProvider<HomeProvider>(
    create: (context) => HomeProvider(),
    child: MaterialApp(
      home: SplachScreen(),
    ),
  ));
}
