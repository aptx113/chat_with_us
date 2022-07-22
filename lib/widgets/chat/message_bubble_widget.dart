import 'package:chat_with_us/utils/logger.dart';
import 'package:chat_with_us/utils/measure_size_render_object.dart';
import 'package:flutter/material.dart';

class MessageBubleWidget extends StatefulWidget {
  const MessageBubleWidget({
    Key? key,
    required this.username,
    required this.message,
    required this.isMe,
    required this.userImage,
  }) : super(key: key);

  final String username;
  final String message;
  final bool isMe;
  final String userImage;

  @override
  State<MessageBubleWidget> createState() => _MessageBubleWidgetState();
}

class _MessageBubleWidgetState extends State<MessageBubleWidget> {
  var rowSize = Size.zero;

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Row(
          mainAxisAlignment:
              widget.isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
          children: [
            MeasureSize(
              onChange: (size) {
                setState(() {
                  rowSize = size;
                });
                logger.d('$rowSize');
              },
              child: Container(
                decoration: BoxDecoration(
                  color: widget.isMe
                      ? Colors.grey[300]
                      : Theme.of(context).colorScheme.secondary,
                  borderRadius: BorderRadius.only(
                      topLeft: const Radius.circular(12),
                      topRight: const Radius.circular(12),
                      bottomLeft: widget.isMe
                          ? const Radius.circular(12)
                          : const Radius.circular(0),
                      bottomRight: widget.isMe
                          ? const Radius.circular(0)
                          : const Radius.circular(12)),
                ),
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                margin: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
                child: Column(
                  crossAxisAlignment: widget.isMe
                      ? CrossAxisAlignment.end
                      : CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.username,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: widget.isMe
                            ? Colors.black
                            : Theme.of(context).colorScheme.onSecondary,
                      ),
                    ),
                    Text(
                      widget.message,
                      style: TextStyle(
                          color: widget.isMe
                              ? Colors.black
                              : Theme.of(context).colorScheme.onSecondary),
                      textAlign: widget.isMe ? TextAlign.end : TextAlign.start,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        Positioned(
          top: -10,
          left: widget.isMe ? null : rowSize.width - 30,
          right: widget.isMe ? rowSize.width - 30 : null,
          child: CircleAvatar(
            backgroundImage: NetworkImage(widget.userImage),
          ),
        )
      ],
    );
  }
}
