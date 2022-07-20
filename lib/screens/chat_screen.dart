import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final auth = FirebaseAuth.instance;
    return Scaffold(
      appBar: AppBar(
        title: const Text('FlutterChat'),
        actions: [
          DropdownButton(
            icon: Icon(
              Icons.more_vert,
              color: Theme.of(context).primaryIconTheme.color,
            ),
            items: [
              DropdownMenuItem(
                value: 'logout',
                child: Row(
                  children: [
                    Icon(
                      Icons.exit_to_app,
                      color: Theme.of(context).iconTheme.color,
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    const Text('Logout'),
                  ],
                ),
              ),
            ],
            onChanged: (String? itemIdentifier) {
              if (itemIdentifier == 'logout') {
                auth.signOut();
              }
            },
          )
        ],
      ),
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
