import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_firebase/src/controller/binding_getx.dart';
import 'package:getx_firebase/src/controller/theme_controller.dart';
import 'package:getx_firebase/src/ui/home_screen.dart';
import 'package:getx_firebase/src/ui/home_screen1.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // ThemeController themeController = ThemeController();
    final themeController = Get.put(ThemeController());
    return GetMaterialApp(
      title: 'GetX',
      debugShowCheckedModeBanner: false,
      themeMode: themeController.theme,
      initialBinding: StoreBinding(),
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      // home: const HomeScreen(),
      home: const HomePage1(),
    );
  }
}
