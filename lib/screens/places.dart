import 'package:favorite_places/providers/users_places.dart';
import 'package:favorite_places/screens/add_place.dart';
import 'package:favorite_places/widgets/places_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Places extends ConsumerStatefulWidget {
  const Places({super.key});
  @override
  ConsumerState<Places> createState() {
    return _Places();
  }
}

class _Places extends ConsumerState<Places> {
  late Future<void> _placesfuture;
  @override
  void initState() {
    super.initState();

    _placesfuture = ref.read(userProvider.notifier).loadplaces();
  }

  @override
  Widget build(BuildContext context) {
    final userplace = ref.watch(userProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Your Places"),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (ctx) {
                  return const AddPlace();
                }));
              },
              icon: const Icon(Icons.add))
        ],
      ),
      body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: FutureBuilder(
            future: _placesfuture,
            builder: (context, snapshot) =>
                snapshot.connectionState == ConnectionState.waiting
                    ? const Center(child: CircularProgressIndicator())
                    : PlacesList(placeList: userplace),
          )),
    );
  }
}
