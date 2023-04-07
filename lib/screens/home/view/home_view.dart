import 'package:demo43/screens/add_category/controller/add_category_controller.dart';
import 'package:demo43/screens/home/controller/home_controller.dart';
import 'package:demo43/screens/utility/DB/db_helper_quote.dart';
import 'package:demo43/screens/utility/constant/string.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  HomeController homeController = Get.put(HomeController());
  AddCategoryController addCategoryController =
      Get.put(AddCategoryController());

  void getData() async {
    addCategoryController.data.value = await DbHelperQuote.dbHelperQuote
        .readHomeViewData(
            "${homeController.show_data[homeController.view_index.value]['select_category']}");
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            title: Text("${homeController.view_index}"),
          ),
          body: Obx(() => ListView.builder(
                itemCount: homeController.show_data.length,
                itemBuilder: (context, index) {
                  return
                      //   Container(
                      //   child: Column(children: [
                      //     Text("${homeController.show_data[index]['quote_name']}"),
                      //     Text("data")
                      //   ],),
                      // );

                      ListTile(
                    title: Text(
                        "${homeController.show_data[homeController.view_index.value]['quote_name']}"),
                  );
                },
              ))),
    );
  }
}
