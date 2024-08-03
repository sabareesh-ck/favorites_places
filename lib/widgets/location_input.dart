import 'package:favorite_places/models/place.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class LocationInput extends StatefulWidget {
  const LocationInput({super.key, required this.onSelectLocation});
  final void Function(PlaceLocation location) onSelectLocation;
  @override
  State<LocationInput> createState() {
    return _LocationInput();
  }
}

class _LocationInput extends State<LocationInput> {
  double? lat;
  double? long;
  PlaceLocation? pickLocation;
  var isgettingLocation = false;
  void getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {}

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return;
    }

    setState(() {
      isgettingLocation = true;
    });
    final locationdata = await Geolocator.getCurrentPosition();
    lat = locationdata.latitude;
    long = locationdata.longitude;
    if (lat == null || long == null) {
      return;
    }
    setState(() {
      pickLocation = PlaceLocation(latitude: lat!, longitude: long!);
    });
    widget.onSelectLocation(pickLocation!);
    setState(() {
      isgettingLocation = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    String text = 'No location Chosen';
    if (lat != null) {
      text = 'Latitude : $lat - Longitude : $long';
    }
    return Column(
      children: [
        Container(
          alignment: Alignment.center,
          height: 170,
          width: double.infinity,
          decoration: BoxDecoration(
              border: Border.all(
                  width: 1,
                  color:
                      Theme.of(context).colorScheme.primary.withOpacity(0.2))),
          child: isgettingLocation
              ? const CircularProgressIndicator()
              : Text(
                  text,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                      color: Theme.of(context).colorScheme.onBackground),
                ),
        ),
        const SizedBox(
          height: 16,
        ),
        TextButton.icon(
            onPressed: getCurrentLocation,
            icon: const Icon(Icons.location_on),
            label: const Text('Get current Location')),
      ],
    );
  }
}
