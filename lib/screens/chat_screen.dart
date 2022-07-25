import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

import '../utils/logger.dart';
import '../widgets/chat/messages_widget.dart';
import '../widgets/chat/new_message_widget.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  @override
  void initState() {
    super.initState();
    final fbm = FirebaseMessaging.instance;
    fbm.requestPermission();
    FirebaseMessaging.onMessage.listen((event) {
      logger.d('${event.notification?.title}');
      return;
    });
    FirebaseMessaging.onMessageOpenedApp.listen((event) {
      logger.d('${event.data}');
      return;
    });
    fbm.subscribeToTopic('chat');
  }

  @override
  Widget build(BuildContext context) {
    final auth = FirebaseAuth.instance;
    return Scaffold(
      appBar: AppBar(
        title: const Text('FlutterChat'),
        actions: [
          DropdownButton(
            underline: Container(),
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
        children: const [
          Expanded(
            child: MessagesWidget(),
          ),
          NewMessageWidget()
        ],
      ),
    );
  }
}
