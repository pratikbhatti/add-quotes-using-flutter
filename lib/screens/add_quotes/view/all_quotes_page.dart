import 'package:demo43/screens/add_quotes/controller/add_quotes_controller.dart';
import 'package:demo43/screens/add_quotes/controller/update_quotes_controller.dart';
import 'package:demo43/screens/utility/DB/db_helper_quote.dart';
import 'package:demo43/screens/utility/constant/color.dart';
import 'package:demo43/screens/utility/constant/string.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class AddQuotesPage extends StatefulWidget {
  const AddQuotesPage({Key? key}) : super(key: key);

  @override
  State<AddQuotesPage> createState() => _AddQuotesPageState();
}

class _AddQuotesPageState extends State<AddQuotesPage> {
  AddQuotesController addQuotesController = Get.put(AddQuotesController());
  UpdateQuotesController updateQuotesController =
      Get.put(UpdateQuotesController());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getQuoteData();
  }

  void getQuoteData() async {
    addQuotesController.quotes_data.value =
        await DbHelperQuote.dbHelperQuote.readQuoteData();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("${StringData.view_quotes_appbar_text}"),
          centerTitle: true,
          backgroundColor: ColorStyle.black,
        ),
        body: Obx(
          () => ListView.builder(
            itemCount: addQuotesController.quotes_data.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.only(top: 5, left: 5, right: 5),
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  elevation: 30,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 4, bottom: 4),
                    child: ListTile(
                      title: Text(
                          "${addQuotesController.quotes_data[index]['quote_name']}"),
                      subtitle: Text(
                          "${addQuotesController.quotes_data[index]['author_name']}"),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            onPressed: () {
                              updateQuotesController.edit_quotes_text.text =
                                  addQuotesController.quotes_data[index]
                                      ['quote_name'];
                              updateQuotesController.eidt_author_text.text =
                                  addQuotesController.quotes_data[index]
                                      ['author_name'];
                              Get.defaultDialog(
                                title: "Edit",
                                content: Column(
                                  children: [
                                    TextFormField(
                                      controller: updateQuotesController
                                          .edit_quotes_text,
                                      cursorColor: ColorStyle.black,
                                      style: TextStyle(color: ColorStyle.black),
                                      decoration: InputDecoration(
                                        labelText:
                                            '${StringData.add_quotes_label_text}',
                                        labelStyle:
                                            TextStyle(color: ColorStyle.black),
                                        hintText:
                                            '${StringData.add_quotes_hint_text}',
                                        hintStyle:
                                            TextStyle(color: ColorStyle.black),
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
                                      height: 1.5.h,
                                    ),
                                    TextFormField(
                                      controller: updateQuotesController
                                          .eidt_author_text,
                                      cursorColor: ColorStyle.black,
                                      style: TextStyle(color: ColorStyle.black),
                                      decoration: InputDecoration(
                                        labelText:
                                            '${StringData.add_author_label_text}',
                                        labelStyle:
                                            TextStyle(color: ColorStyle.black),
                                        hintText:
                                            '${StringData.add_author_hint_text}',
                                        hintStyle:
                                            TextStyle(color: ColorStyle.black),
                                        prefixIcon: Icon(
                                          Icons.auto_stories,
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
                                          MainAxisAlignment.center,
                                      children: [
                                        Text("Category :- "),
                                        SizedBox(
                                          width: 1.2.w,
                                        ),
                                        Text(
                                          "${addQuotesController.quotes_data[index]['select_category']}",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ],
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
                                            DbHelperQuote
                                                .dbHelperQuote
                                                .updateQuoteData(
                                                    id: addQuotesController
                                                            .quotes_data[index]
                                                        ['id'],
                                                    quote_name:
                                                        updateQuotesController
                                                            .edit_quotes_text
                                                            .text,
                                                    author_name:
                                                        updateQuotesController
                                                            .eidt_author_text
                                                            .text);
                                            getQuoteData();
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
                            },
                            icon: Icon(Icons.edit),
                          ),
                          IconButton(
                            onPressed: () {
                              DbHelperQuote.dbHelperQuote.deleteQuoteData(
                                  id: addQuotesController.quotes_data[index]
                                      ['id']);
                              getQuoteData();
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
