import 'package:uuid/uuid.dart';
import 'dart:io';

const uuid = Uuid();

class PlaceLocation {
  const PlaceLocation({required this.latitude, required this.longitude});
  final double longitude;
  final double latitude;
}

class Place {
  Place(
      {required this.name,
      required this.image,
      required this.location,
      String? id})
      : id = id ?? uuid.v4();
  final String id;
  final String name;
  final File image;
  final PlaceLocation location;
}
