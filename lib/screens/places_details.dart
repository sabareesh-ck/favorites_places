import 'package:favorite_places/models/place.dart';
import 'package:flutter/material.dart';

class PlacesDetails extends StatelessWidget {
  const PlacesDetails({required this.place, super.key});
  final Place place;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(place.name),
        ),
        body: Stack(
          children: [
            Image.file(
              place.image,
              fit: BoxFit.cover,
              height: double.infinity,
              width: double.infinity,
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                alignment: Alignment.center,
                padding:
                    const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                      colors: [Colors.transparent, Colors.black54],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter),
                ),
                child: Text(
                    'Latitude :  ${place.location.latitude.toString()}   Longitude : ${place.location.longitude.toString()}',
                    style: Theme.of(context).textTheme.titleMedium!.copyWith(
                        color: Theme.of(context).colorScheme.onBackground)),
              ),
            ),
          ],
        ));
  }
}
