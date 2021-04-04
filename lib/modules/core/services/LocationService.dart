import 'package:flutter/cupertino.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:parkowa_nie/modules/core/model/Location.dart';

class LocationService extends ChangeNotifier {
  LocationPermission permission;
  FullLocation fullLocation;

  Future<void> initialize() async {
    final serviceEnabled = await Geolocator.isLocationServiceEnabled();
    permission = await Geolocator.checkPermission();
    if (serviceEnabled == false || permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }
    notifyListeners();
    if (permission == LocationPermission.always ||
        permission == LocationPermission.whileInUse) {
      Geolocator.getPositionStream(desiredAccuracy: LocationAccuracy.best)
          .listen((newPosition) async {
        List<Placemark> placemarks;
        try {
          placemarks = await GeocodingPlatform.instance
              .placemarkFromCoordinates(
                  newPosition.latitude, newPosition.longitude);
        } catch (e) {}

        fullLocation =
            FullLocation(placemarks: placemarks, position: newPosition);
        notifyListeners();
      });
    }
  }

  LocationService() {
    initialize();
  }
}
