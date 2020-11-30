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

  switchIcons(String eventType) {
    switch (eventType) {
      case 'Bible Study':
        return readingIcon;
        break;
      case 'Mission':
        return missionIcon;
      case 'Volunteer':
        return volunteerIcon;
        break;
      case 'Worship':
        return worshipIcon;
        break;
    }
  }

  void _setMarkerIcon() async {
    BitmapDescriptor.fromAssetImage(
            ImageConfiguration(size: Size(36, 36)), 'assets/pin-red.png')
        .then((onValue) {
      missionIcon = onValue;
    });
    BitmapDescriptor.fromAssetImage(
            ImageConfiguration(size: Size(36, 36)), 'assets/pin-green.png')
        .then((onValue) {
      readingIcon = onValue;
    });
    BitmapDescriptor.fromAssetImage(
            ImageConfiguration(size: Size(36, 36)), 'assets/pin-orange.png')
        .then((onValue) {
      volunteerIcon = onValue;
    });
    BitmapDescriptor.fromAssetImage(
            ImageConfiguration(size: Size(36, 36)), 'assets/pin-blue.png')
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
            title: event.title,
            snippet:
                '${event.description}\nOn ${event.dateTime.month}/${event.dateTime.day}/${event.dateTime.year} at ${event.dateTime.hour}:${event.dateTime.minute}'),
        icon: switchIcons(event.typeOfEvent),
        onTap: () {
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
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AddEventPage(point: point),
      ),
    );
  }

  Widget build(BuildContext context) {
    var events = Provider.of<List<Event>>(context) ?? [];
    final now = new DateTime.now();
    events = events.where((i) => i.dateTime.toUtc().isAfter(now)).toList();
    _makeMarkers(events);

    return Scaffold(
        appBar: AppBar(
          title: Text("Events"),
          backgroundColor: Colors.red,
          leading: IconButton(
            icon: Icon(Icons.refresh, size: 26.0),
            onPressed: () {
              // reload google maps
            },
          ),
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
