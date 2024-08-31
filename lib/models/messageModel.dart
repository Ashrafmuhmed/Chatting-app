import 'package:cloud_firestore/cloud_firestore.dart';

class Messagemodel {
  String? message, username, timesent,id;
  Messagemodel({required this.message,required this.id});
  factory Messagemodel.formJson( jsondata) {
    return Messagemodel(message: jsondata['message'],id: jsondata['id']);
  }
}
