import 'package:get/get.dart';

class HomeController extends GetxController {
  RxList<Map> motivation_data = <Map>[].obs;
  RxList<Map> love_data = <Map>[].obs;
  RxList<Map> teaching_data = <Map>[].obs;
  RxList<Map> friendship_data = <Map>[].obs;
  RxList<Map> swaminarayan_data = <Map>[].obs;
  RxList<Map> sandeep_data = <Map>[].obs;

  RxList<Map> data = <Map>[].obs;
  RxList show_data=[].obs;
  /// list view
  RxInt view_index =0.obs;
  void changeIndex (int index)
  {
    view_index.value = index;
    update();
  }
  ///carousel slider
  RxInt carousel_index = 0.obs;
  RxList carousel_images = [
    "assets/images/quote_1.jpg",
    "assets/images/quote_2.jpg",
    "assets/images/quote_3.jpeg",
    "assets/images/quote_4.jpg",
    "assets/images/quote_5.jpg"
  ].obs;
  void change(index) {
    carousel_index.value = index;
    update();
  }
}
