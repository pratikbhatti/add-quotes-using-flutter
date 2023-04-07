import 'package:demo43/screens/add_category/controller/add_category_controller.dart';
import 'package:demo43/screens/add_category/controller/update_category_controller.dart';
import 'package:demo43/screens/add_category/view/update_category_page.dart';
import 'package:demo43/screens/utility/DB/db_helper_quote.dart';

import 'package:demo43/screens/utility/constant/color.dart';
import 'package:demo43/screens/utility/constant/string.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class AllCategoryPage extends StatefulWidget {
  const AllCategoryPage({Key? key}) : super(key: key);

  @override
  State<AllCategoryPage> createState() => _AllCategoryPageState();
}

class _AllCategoryPageState extends State<AllCategoryPage> {
  AddCategoryController addCategoryController =
      Get.put(AddCategoryController());
  UpdateCategoryController updateCategoryController =
      Get.put(UpdateCategoryController());

  @override
  void initState() {
    super.initState();
    getCategoryData();
  }

  void getCategoryData() async {
    addCategoryController.data.value =
        await DbHelperQuote.dbHelperQuote.readCategoryData();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("${StringData.view_category_appbar_text}"),
          centerTitle: true,
          backgroundColor: ColorStyle.black,
        ),
        body: Obx(
          () => ListView.builder(
            itemCount: addCategoryController.data.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.only(top: 5, left: 5, right: 5),
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  elevation: 30,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 8, bottom: 8),
                    child: ListTile(
                      leading: CircleAvatar(
                        radius: 25.sp,
                        backgroundImage: MemoryImage(
                          addCategoryController.data[index]['category_image'],
                        ),
                      ),
                      title: Container(
                        width: MediaQuery.of(context).size.width / 1.5,
                        child: Text(
                          maxLines: 1,
                          "${addCategoryController.data[index]['category_name']}",
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                              onPressed: () {
                                updateCategoryController
                                        .update_category_text.text =
                                    addCategoryController.data[index]
                                        ['category_name'];
                                // updateQuotesController.edit_quotes_text.text =
                                // addQuotesController.quotes_data[index]
                                // ['quote_name'];

                                Get.defaultDialog(
                                  title: "Edit",
                                  content: Column(
                                    children: [
                                      TextFormField(
                                        controller: updateCategoryController
                                            .update_category_text,
                                        cursorColor: ColorStyle.black,
                                        style:
                                            TextStyle(color: ColorStyle.black),
                                        decoration: InputDecoration(
                                          labelText:
                                              '${StringData.add_quotes_label_text}',
                                          labelStyle: TextStyle(
                                              color: ColorStyle.black),
                                          hintText:
                                              '${StringData.add_quotes_hint_text}',
                                          hintStyle: TextStyle(
                                              color: ColorStyle.black),
                                          prefixIcon: Icon(
                                            Icons.format_quote,
                                            color: ColorStyle.black,
                                          ),
                                          enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: ColorStyle.black),
                                            borderRadius:
                                                BorderRadius.circular(15.0),
                                          ),
                                          border: new OutlineInputBorder(
                                            borderRadius: BorderRadius.all(
                                              Radius.circular(15),
                                            ),
                                            borderSide: new BorderSide(
                                                color: ColorStyle.black),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.all(
                                              Radius.circular(15),
                                            ),
                                            borderSide: BorderSide(
                                                width: 1,
                                                color: ColorStyle.black),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 1.2.h,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          ElevatedButton(
                                            onPressed: () {
                                              DbHelperQuote.dbHelperQuote.updateCategoryData(
                                                  id: addCategoryController
                                                      .data[index]['id'],
                                                  category_name:
                                                      updateCategoryController
                                                          .update_category_text
                                                          .text);
                                              getCategoryData();
                                              Get.back();
                                            },
                                            child: Text("Edit"),
                                          ),
                                          ElevatedButton(
                                            onPressed: () {
                                              Get.back();
                                            },
                                            child: Text("Cancel"),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                );
                                // print("strt========");
                                // updateCategoryController.update_path!.value = addCategoryController.data[index]['category_image'];
                                // // print("=========== ${updateCategoryController.update_path!.value}\n=== ${addCategoryController.path.value}");
                                // updateCategoryController
                                //         .update_category_text.text =
                                //     addCategoryController.data[index]
                                //         ['category_name'];
                                // getCategoryData();
                                // Get.to(UpdateCategoryPage());
                              },
                              icon: Icon(Icons.edit)),
                          IconButton(
                            onPressed: () {
                              DbHelperQuote.dbHelperQuote.deleteCategoryData(
                                  id: addCategoryController.data[index]['id']);
                              getCategoryData();
                            },
                            icon: Icon(
                              Icons.delete,
                              color: ColorStyle.red,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
