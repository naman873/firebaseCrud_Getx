import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_firebase/src/controller/view_controller.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

class AddThought extends StatefulWidget {
  final String? id;
  final String? title;
  final String? content;
  final DateTime? date;
  final String? tags;
  const AddThought(
      {Key? key, this.id, this.title, this.content, this.date, this.tags})
      : super(key: key);

  @override
  _AddThoughtState createState() => _AddThoughtState();
}

class _AddThoughtState extends State<AddThought> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();
  final TextEditingController _tagsController = TextEditingController();
  ViewController controller = Get.find<ViewController>();

  DateTime currentDate = DateTime.now();
  File? selectedImage;

  @override
  void initState() {
    if (widget.id != null) {
      _titleController.text = widget.title!;
      _contentController.text = widget.content!;
      _tagsController.text = widget.tags!;
      currentDate = widget.date!;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Thought"),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            const SizedBox(
              height: 10.0,
            ),
            buildTextForm(controller: _titleController, hintTxt: "Title"),
            const SizedBox(
              height: 30,
            ),
            buildTextForm(controller: _contentController, hintTxt: "Content"),
            const SizedBox(
              height: 30,
            ),
            buildTextForm(
                controller: _tagsController, hintTxt: "Add Today Tags"),
            const SizedBox(
              height: 30,
            ),
            showDate(),
            const SizedBox(
              height: 30,
            ),
            selectedImage != null
                ? Image.file(
                    selectedImage!,
                    height: 150,
                    width: 120,
                    fit: BoxFit.fill,
                  )
                : Container(),
            const SizedBox(
              height: 30,
            ),
            selectedImage == null
                ? buildImagePicker(context)
                : ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(
                        Colors.red,
                      ),
                    ),
                    onPressed: () {
                      setState(() {
                        selectedImage = null;
                      });
                    },
                    child: const Text("Remove Image"),
                  ),
            const SizedBox(
              height: 30,
            ),
            buildSubmitButton(),
          ],
        ),
      ),
    );
  }

  ElevatedButton buildSubmitButton() {
    return ElevatedButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(Colors.indigo),
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
          ),
        ),
        onPressed: () async {
          if (_titleController.text != "" &&
              _contentController.text != "" &&
              _tagsController.text != "") {
            try {
              controller.sendDataToFireStore(
                name: _titleController.text,
                desc: _contentController.text,
                dateTime: Timestamp.fromDate(currentDate),
              );
              _tagsController.text = "";
              _contentController.text = "";
              _titleController.text = "";
              Get.snackbar("Done", "Done", snackPosition: SnackPosition.BOTTOM);
            } on FirebaseException catch (e) {
              Get.snackbar("$e", "$e", snackPosition: SnackPosition.BOTTOM);
            }
          } else {
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              content: Text(
                "Enter Title,Content and Tag",
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              duration: Duration(seconds: 1),
              backgroundColor: Colors.black,
            ));
          }
        },
        child: const Text("Submit"));
  }

  Widget showDate() {
    return GestureDetector(
      onTap: dateSelect,
      child: Container(
        padding: const EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          border: Border.all(width: 0.2, color: Colors.blueGrey),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(DateFormat('dd-MMM-yyyy').format(currentDate)),
            const SizedBox(
              width: 20,
            ),
            const Icon(Icons.calendar_today),
          ],
        ),
      ),
    );
  }

  dateSelect() async {
    DateTime? date = await showDatePicker(
        context: context,
        initialDate: currentDate,
        firstDate: DateTime(1947),
        lastDate: DateTime(3000));

    if (date != null && date != currentDate) {
      setState(() {
        currentDate = date;
      });
    }
  }

  Widget buildImagePicker(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(Colors.green),
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
        ),
      ),
      onPressed: pickImage,
      child: const Text("Pick Image"),
    );
  }

  pickImage() async {
    ImagePicker image = ImagePicker();
    var img =
        await image.pickImage(source: ImageSource.gallery, imageQuality: 50);
    if (img != null) {
      setState(() {
        selectedImage = File(img.path);
      });
    }
  }

  Widget buildTextForm(
      {TextEditingController? controller, int? maxLines, String? hintTxt}) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 14),
      child: TextFormField(
        controller: controller,
        maxLines: maxLines,
        decoration: InputDecoration(
          hintText: hintTxt ?? "",
          disabledBorder: InputBorder.none,
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25.0),
            borderSide: const BorderSide(
              color: Colors.blue,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25.0),
            borderSide: const BorderSide(
              color: Colors.black,
              width: 0.2,
            ),
          ),
        ),
      ),
    );
  }
}
