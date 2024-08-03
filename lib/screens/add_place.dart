import 'package:favorite_places/models/place.dart';
import 'package:favorite_places/providers/users_places.dart';
import 'package:favorite_places/widgets/image_input.dart';
import 'package:favorite_places/widgets/location_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:io';

class AddPlace extends ConsumerStatefulWidget {
  const AddPlace({super.key});
  @override
  ConsumerState<AddPlace> createState() {
    return _AddPlace();
  }
}

class _AddPlace extends ConsumerState<AddPlace> {
  File? selectedimage;
  final _titlecontroler = TextEditingController();
  PlaceLocation? _selectedlocation;
  void savePlace() {
    final entertext = _titlecontroler.text;
    if (entertext.isEmpty ||
        selectedimage == null ||
        _selectedlocation == null) {
      return;
    }
    ref
        .read(userProvider.notifier)
        .addPlace(entertext, selectedimage!, _selectedlocation!);
    Navigator.of(context).pop();
  }

  @override
  void dispose() {
    _titlecontroler.dispose();
    super.dispose();
  }

  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add new Places"),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            TextField(
              decoration: const InputDecoration(labelText: 'Title'),
              controller: _titlecontroler,
              style:
                  TextStyle(color: Theme.of(context).colorScheme.onBackground),
            ),
            const SizedBox(
              height: 10,
            ),
            ImageInput(
              onPickImage: (image) {
                selectedimage = image;
              },
            ),
            const SizedBox(
              height: 10,
            ),
            LocationInput(
              onSelectLocation: (location) {
                _selectedlocation = location;
              },
            ),
            const SizedBox(
              height: 16,
            ),
            ElevatedButton.icon(
                icon: const Icon(Icons.add),
                onPressed: savePlace,
                label: const Text("Add Place"))
          ],
        ),
      ),
    );
  }
}
