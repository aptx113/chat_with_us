import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'message_bubble_widget.dart';

class MessagesWidget extends StatelessWidget {
  const MessagesWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('chat')
          .orderBy('createdAt', descending: true)
          .snapshots(),
      builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        final chatDocs = (snapshot.data as QuerySnapshot<Object>).docs;
        return ListView.builder(
            reverse: true,
            itemCount: chatDocs.length,
            itemBuilder: (BuildContext context, int index) {
              final chatMap = chatDocs[index].data() as Map<String, dynamic>;
              return MessageBubleWidget(
                username: chatMap['username'],
                message: chatMap['text'],
                userImage: chatMap['userImage'],
                isMe: chatMap['userId'] == user?.uid,
                key: ValueKey(chatDocs[index].id),
              );
            });
      },
    );
  }
}
