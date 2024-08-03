import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class ImageInput extends StatefulWidget {
  const ImageInput({super.key, required this.onPickImage});
  final void Function(File image) onPickImage;
  @override
  State<ImageInput> createState() {
    // TODO: implement createState
    return _ImageInput();
  }
}

class _ImageInput extends State<ImageInput> {
  File? selectedimage;
  void takePicture() async {
    final imagepicker = ImagePicker();
    final pickedimage = await imagepicker.pickImage(
      source: ImageSource.gallery,
    );
    if (pickedimage == null) {
      return;
    }
    setState(() {
      selectedimage = File(pickedimage.path);
    });
    widget.onPickImage(selectedimage!);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(
              width: 1,
              color: Theme.of(context).colorScheme.primary.withOpacity(0.2))),
      height: 200,
      width: double.infinity,
      alignment: Alignment.center,
      child: selectedimage == null
          ? TextButton.icon(
              icon: const Icon(Icons.camera),
              label: const Text("Take Picture"),
              onPressed: takePicture,
            )
          : GestureDetector(
              onTap: takePicture,
              child: Image.file(
                selectedimage!,
                fit: BoxFit.cover,
                width: double.infinity,
                height: double.infinity,
              ),
            ),
    );
  }
}
