import 'package:chating_app/models/messageModel.dart';
import 'package:chating_app/models/userModel.dart';
import 'package:flutter/material.dart';
import '../CustomWidgets/MessageFieldWidget.dart';
import '../CustomWidgets/MessageWidget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Chatpage extends StatelessWidget {
  Chatpage({super.key});
  static String id = 'chatpage';
  TextEditingController control = TextEditingController();
  static final controller = ScrollController();
  static final TextEditingController textControl = TextEditingController();

  List<Messagemodel> messagesR = [];

  bool isLoading = false;

  CollectionReference messages =
      FirebaseFirestore.instance.collection('messages');
  final Stream<QuerySnapshot> messagesQuery =
      FirebaseFirestore.instance.collection('messages').snapshots();

  @override
  Widget build(BuildContext context) {
    Usermodel email = ModalRoute.of(context)!.settings.arguments as Usermodel;
    return StreamBuilder<QuerySnapshot>(
      stream: messages.orderBy('createdAt', descending: false).snapshots(),
      // stream: messagesQuery,
      builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasData) {
          for (var element in snapshot.data!.docChanges) {
            if (element.type == DocumentChangeType.added) {
              messagesR.add(Messagemodel.formJson(element.doc));
            }
            // messagesR.add(Messagemodel.formJson(element));
          }
          // print(snapshot.data!.docs[1]['message']);
          return Scaffold(
            appBar: AppBar(
              backgroundColor: const Color.fromARGB(113, 47, 62, 157),
              automaticallyImplyLeading: false,
              title: const Text(
                'Chat IT',
                style: TextStyle(
                    fontWeight: FontWeight.bold, fontFamily: 'Cantarell'),
              ),
              centerTitle: true,
              elevation: 1,
            ),
            body: Column(
              children: [
                Expanded(
                  child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 10),
                      child: ListView.builder(
                        // reverse: true,
                        controller: controller,
                        key: const PageStorageKey('messageList'),
                        itemBuilder: (contex, index) =>
                            messagesR.elementAt(index).id == email.email
                                ? MessageBubbleOther(
                                    key: ValueKey(index),
                                    message: messagesR.elementAt(index),
                                  )
                                : MessageBubble(
                                    message: messagesR.elementAt(index)),
                        itemCount: messagesR.length,
                      )),
                ),
                MessageFieldWidget(messages: messages, id: email.email),
              ],
            ),
          );
        } else {
          return const Scaffold(
            body: CircularProgressIndicator(
              color: Colors.amber,
              backgroundColor: Colors.cyan,
            ),
          );
        }
      },
    );
  }
}
