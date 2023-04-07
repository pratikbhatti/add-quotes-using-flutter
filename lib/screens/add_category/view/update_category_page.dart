import 'dart:io';
import 'dart:typed_data';

import 'package:demo43/screens/add_category/controller/add_category_controller.dart';
import 'package:demo43/screens/add_category/controller/update_category_controller.dart';
import 'package:demo43/screens/utility/DB/db_helper_quote.dart';


import 'package:demo43/screens/utility/constant/color.dart';
import 'package:demo43/screens/utility/constant/string.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sizer/sizer.dart';

class UpdateCategoryPage extends StatefulWidget {
  const UpdateCategoryPage({Key? key}) : super(key: key);

  @override
  State<UpdateCategoryPage> createState() => _UpdateCategoryPageState();
}

class _UpdateCategoryPageState extends State<UpdateCategoryPage> {
  AddCategoryController addCategoryController =
      Get.put(AddCategoryController());
  UpdateCategoryController updateCategoryController = Get.put(
      UpdateCategoryController());

  @override
  void initState() {
    // TODO: implement initState
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
          backgroundColor: ColorStyle.black,
          title: Text("${StringData.update_quotes_appbar_text}"),
          elevation: 0,
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.all(9.0),
          child: Column(
            children: [
              Obx(
                () => (updateCategoryController.update_path!.value == "")
                    ? CircleAvatar(
                        radius: 50.sp,
                        backgroundImage: AssetImage(
                          "assets/images/profile.png",
                        ),
                      )
                    : CircleAvatar(
                        radius: 50.sp,
                        backgroundImage: MemoryImage(updateCategoryController.update_path!.value),
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
                controller: updateCategoryController.update_category_text,
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
                  // if (addCategoryController.path.value == "") {
                  //   Fluttertoast.showToast(
                  //     msg: "Please Enter Image",
                  //     toastLength: Toast.LENGTH_SHORT,
                  //     gravity: ToastGravity.TOP,
                  //     timeInSecForIosWeb: 1,
                  //     backgroundColor: ColorStyle.red,
                  //     textColor: ColorStyle.black,
                  //   );
                  // } else if (addCategoryController.category_text.text.isEmpty) {
                  //   Fluttertoast.showToast(
                  //     msg: "Please Enter Category",
                  //     toastLength: Toast.LENGTH_SHORT,
                  //     gravity: ToastGravity.TOP,
                  //     timeInSecForIosWeb: 1,
                  //     backgroundColor: ColorStyle.red,
                  //     textColor: ColorStyle.black,
                  //   );
                  // } else {
                  //   DbHelperQuote.dbHelperQuote.insertCategoryData(
                  //     category_name: addCategoryController.category_text.text,
                  //     path: addCategoryController.path.value,
                  //   );
                  //   Get.snackbar(
                  //     "Successfully Insert Category",
                  //     "${addCategoryController.category_text.text} added",
                  //     backgroundColor: ColorStyle.green,
                  //     duration: Duration(seconds: 1),
                  //   );
                  //   addCategoryController.category_text.clear();
                  //   addCategoryController.path.value = "";
                  // }
                },
                child: Text("Edit"),
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

                updateCategoryController.update_path!.value = img!.path as Uint8List;
                    // img!.path;
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
                updateCategoryController.update_path!.value = img!.path as Uint8List;
                // setState(() {
                //   path = img!.path;
                // });
              },
            ),
            ListTile(
              leading: Icon(Icons.remove_circle_outline),
              title: Text("Remove Photo"),
              onTap: () async {
                updateCategoryController.update_path!.value.clear();

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
