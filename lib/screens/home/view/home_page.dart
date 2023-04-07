import 'dart:developer';
import 'dart:ui';

import 'package:blur/blur.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:demo43/screens/add_category/controller/add_category_controller.dart';
import 'package:demo43/screens/add_category/view/add_category_page.dart';
import 'package:demo43/screens/add_quotes/view/add_quotes_page.dart';
import 'package:demo43/screens/home/controller/home_controller.dart';
import 'package:demo43/screens/home/view/home_view.dart';
import 'package:demo43/screens/home/view/love_view_page.dart';
import 'package:demo43/screens/home/view/motivation_view_page.dart';
import 'package:demo43/screens/home/view/swaminarayan_view_page.dart';
import 'package:demo43/screens/utility/DB/db_helper_quote.dart';
import 'package:demo43/screens/utility/constant/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:sizer/sizer.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  HomeController homeController = Get.put(HomeController());
  AddCategoryController addCategoryController =
      Get.put(AddCategoryController());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }

  void getData() async {
    addCategoryController.data.value =
        await DbHelperQuote.dbHelperQuote.readCategoryData();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(5.0),
            child: Column(
              children: [
                Row(
                  children: [
                    InkWell(
                      onTap: () {
                        Get.defaultDialog(
                          backgroundColor: ColorStyle.black,
                          title: "Please Select",
                          titleStyle: TextStyle(color: ColorStyle.white),
                          titlePadding: EdgeInsets.only(top: 15),
                          content: Column(
                            children: [
                              TextButton(
                                onPressed: () {
                                  Get.to(AddQuotes());
                                },
                                child: Text("Add Quotes"),
                              ),
                              TextButton(
                                onPressed: () {
                                  Get.to(AddCategoryPage());
                                },
                                child: Text("Add Category"),
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  Get.back();
                                },
                                child: Text("Cancel"),
                              ),
                            ],
                          ),
                        );
                      },
                      child: Container(
                        alignment: Alignment.center,
                        height: 6.h,
                        width: 14.w,
                        child: Icon(
                          Icons.add,
                          shadows: [
                            Shadow(
                              color: ColorStyle.grey,
                              blurRadius: 10.0,
                              offset: Offset(
                                2,
                                2,
                              ),
                            ),
                          ],
                        ),
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: ColorStyle.grey,
                              blurRadius: 8.0,
                              spreadRadius: 2,
                              offset: Offset(
                                3,
                                3,
                              ),
                            )
                          ],
                          color: ColorStyle.white,
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(23.sp),
                          ),
                        ),
                      ),
                    ),
                    Spacer(),
                    Container(
                      alignment: Alignment.center,
                      height: 6.h,
                      width: 70.w,
                      child: Text(
                        "Amazing Quotes",
                        style: TextStyle(fontSize: 15.sp, shadows: [
                          Shadow(
                            offset: Offset(1.5.sp, 1.5.sp), //position of shadow
                            blurRadius: 4.0.sp, //blur intensity of shadow
                            color: ColorStyle.grey
                                .withOpacity(01), //color of shadow with opacity
                          ),
                        ]),
                      ),
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: ColorStyle.grey,
                            blurRadius: 8.0,
                            spreadRadius: 2,
                            offset: Offset(
                              3,
                              3,
                            ),
                          )
                        ],
                        color: ColorStyle.white,
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(23.sp),
                        ),
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 2.5.h,
                ),
                CarouselSlider.builder(
                  options: CarouselOptions(
                    onPageChanged: (index, _) {
                      homeController.change(index);
                    },
                    autoPlay: true,
                    aspectRatio: 12 / 5,
                    autoPlayInterval: Duration(seconds: 3),
                  ),
                  itemCount: homeController.carousel_images.length,
                  itemBuilder: (context, index, realIndex) {
                    return ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: Image.asset(
                        "${homeController.carousel_images[index]}",
                        fit: BoxFit.cover,
                      ),
                    );
                  },
                ),
                SizedBox(
                  height: 1.2.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: homeController.carousel_images.value
                      .asMap()
                      .entries
                      .map(
                        (e) => Obx(
                          () => Container(
                            height: 10,
                            width: 10,
                            margin: EdgeInsets.symmetric(horizontal: 5),
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color:
                                    homeController.carousel_index.value == e.key
                                        ? Colors.greenAccent
                                        : Colors.black),
                          ),
                        ),
                      )
                      .toList(),
                ),
                SizedBox(
                  height: 1.8.w,
                ),
                Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  elevation: 40,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Most Popular",
                            style: TextStyle(
                                fontSize: 14.5.sp, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: 1.2.h,
                          ),
                          Row(
                            children: [
                              InkWell(
                                onTap: () {
                                  // DbHelperQuote.dbHelperQuote.readMotivationViewData();
                                  Get.to(
                                    MotivationPage(),
                                  );
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    gradient: const RadialGradient(
                                      colors: [
                                        Colors.lightBlue,
                                        Colors.black45
                                      ],
                                      radius: 0.9,
                                    ),
                                    borderRadius: BorderRadius.circular(18),
                                  ),
                                  height:
                                      MediaQuery.of(context).size.height / 8,
                                  width:
                                      MediaQuery.of(context).size.width / 2.3,
                                  alignment: Alignment.center,
                                  child: Text(
                                    "Motivation",
                                    style: TextStyle(
                                        letterSpacing: 2,
                                        color: ColorStyle.white,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 13.sp),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 3.w,
                              ),
                              InkWell(
                                onTap: () {
                                  Get.to(LovePage());
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(18),
                                    gradient: const RadialGradient(
                                      colors: [
                                        Colors.lightBlue,
                                        Colors.black45
                                      ],
                                      radius: 0.9,
                                    ),
                                  ),
                                  height:
                                      MediaQuery.of(context).size.height / 8,
                                  width:
                                      MediaQuery.of(context).size.width / 2.3,
                                  alignment: Alignment.center,
                                  child: Text(
                                    "Love",
                                    style: TextStyle(
                                        letterSpacing: 2,
                                        color: ColorStyle.white,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 13.sp),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 1.6.h,
                          ),
                          Row(
                            children: [
                              Container(
                                height: MediaQuery.of(context).size.height / 8,
                                width: MediaQuery.of(context).size.width / 2.3,
                                alignment: Alignment.center,
                                child: Text(
                                  "Teaching",
                                  style: TextStyle(
                                      letterSpacing: 2,
                                      color: ColorStyle.white,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 13.sp),
                                ),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(18),
                                  gradient: const RadialGradient(
                                    colors: [Colors.lightBlue, Colors.black45],
                                    radius: 0.9,
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 3.w,
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  gradient: const RadialGradient(
                                    colors: [Colors.lightBlue, Colors.black45],
                                    radius: 0.9,
                                  ),
                                  borderRadius: BorderRadius.circular(18),
                                ),
                                height: MediaQuery.of(context).size.height / 8,
                                width: MediaQuery.of(context).size.width / 2.3,
                                alignment: Alignment.center,
                                child: Text(
                                  "Friendship",
                                  style: TextStyle(
                                      letterSpacing: 2,
                                      color: ColorStyle.white,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 13.sp),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 1.h,
                ),
                Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  elevation: 40,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Quotes by Author",
                            style: TextStyle(
                                fontSize: 14.5.sp, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: 1.2.h,
                          ),
                          Row(
                            children: [
                              InkWell(
                                onTap: () {
                                  Get.to(SwaminarayanPage());
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    gradient: const RadialGradient(
                                      colors: [
                                        Colors.lightBlue,
                                        Colors.black45
                                      ],
                                      radius: 0.9,
                                    ),
                                    borderRadius: BorderRadius.circular(18),
                                  ),
                                  height:
                                      MediaQuery.of(context).size.height / 8,
                                  width:
                                      MediaQuery.of(context).size.width / 2.3,
                                  alignment: Alignment.center,
                                  child: Text(
                                    "Swaminarayan",
                                    style: TextStyle(
                                        letterSpacing: 2,
                                        color: ColorStyle.white,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 13.sp),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 3.w,
                              ),
                              InkWell(
                                onTap: () {},
                                child: Container(
                                  decoration: BoxDecoration(
                                    gradient: const RadialGradient(
                                      colors: [
                                        Colors.lightBlue,
                                        Colors.black45
                                      ],
                                      radius: 0.9,
                                    ),
                                    borderRadius: BorderRadius.circular(18),
                                  ),
                                  height:
                                      MediaQuery.of(context).size.height / 8,
                                  width:
                                      MediaQuery.of(context).size.width / 2.3,
                                  alignment: Alignment.center,
                                  child: Text(
                                    "Sandeep",
                                    style: TextStyle(
                                        letterSpacing: 2,
                                        color: ColorStyle.white,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 13.sp),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 1.h,
                ),
                // Card(
                //   shape: RoundedRectangleBorder(
                //     borderRadius: BorderRadius.circular(10),
                //   ),
                //   elevation: 40,
                //   child: Container(
                //     child: Column(
                //       crossAxisAlignment: CrossAxisAlignment.start,
                //       children: [
                //         Padding(
                //           padding: const EdgeInsets.only(left: 7, right: 7),
                //           child: Row(
                //             children: [
                //               Text(
                //                 "Quotes by Category",
                //                 style: TextStyle(
                //                     fontSize: 14.5.sp,
                //                     fontWeight: FontWeight.bold),
                //               ),
                //               Spacer(),
                //               TextButton(
                //                 onPressed: () {},
                //                 child: Text("See More"),
                //               )
                //             ],
                //           ),
                //         ),
                //         Container(
                //           alignment: Alignment.center,
                //           height: MediaQuery.of(context).size.height / 7,
                //           width: MediaQuery.of(context).size.width,
                //           child: Obx(
                //             () => ListView.builder(
                //               scrollDirection: Axis.horizontal,
                //               itemCount: addCategoryController.data.length,
                //               itemBuilder: (context, index) {
                //                 return InkWell(
                //                   onTap: () async {
                //                     homeController.changeIndex(index);
                //                     Get.to(HomeView());
                //                     // log("============== ${addCategoryController.data[index]['category_name']}");
                //                     homeController.show_data.value =
                //                         await DbHelperQuote.dbHelperQuote
                //                             .readHomeViewData(
                //                                 addCategoryController
                //                                         .data[index]
                //                                     ['category_name']);

                //                     // log("${homeController.show_data.value}");
                //                     // print("============ ${addCategoryController.data[index]['category_name']}");

                //                     // Get.to(HomeView());
                //                   },
                //                   child: Padding(
                //                     padding: const EdgeInsets.only(
                //                         left: 8, right: 8, bottom: 8),
                //                     child: Container(
                //                       decoration: BoxDecoration(
                //                         borderRadius: BorderRadius.circular(18),
                //                       ),
                //                       child: Stack(
                //                         alignment: Alignment.center,
                //                         children: [
                //                           ClipRRect(
                //                             borderRadius:
                //                                 BorderRadius.circular(18.0),
                //                             child: Image.memory(
                //                               addCategoryController.data[index]
                //                                   ['category_image'],
                //                               fit: BoxFit.cover,
                //                             ).blurred(blur: 1.2),
                //                           ),
                //                           Center(
                //                             child: Text(
                //                               "${addCategoryController.data[index]['category_name']}",
                //                               style: TextStyle(
                //                                   letterSpacing: 2,
                //                                   color: ColorStyle.black,
                //                                   fontWeight: FontWeight.w600,
                //                                   fontSize: 13.sp),
                //                             ),
                //                           ),
                //                         ],
                //                       ),
                //                       height:
                //                           MediaQuery.of(context).size.height /
                //                               7.5,
                //                       width: MediaQuery.of(context).size.width /
                //                           2.3,
                //                     ),
                //                   ),
                //                 );
                //               },
                //             ),
                //           ),
                //         ),
                //       ],
                //     ),
                //   ),
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
