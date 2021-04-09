import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:parkowa_nie/modules/core/model/Location.dart';

class LocationService {
  Future<LocationPermission> _checkPermission() async {
    final serviceEnabled = await Geolocator.isLocationServiceEnabled();
    var permission = await Geolocator.checkPermission();
    if (serviceEnabled == false || permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }
    return permission;
  }

  Future<FullLocation> locate() async {
    final permission = await _checkPermission();
    if (permission == LocationPermission.always ||
        permission == LocationPermission.whileInUse) {
      final position = await Geolocator.getCurrentPosition();
      List<Placemark> placemarks;
      try {
        placemarks = await GeocodingPlatform.instance
            .placemarkFromCoordinates(position.latitude, position.longitude);
      } catch (e) {}

      return FullLocation(placemarks: placemarks, position: position);
    } else {
      return null;
    }
  }
}
