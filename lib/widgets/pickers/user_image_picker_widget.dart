import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class UserImagePickerWidget extends StatefulWidget {
  UserImagePickerWidget({Key? key}) : super(key: key);

  @override
  State<UserImagePickerWidget> createState() => _UserImagePickerWidgetState();
}

class _UserImagePickerWidgetState extends State<UserImagePickerWidget> {
  File? _pickedImage;
  Future<void> _pickImage() async {
    final photo = await ImagePicker().pickImage(source: ImageSource.camera);
    setState(() {
      _pickedImage = File(photo?.path as String);
    });
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
