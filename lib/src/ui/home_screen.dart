import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_firebase/src/controller/increment_controller.dart';
import 'package:getx_firebase/src/controller/theme_controller.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int number = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // IncrementController controller = IncrementController();
    // IncrementController controller = Get.put(IncrementController());
    IncrementController controller = Get.find<IncrementController>();
    ThemeController controllerTheme = Get.find<ThemeController>();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Increment App"),
        actions: [
          IconButton(
              onPressed: () {
                if (Get.isDarkMode) {
                  controllerTheme.changeTheme(ThemeData.light());
                  controllerTheme.saveTheme(false);
                } else {
                  controllerTheme.changeTheme(ThemeData.dark());
                  controllerTheme.saveTheme(true);
                }
              },
              icon: Get.isDarkMode
                  ? const Icon(Icons.light_mode_outlined)
                  : const Icon(Icons.dark_mode_outlined))
        ],
      ),
      floatingActionButton: Row(
        children: [
          FloatingActionButton(onPressed: () {
            controller.increment();
            //Snackbar by Get
            // Get.snackbar("Snackbar Example", "Hello",
            //     snackPosition: SnackPosition.BOTTOM);
            //Dialog by Get
            // Get.defaultDialog(title: "Alert Dialog");
            //
            //Bottom sheet by get
            // Get.bottomSheet(
            //   Container(
            //     height: 50,
            //     color: Colors.grey,
            //   ),
            // );
          }),
          FloatingActionButton(onPressed: () {
            controller.decrement();
          }),
        ],
      ),
      body: Center(
        child: Obx(() {
          return Text("${controller.number}");
        }),
        //
        // 3 different ways to rebuild after state change
        //
        // GetBuilder<IncrementController>(
        //   builder: (sController) {
        //     return Text("${sController.number}");
        //   },
        // ),
        //
        // GetX<IncrementController>(builder: (sController) {
        //   return Text("${sController.number}");
        // }),
        //
        //     Obx(() {
        //   return Text("${controller.number}");
        // }),
      ),
    );
  }
}
