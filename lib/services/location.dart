import 'package:gps/gps.dart';

class LocationService {
  GpsLatlng coordinates;

  void initGps() async {
    var gps = await Gps.currentGps();
    this.coordinates = gps;
  }
}
