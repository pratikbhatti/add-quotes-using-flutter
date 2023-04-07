

import 'package:demo43/screens/utility/DB/db_helper_quote.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class AddQuotesController extends GetxController {
  RxList<Map> quotes_data = <Map>[].obs;
  TextEditingController quotes_text = TextEditingController();
  TextEditingController author_text = TextEditingController();

  RxString dropdownvalue = 'Please Select'.obs;
  RxList items = ['Please Select'].obs;
  RxList<Map> data = <Map>[].obs;

  void getCategoryData() async {
    data.value = await DbHelperQuote.dbHelperQuote.readQuotesData();
    for(int i=0;i<data.value.length;i++)
      {
        items.add(data[i]['category_name']);
      }
    print(items);
    update();
    // print( "==========================${addQuotesController.data.value}");
  }

  void dropDownList ()
  {
    items.value = data[0]['category_name'];
    update();
  }
}
