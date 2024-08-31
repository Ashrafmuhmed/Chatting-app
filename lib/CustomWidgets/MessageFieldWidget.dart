import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../Screens/chatpage.dart';

class MessageFieldWidget extends StatelessWidget {
  const MessageFieldWidget(
      {super.key, required this.messages, required this.id});
  final String id;
  final CollectionReference<Object?> messages;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        onSubmitted: (value) {
          messages.add({
            'message': value,
            'createdAt': DateTime.now().toString(),
            'id': id
          });
          Chatpage.textControl.clear();
          Chatpage.controller.animateTo(
              Chatpage.controller.position.maxScrollExtent,
              duration: Duration(seconds: 1),
              curve: Curves.bounceOut);
        },
        decoration: InputDecoration(
          suffixIcon: IconButton(
              alignment: Alignment.centerLeft,
              onPressed: () {},
              icon: Icon(Icons.send_outlined)),
          hintText: 'Send a message bro',
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(25),
              borderSide:
                  const BorderSide(color: Color.fromARGB(255, 46, 210, 255))),
          focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Color.fromARGB(255, 0, 0, 0)),
              borderRadius: BorderRadius.circular(25)),
        ),
      ),
    );
  }
}
