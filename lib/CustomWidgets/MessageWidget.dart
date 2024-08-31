import 'package:chating_app/models/messageModel.dart';
import 'package:flutter/material.dart';

class MessageBubble extends StatelessWidget {
  const MessageBubble({super.key, required this.message});
  final Messagemodel message;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Align(
        alignment: Alignment.centerLeft,
        child: ClipRRect(
          borderRadius: BorderRadiusDirectional.only(
              topStart: Radius.circular(30),
              topEnd: Radius.circular(30),
              bottomEnd: Radius.circular(30)),
          child: Container(
            padding: EdgeInsets.all(20),
            decoration: const BoxDecoration(
                gradient: LinearGradient(colors: [
              Color.fromARGB(255, 0, 217, 255),
              Color.fromARGB(255, 1, 92, 156)
            ], begin: Alignment.topLeft, end: Alignment.bottomRight)),
            child: Column(
              children: [
                Text(
                  message.id!,
                  textAlign: TextAlign.right,
                  style: TextStyle(fontSize: 4, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 1,
                ),
                Text(message.message!),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class MessageBubbleOther extends StatelessWidget {
  const MessageBubbleOther({super.key, required this.message});
  final Messagemodel message;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Align(
        alignment: Alignment.centerRight,
        child: ClipRRect(
          borderRadius: BorderRadiusDirectional.only(
              topStart: Radius.circular(30),
              topEnd: Radius.circular(30),
              bottomStart: Radius.circular(30)),
          child: Container(
            padding: EdgeInsets.all(20),
            decoration: const BoxDecoration(
                gradient: LinearGradient(colors: [
              Color.fromARGB(255, 0, 255, 110),
              Color.fromARGB(255, 16, 155, 254)
            ], begin: Alignment.topLeft, end: Alignment.bottomRight)),
            child: Column(
              children: [
                Text(
                  message.id!,
                  textAlign: TextAlign.right,
                  style: TextStyle(fontSize: 4),
                ),
                SizedBox(
                  height: 1,
                ),
                Text(message.message!),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
