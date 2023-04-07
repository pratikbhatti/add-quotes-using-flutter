import 'package:demo43/screens/home/controller/home_controller.dart';
import 'package:demo43/screens/utility/DB/db_helper_quote.dart';
import 'package:demo43/screens/utility/constant/color.dart';
import 'package:demo43/screens/utility/constant/string.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class SandeepPage extends StatefulWidget {
  const SandeepPage({Key? key}) : super(key: key);

  @override
  State<SandeepPage> createState() => _SandeepPageState();
}

class _SandeepPageState extends State<SandeepPage> {
  HomeController homeController = Get.put(HomeController());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getSandeepData();
  }

  void getSandeepData() async {
    homeController.sandeep_data.value =
        await DbHelperQuote.dbHelperQuote.readSandeepMaheshwariData();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("${StringData.sandeep_view_appbar_text}"),
          centerTitle: true,
          backgroundColor: ColorStyle.black,
        ),
        body: Obx(
          () => ListView.builder(
            itemCount: homeController.sandeep_data.length,
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
                            width: MediaQuery.of(context).size.width / 0.5,
                            child: Text(
                                "${homeController.sandeep_data[index]['quote_name']}"),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width / 0.5,
                            alignment: Alignment.centerRight,
                            child: Text(
                              "~ ${homeController.sandeep_data[index]['author_name']}",
                              style: GoogleFonts.acme(),
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
