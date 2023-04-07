import 'package:demo43/screens/home/controller/home_controller.dart';
import 'package:demo43/screens/utility/DB/db_helper_quote.dart';
import 'package:demo43/screens/utility/constant/color.dart';
import 'package:demo43/screens/utility/constant/string.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class LovePage extends StatefulWidget {
  const LovePage({Key? key}) : super(key: key);

  @override
  State<LovePage> createState() => _LovePageState();
}

class _LovePageState extends State<LovePage> {
  HomeController homeController = Get.put(HomeController());
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getMotivattionData();
  }
  void getMotivattionData() async {
    homeController.love_data.value =
    await DbHelperQuote.dbHelperQuote.readLoveViewData();
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("${StringData.love_view_appbar_text}"),
          centerTitle: true,
          backgroundColor: ColorStyle.black,
        ),
        body:
        Obx(()=>
        ListView.builder(
          itemCount: homeController.love_data.length,
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
                              "${homeController.love_data[index]['quote_name']}"),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width/0.5,
                          alignment: Alignment.centerRight,
                          child: Text(
                            "~ ${homeController.love_data[index]['author_name']}",
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
