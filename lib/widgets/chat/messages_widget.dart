import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'message_bubble_widget.dart';

class MessagesWidget extends StatelessWidget {
  const MessagesWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: Future.value(FirebaseAuth.instance.currentUser),
        builder: (context, futureSnapshot) {
          if (futureSnapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
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
              final user = futureSnapshot.data as User;
              return ListView.builder(
                reverse: true,
                itemCount: chatDocs.length,
                itemBuilder: (BuildContext context, int index) =>
                    MessageBubleWidget(
                  username: chatDocs[index]['username'],
                  message: chatDocs[index]['text'],
                  userImage: chatDocs[index]['userImage'],
                  isMe: chatDocs[index]['userId'] == user.uid,
                  key: ValueKey(chatDocs[index].id),
                ),
              );
            },
          );
        });
  }
}
