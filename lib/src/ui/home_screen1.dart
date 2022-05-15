import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_firebase/src/controller/theme_controller.dart';
import 'package:getx_firebase/src/ui/view_thought.dart';

class HomePage1 extends StatefulWidget {
  const HomePage1({Key? key}) : super(key: key);

  @override
  _HomePage1State createState() => _HomePage1State();
}

class _HomePage1State extends State<HomePage1> {
  ThemeController themeController = Get.find<ThemeController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home Baby"),
        actions: [
          IconButton(
              onPressed: () {
                if (Get.isDarkMode) {
                  themeController.changeTheme(ThemeData.light());
                  themeController.saveTheme(false);
                } else {
                  themeController.changeTheme(ThemeData.dark());
                  themeController.saveTheme(true);
                }
              },
              icon: Get.isDarkMode
                  ? const Icon(Icons.light_mode_outlined)
                  : const Icon(Icons.dark_mode_outlined)),
        ],
      ),
      body: Center(
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            primary: Colors.indigo,
          ),
          onPressed: () {
            //Todo:Add Get Navigation
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (BuildContext context) {
                  return const ViewThought();
                },
              ),
            );
          },
          child: const Text("Go to see thought"),
        ),
      ),
    );
  }
}
