import 'package:demo43/screens/add_category/view/add_category_page.dart';
import 'package:demo43/screens/add_category/view/all_category_page.dart';
import 'package:demo43/screens/add_quotes/view/add_quotes_page.dart';
import 'package:demo43/screens/home/view/home_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:sizer/sizer.dart';

void main() {
  runApp(
    Sizer(
      builder: (context, orientation, deviceType) {
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          home: HomePage(),
        );
      },
    ),
  );
}
