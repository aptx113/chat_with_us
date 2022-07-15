import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<Object>(
          stream: FirebaseFirestore.instance
              .collection('chats/cS8yT8hd37aeC498IfuZ/messages')
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            final docs = (snapshot.data as QuerySnapshot?)?.docs;
            return ListView.builder(
              itemCount: docs?.length,
              itemBuilder: (context, index) => Container(
                padding: const EdgeInsets.all(8),
                child: Text(docs![index]['text']),
              ),
            );
          }),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          FirebaseFirestore.instance
              .collection('chats/cS8yT8hd37aeC498IfuZ/messages')
              .add({'text': 'This was added by btn!'});
        },
      ),
    );
  }
}
