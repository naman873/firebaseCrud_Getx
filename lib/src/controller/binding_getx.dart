import 'package:get/get.dart';
import 'package:getx_firebase/src/controller/increment_controller.dart';
import 'package:getx_firebase/src/controller/theme_controller.dart';
import 'package:getx_firebase/src/controller/view_controller.dart';

class StoreBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ThemeController());
    Get.lazyPut(() => IncrementController());
    Get.lazyPut(() => ViewController());
  }
}
