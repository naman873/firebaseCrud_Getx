import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class Thought {
  String? name;
  String? desc;
  Timestamp? dateTime;
  String? idDoc;

  Thought({this.desc, this.dateTime, this.name});

  Thought.fromJson(QueryDocumentSnapshot data, String? id) {
    name = data["name"];
    dateTime = data["date"];
    desc = data["description"];
    idDoc = id;
  }
}
