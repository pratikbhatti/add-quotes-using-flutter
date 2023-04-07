import 'package:demo43/screens/home/controller/home_controller.dart';
import 'package:demo43/screens/utility/DB/db_helper_quote.dart';
import 'package:demo43/screens/utility/constant/color.dart';
import 'package:demo43/screens/utility/constant/string.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class SwaminarayanPage extends StatefulWidget {
  const SwaminarayanPage({Key? key}) : super(key: key);

  @override
  State<SwaminarayanPage> createState() => _SwaminarayanPageState();
}

class _SwaminarayanPageState extends State<SwaminarayanPage> {
  HomeController homeController = Get.put(HomeController());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getSwaminarayanData();
  }

  void getSwaminarayanData() async {
    homeController.swaminarayan_data.value =
    await DbHelperQuote.dbHelperQuote.readSwaminarayanViewData();
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("${StringData.swaminarayan_view_appbar_text}"),
          centerTitle: true,
          backgroundColor: ColorStyle.black,
        ),
        body:
        Obx(()=>
            ListView.builder(
              itemCount: homeController.swaminarayan_data.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: 30,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Container(
                              alignment: Alignment.center,
                              width: MediaQuery.of(context).size.width/0.5,
                              child: Text(
                                  "${homeController.swaminarayan_data[index]['quote_name']}"),
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width/0.5,
                              alignment: Alignment.centerRight,
                              child: Text(
                                "~ ${homeController.swaminarayan_data[index]['author_name']}",
                                style: GoogleFonts.acme(),
                              ),
                            ),
                            // Row(
                            //   mainAxisSize: MainAxisSize.min,
                            //   children: [],),
                          ],
                        ),
                      ),
                    ),
                  ),
                );

                // ListTile(title: Text("${homeController.motivation_data[index]['quote_name']}"),);
              },
            ),),
      ),
    );
  }
}
