import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

class FullLocation {
  final Position position;
  final List<Placemark> placemarks;

  FullLocation({this.position, this.placemarks});
}
