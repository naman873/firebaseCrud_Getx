import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_firebase/src/controller/view_controller.dart';
import 'package:getx_firebase/src/ui/map_near_me.dart';

import 'add_tought.dart';

class ViewThought extends StatefulWidget {
  const ViewThought({Key? key}) : super(key: key);

  @override
  _ViewThoughtState createState() => _ViewThoughtState();
}

class _ViewThoughtState extends State<ViewThought> {
  ViewController controller = Get.find<ViewController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("View Thought"),
        actions: [
          ElevatedButton(
              onPressed: () {
                Get.to(() => const NearMe());
              },
              child: const Icon(Icons.airplanemode_on))
        ],
      ),
      floatingActionButton: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) {
                return const AddThought();
              },
            ),
          );
        },
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(
              20,
            ),
            color: Colors.indigo,
          ),
          padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
          child: const Text(
            "Add Today Thoughts",
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 16,
              color: Colors.white,
            ),
          ),
        ),
      ),
      body: Obx(
        () => ListView.builder(
            itemCount: controller.thoughtList.length,
            itemBuilder: (context, index) {
              var data = controller.thoughtList[index];
              return Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("${data.name}"),
                      IconButton(
                          onPressed: () {
                            controller.deleteThought(data.idDoc);
                          },
                          icon: const Icon(Icons.ten_k))
                    ],
                  ),
                  Text("${data.desc}"),
                  Text("${data.dateTime!.toDate()}"),
                  Text("${data.idDoc}"),
                  const Divider(),
                ],
              );
            }),
      ),
    );
  }
}
