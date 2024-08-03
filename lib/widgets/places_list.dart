import 'package:favorite_places/screens/places_details.dart';
import 'package:flutter/material.dart';
import 'package:favorite_places/models/place.dart';

class PlacesList extends StatelessWidget {
  const PlacesList({super.key, required this.placeList});
  final List<Place> placeList;
  @override
  Widget build(BuildContext context) {
    return placeList.isEmpty
        ? Center(
            child: Text(
            "No places added",
            style: Theme.of(context)
                .textTheme
                .titleMedium!
                .copyWith(color: Theme.of(context).colorScheme.onBackground),
          ))
        : ListView.builder(
            itemCount: placeList.length,
            itemBuilder: (ctx, index) {
              return ListTile(
                leading: CircleAvatar(
                  backgroundImage: FileImage(placeList[index].image),
                  radius: 26,
                ),
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (ctx) {
                    return PlacesDetails(place: placeList[index]);
                  }));
                },
                title: Text(placeList[index].name,
                    style: Theme.of(context).textTheme.titleMedium!.copyWith(
                        color: Theme.of(context).colorScheme.onBackground)),
                subtitle: Text(
                    'Latitude :  ${placeList[index].location.latitude.toString()}   Longitude : ${placeList[index].location.longitude.toString()}',
                    style: Theme.of(context).textTheme.bodySmall!.copyWith(
                        color: Theme.of(context).colorScheme.onBackground)),
              );
            },
          );
  }
}
