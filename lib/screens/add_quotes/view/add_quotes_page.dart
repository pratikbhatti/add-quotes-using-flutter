import 'package:demo43/screens/add_quotes/controller/add_quotes_controller.dart';
import 'package:demo43/screens/add_quotes/controller/update_quotes_controller.dart';
import 'package:demo43/screens/add_quotes/view/all_quotes_page.dart';
import 'package:demo43/screens/utility/DB/db_helper_quote.dart';
import 'package:demo43/screens/utility/DB/db_helper_quote.dart';
import 'package:demo43/screens/utility/constant/color.dart';
import 'package:demo43/screens/utility/constant/string.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/material/dropdown.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:sizer/sizer.dart';

class AddQuotes extends StatefulWidget {
  const AddQuotes({super.key});

  @override
  State<AddQuotes> createState() => _AddQuotesState();
}

class _AddQuotesState extends State<AddQuotes> {
  AddQuotesController addQuotesController = Get.put(AddQuotesController());
  UpdateQuotesController updateQuotesController = Get.put(UpdateQuotesController());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    addQuotesController.getCategoryData();
    // addQuotesController.dropdownvalue();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: ColorStyle.black,
          title: Text("${StringData.add_quotes_appbar_text}"),
          elevation: 0,
          centerTitle: true,
          actions: [
            PopupMenuButton<int>(
              icon: Icon(
                Icons.more_vert,
                color: ColorStyle.white,
              ),
              itemBuilder: (context) => [
                PopupMenuItem(
                  value: 1,
                  child: Row(
                    children: [
                      Icon(
                        Icons.data_usage,
                        color: ColorStyle.black,
                      ),
                      SizedBox(
                        width: 1.7.w,
                      ),
                      Text(
                        "${StringData.add_quotes_pop_text}",
                        style: TextStyle(color: ColorStyle.black),
                      ),
                    ],
                  ),
                ),
              ],
              offset: Offset(100, 40),
              color: ColorStyle.grey,
              elevation: 2,
              onSelected: (value) {
                if (value == 1) {
                  Get.to(AddQuotesPage());
                }
              },
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(9.0),
          child: Column(
            children: [
              TextFormField(
                controller: addQuotesController.quotes_text,
                cursorColor: ColorStyle.black,
                style: TextStyle(color: ColorStyle.black),
                decoration: InputDecoration(
                  labelText: '${StringData.add_quotes_label_text}',
                  labelStyle: TextStyle(color: ColorStyle.black),
                  hintText: '${StringData.add_quotes_hint_text}',
                  hintStyle: TextStyle(color: ColorStyle.black),
                  prefixIcon: Icon(
                    Icons.format_quote,
                    color: ColorStyle.black,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: ColorStyle.black),
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  border: new OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(15),
                    ),
                    borderSide: new BorderSide(color: ColorStyle.black),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(15),
                    ),
                    borderSide: BorderSide(width: 1, color: ColorStyle.black),
                  ),
                ),
              ),
              SizedBox(
                height: 1.5.h,
              ),
              TextFormField(
                controller: addQuotesController.author_text,
                cursorColor: ColorStyle.black,
                style: TextStyle(color: ColorStyle.black),
                decoration: InputDecoration(
                  labelText: '${StringData.add_author_label_text}',
                  labelStyle: TextStyle(color: ColorStyle.black),
                  hintText: '${StringData.add_author_hint_text}',
                  hintStyle: TextStyle(color: ColorStyle.black),
                  prefixIcon: Icon(
                    Icons.auto_stories,
                    color: ColorStyle.black,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: ColorStyle.black),
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  border: new OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(15),
                    ),
                    borderSide: new BorderSide(color: ColorStyle.black),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(15),
                    ),
                    borderSide: BorderSide(width: 1, color: ColorStyle.black),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    "Select Category :- ",
                  ),
                  Obx(
                        () =>
                        DropdownButton(

                          value: addQuotesController.dropdownvalue.value,
                          items: addQuotesController.items.value.map((itemone) {
                            return DropdownMenuItem(
                                value: itemone, child: Text(itemone));
                          }).toList(),
                          onChanged: (value) {
                            addQuotesController.dropdownvalue.value =
                                value.toString();
                          },
                        ),
                  ),
                ],
              ),
              ElevatedButton(
                onPressed: () {
                  if (addQuotesController.quotes_text.text.isEmpty) {
                    Fluttertoast.showToast(
                      msg: "Please Enter Quote Name",
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.TOP,
                      timeInSecForIosWeb: 1,
                      backgroundColor: ColorStyle.red,
                      textColor: ColorStyle.black,
                    );
                  } else if (addQuotesController.author_text.text.isEmpty) {
                    Fluttertoast.showToast(
                      msg: "Please Enter Author Name",
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.TOP,
                      timeInSecForIosWeb: 1,
                      backgroundColor: ColorStyle.red,
                      textColor: ColorStyle.black,
                    );
                  } else if (addQuotesController.dropdownvalue ==
                      "Please Select") {
                    Fluttertoast.showToast(
                      msg: "Please Select Category",
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.TOP,
                      timeInSecForIosWeb: 1,
                      backgroundColor: ColorStyle.red,
                      textColor: ColorStyle.black,
                    );
                  } else {
                    DbHelperQuote.dbHelperQuote.createQuoteDB();
                    DbHelperQuote.dbHelperQuote.insertQuoteData(
                        quote_name: addQuotesController.quotes_text.text,
                        author_name: addQuotesController.author_text.text,
                        select_category: "${addQuotesController.dropdownvalue}");

                    Get.snackbar(
                      "Successfully Insert quote",
                      "${addQuotesController.quotes_text.text} added",
                      backgroundColor: ColorStyle.green,
                      duration: Duration(seconds: 1),
                    );
                    addQuotesController.quotes_text.clear();
                    addQuotesController.author_text.clear();
                    addQuotesController.dropdownvalue.value = "Please Select";

                    // addQuotesController.getCategoryData();
                  }
                  // print(addQuotesController.items.value);
                },
                child: Text("Submit"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: ColorStyle.black,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
