import 'package:favorite_places/models/place.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path_provider/path_provider.dart' as syspaths;
import 'package:path/path.dart' as path;
import 'package:sqflite/sqflite.dart' as sql;
import 'package:sqflite/sqlite_api.dart';

import 'dart:io';

Future<Database> getdatabase() async {
  final dbpath = await sql.getDatabasesPath();
  final db = await sql.openDatabase(path.join(dbpath, 'Places.db'),
      onCreate: (db, version) {
    return db.execute(
        "CREATE TABLE user_places(id TEXT PRIMARY KEY,title TEXT,image TEXT,lat REAL,long REAL)");
  }, version: 1);
  return db;
}

class UsersPlaces extends StateNotifier<List<Place>> {
  UsersPlaces() : super(const []);
  Future<void> loadplaces() async {
    final db = await getdatabase();
    final data = await db.query(
      'user_places',
    );
    final places = data
        .map((row) => Place(
            id: row['id'].toString(),
            name: row['title'].toString(),
            image: File(row['image'].toString()),
            location: PlaceLocation(
                latitude: row['lat'] as double,
                longitude: row['long'] as double)))
        .toList();
    state = places;
  }

  void addPlace(String name, File image, PlaceLocation location) async {
    final appDir = await syspaths.getApplicationDocumentsDirectory();
    final filename = path.basename(image.path);
    final copiedimage = await image.copy("${appDir.path}/$filename");
    final newPlace = Place(name: name, image: copiedimage, location: location);
    final db = await getdatabase();
    db.insert('user_places', {
      'id': newPlace.id,
      'title': newPlace.name,
      'image': copiedimage,
      'lat': newPlace.location.latitude,
      'long': newPlace.location.longitude
    });
    state = [newPlace, ...state];
  }
}

final userProvider =
    StateNotifierProvider<UsersPlaces, List<Place>>((ref) => UsersPlaces());
