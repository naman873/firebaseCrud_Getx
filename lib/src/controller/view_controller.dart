import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:getx_firebase/src/modal/thought.dart';

class ViewController extends GetxController {
  RxList<Thought> thoughtList = RxList<Thought>([]);

  @override
  void onInit() {
    // TODO: implement onInit
    print("Hit");
    thoughtList.bindStream(fetchList());
    super.onInit();
  }

  sendDataToFireStore({String? name, String? desc, Timestamp? dateTime}) {
    FirebaseFirestore.instance
        .collection("thoughts")
        .add({"name": name, "description": desc, "date": dateTime});
  }

  deleteThought(id) {
    FirebaseFirestore.instance.collection("thoughts").doc(id).delete();
  }

  Stream<List<Thought>> fetchList() =>
      FirebaseFirestore.instance.collection("thoughts").snapshots().map(
          (query) => query.docs.map((e) => Thought.fromJson(e, e.id)).toList());
}
