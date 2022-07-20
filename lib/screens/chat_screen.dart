import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../widgets/chat/messages_widget.dart';
import '../widgets/chat/new_message_widget.dart';

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
      body: Column(
        children: [
          const Expanded(
            child: MessagesWidget(),
          ),
          NewMessageWidget()
        ],
      ),
    );
  }
}
