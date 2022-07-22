import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class UserImagePickerWidget extends StatefulWidget {
  const UserImagePickerWidget({Key? key, required this.imagePickFunction})
      : super(key: key);

  final void Function(File pickedImage) imagePickFunction;

  @override
  State<UserImagePickerWidget> createState() => _UserImagePickerWidgetState();
}

class _UserImagePickerWidgetState extends State<UserImagePickerWidget> {
  File? _pickedImage;
  Future<void> _pickImage() async {
    final photo = await ImagePicker()
        .pickImage(source: ImageSource.camera, imageQuality: 50, maxWidth: 150);
    final pickedImage = File(photo?.path as String);
    setState(() {
      _pickedImage = pickedImage;
    });
    widget.imagePickFunction(pickedImage);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          radius: 40,
          backgroundImage:
              _pickedImage != null ? FileImage(_pickedImage!) : null,
        ),
        TextButton.icon(
          onPressed: _pickImage,
          style: ButtonStyle(
            textStyle: MaterialStateProperty.all(
              TextStyle(color: Theme.of(context).primaryColor),
            ),
          ),
          icon: const Icon(Icons.image),
          label: const Text('Add Image'),
        ),
      ],
    );
  }
}
