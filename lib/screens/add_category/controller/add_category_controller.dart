import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddCategoryController extends GetxController {
  RxString path = "".obs;
  TextEditingController category_text = TextEditingController();
  RxList<Map> data = <Map>[].obs;
}
