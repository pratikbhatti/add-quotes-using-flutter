import 'dart:io';

import 'package:demo43/screens/add_category/controller/add_category_controller.dart';
import 'package:demo43/screens/add_category/view/all_category_page.dart';
import 'package:demo43/screens/utility/DB/db_helper_quote.dart';
import 'package:demo43/screens/utility/constant/color.dart';
import 'package:demo43/screens/utility/constant/string.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sizer/sizer.dart';

class AddCategoryPage extends StatefulWidget {
  const AddCategoryPage({super.key});

  @override
  State<AddCategoryPage> createState() => _AddCategoryPageState();
}

class _AddCategoryPageState extends State<AddCategoryPage> {
  AddCategoryController addCategoryController =
      Get.put(AddCategoryController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: ColorStyle.black,
          title: Text("${StringData.add_category_appbar_text}"),
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
                        "${StringData.add_category_pop_text}",
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
                  Get.to(AllCategoryPage());
                }
              },
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(9.0),
          child: Column(
            children: [
              Obx(
                () => (addCategoryController.path.value == "")
                    ? CircleAvatar(
                        radius: 50.sp,
                        backgroundImage: AssetImage(
                          "assets/images/profile.png",
                        ),
                      )
                    : CircleAvatar(
                        radius: 50.sp,
                        backgroundImage: FileImage(
                          File(
                            "${addCategoryController.path.value}",
                          ),
                        ),
                      ),
              ),
              ElevatedButton(
                onPressed: () {
                  sheetbar();
                },
                child: Text("${StringData.add_category_pic_image_text}"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: ColorStyle.black,
                ),
              ),
              SizedBox(
                height: 1.5.h,
              ),
              TextFormField(
                controller: addCategoryController.category_text,
                cursorColor: ColorStyle.black,
                style: TextStyle(color: ColorStyle.black),
                decoration: InputDecoration(
                  labelText: '${StringData.add_category_label_text}',
                  labelStyle: TextStyle(color: ColorStyle.black),
                  hintText: '${StringData.add_category_hint_text}',
                  hintStyle: TextStyle(color: ColorStyle.black),
                  prefixIcon: Icon(
                    Icons.category,
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
              ElevatedButton(
                onPressed: () {
                  // if (addCategoryController.category_text.text.isNotEmpty) {
                  //   for (int i = 0;
                  //   i < addCategoryController.data.length;
                  //   i++) {
                  //     if (addCategoryController.data[i]['category_name'] ==
                  //         addCategoryController.category_text.text) {
                  //       print("====================pratik");
                  //       Fluttertoast.showToast(
                  //         msg: "This Category Already Create",
                  //         toastLength: Toast.LENGTH_SHORT,
                  //         gravity: ToastGravity.TOP,
                  //         timeInSecForIosWeb: 1,
                  //         backgroundColor: ColorStyle.red,
                  //         textColor: ColorStyle.black,
                  //       );
                  //     }
                  //   }
                  // }
                   if (addCategoryController.path.value == "") {
                    Fluttertoast.showToast(
                      msg: "Please Enter Image",
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.TOP,
                      timeInSecForIosWeb: 1,
                      backgroundColor: ColorStyle.red,
                      textColor: ColorStyle.black,
                    );
                  } else if (addCategoryController.category_text.text.isEmpty) {

                    Fluttertoast.showToast(
                      msg: "Please Enter Category",
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.TOP,
                      timeInSecForIosWeb: 1,
                      backgroundColor: ColorStyle.red,
                      textColor: ColorStyle.black,
                    );
                  }
                  // else if(addCategoryController.category_text.text.isNotEmpty)
                  //   {
                  //     for (int i=0;i<addCategoryController.data.length;i++)
                  //       {
                  //         if(addCategoryController.data[i]['category_name'] == addCategoryController.category_text.text)
                  //           {
                  //             print("====================pratik");
                  //             Fluttertoast.showToast(
                  //               msg: "This Category Already Create",
                  //               toastLength: Toast.LENGTH_SHORT,
                  //               gravity: ToastGravity.TOP,
                  //               timeInSecForIosWeb: 1,
                  //               backgroundColor: ColorStyle.red,
                  //               textColor: ColorStyle.black,
                  //             );
                  //           }
                  //       }
                  //   }

                  else {
                    DbHelperQuote.dbHelperQuote.insertCategoryData(
                      category_name: addCategoryController.category_text.text,
                      path: addCategoryController.path.value,
                    );
                    Get.snackbar(
                      "Successfully Insert Category",
                      "${addCategoryController.category_text.text} added",
                      backgroundColor: ColorStyle.green,
                      duration: Duration(seconds: 1),
                    );
                    addCategoryController.category_text.clear();
                    addCategoryController.path.value = "";
                  }
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

  void sheetbar() {
    showModalBottomSheet(
      backgroundColor: ColorStyle.grey,
      context: context,
      builder: (context) {
        return Wrap(
          children: [
            ListTile(
              leading: Icon(Icons.camera),
              title: Text("Camera"),
              onTap: () async {
                ImagePicker pick = ImagePicker();
                XFile? img = await pick.pickImage(source: ImageSource.camera);
                addCategoryController.path.value = img!.path;
                // setState(() {
                //   path = img!.path;
                // });
              },
            ),
            ListTile(
              leading: Icon(Icons.image),
              title: Text("Gallery"),
              onTap: () async {
                ImagePicker pick = ImagePicker();
                XFile? img = await pick.pickImage(source: ImageSource.gallery);
                addCategoryController.path.value = img!.path;
                // setState(() {
                //   path = img!.path;
                // });
              },
            ),
            ListTile(
              leading: Icon(Icons.remove_circle_outline),
              title: Text("Remove Photo"),
              onTap: () async {
                addCategoryController.path.value = "";

                // setState(() {
                //   path = null;
                // });
              },
            ),
          ],
        );
      },
    );
  }
}
