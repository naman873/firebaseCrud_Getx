import 'package:get/get.dart';

class IncrementController extends GetxController {
  RxInt number = 0.obs;

  void increment() {
    number += 1;
  }

  void decrement() {
    number -= 1;
  }
}
