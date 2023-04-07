import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class UpdateCategoryController extends GetxController
{
  Rx<Uint8List>? update_path;
  TextEditingController update_category_text = TextEditingController();
}