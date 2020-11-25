import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:location/location.dart';
import 'package:geoflutterfire/geoflutterfire.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:CrimsonMinistry/screens/events/add.dart';
import 'package:CrimsonMinistry/models/event.dart';
import '../events/detail.dart';
import './style.dart';

class MapView extends StatefulWidget {
  @override
  _MapPageState createState() => _MapPageState();
}

class _MapPageState extends State<MapView> {
  int tapCount = 0;
  GoogleMapController mapController;
  Location location = new Location();
  Geoflutterfire geo = Geoflutterfire();
  Set<Marker> markers = Set<Marker>();
  List<Event> events = List<Event>();
  BitmapDescriptor missionIcon, readingIcon, volunteerIcon, worshipIcon;
  LocationData currentLocation;

  @override
  void initState() {
    super.initState();
    _setMarkerIcon();
    _getLocation();
  }

  void _setMarkerIcon() async {
    BitmapDescriptor.fromAssetImage(
            ImageConfiguration(size: Size(36, 36)), 'assets/mission.png')
        .then((onValue) {
      missionIcon = onValue;
    });
    BitmapDescriptor.fromAssetImage(
            ImageConfiguration(size: Size(36, 36)), 'assets/reading.png')
        .then((onValue) {
      readingIcon = onValue;
    });
    BitmapDescriptor.fromAssetImage(
            ImageConfiguration(size: Size(36, 36)), 'assets/volunteer.png')
        .then((onValue) {
      volunteerIcon = onValue;
    });
    BitmapDescriptor.fromAssetImage(
            ImageConfiguration(size: Size(36, 36)), 'assets/worship.png')
        .then((onValue) {
      worshipIcon = onValue;
    });
  }

  void _onMapCreated(GoogleMapController controller) async {
    mapController = controller;
    controller.setMapStyle(Utils.mapStyles);
    _makeMarkers(events);
  }

  void _makeMarkers(List<Event> events) {
    events.forEach((event) {
      markers.add(Marker(
        markerId: MarkerId(event.id),
        position: LatLng(event.location.latitude, event.location.longitude),
        infoWindow: InfoWindow(
            title: event.title, snippet: event.dateTime.toUtc().toString()),
        icon: (event.typeOfEvent == "Mission")
            ? missionIcon
            : (event.typeOfEvent == "Reading")
                ? readingIcon
                : (event.typeOfEvent == "Volunteer")
                    ? volunteerIcon
                    : worshipIcon,
        onTap: () {
          print('tapCount: $tapCount');
          if (tapCount == 0)
            tapCount += 1;
          else {
            tapCount = 0;
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => DetailPage(event: event),
              ),
            );
          }
        },
      ));
    });
  }

  _getLocation() async {
    try {
      currentLocation = await location.getLocation();
    } on Exception {
      currentLocation = null;
    }
  }

  void _handleTap(LatLng point) {
    print(point.latitude);
    print(point.longitude);
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AddEventPage(point: point),
      ),
    );
  }

  Widget build(BuildContext context) {
    events = Provider.of<List<Event>>(context) ?? [];
    print(events);

    return Scaffold(
        appBar: AppBar(
          title: Text("Events"),
          backgroundColor: Colors.red,
          actions: <Widget>[
            FlatButton(
              textColor: Colors.white,
              onPressed: () async {
                double screenWidth = MediaQuery.of(context).size.width *
                    MediaQuery.of(context).devicePixelRatio;
                double screenHeight = MediaQuery.of(context).size.height *
                    MediaQuery.of(context).devicePixelRatio;
                double middleX = screenWidth / 2;
                double middleY = screenHeight / 2;
                ScreenCoordinate screenCoordinate =
                    ScreenCoordinate(x: middleX.round(), y: middleY.round());
                _handleTap(await mapController.getLatLng(screenCoordinate));
              },
              child: Icon(
                Icons.add,
                size: 26.0,
              ),
              shape: CircleBorder(side: BorderSide(color: Colors.transparent)),
            ),
          ],
        ),
        body: Stack(children: [
          GoogleMap(
            onMapCreated: _onMapCreated,
            initialCameraPosition: CameraPosition(
              target: LatLng(33.209438, -87.541493),
              zoom: 13.0,
            ),
            myLocationEnabled: true,
            myLocationButtonEnabled: true,
            onTap: _handleTap,
            markers: markers,
          ),
        ]));
  }
}
