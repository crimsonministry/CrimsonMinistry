import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:location/location.dart';
import 'package:geoflutterfire/geoflutterfire.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:CrimsonMinistry/widgets/drawer.dart';
import 'package:CrimsonMinistry/screens/events/add.dart';
import 'package:CrimsonMinistry/models/event.dart';

class MapView extends StatefulWidget {
  @override
  _MapPageState createState() => _MapPageState();
}

class _MapPageState extends State<MapView> {
  GoogleMapController mapController;
  Location location = new Location();
  Geoflutterfire geo = Geoflutterfire();
  Set<Marker> markers = Set<Marker>();
  List<Event> events = List<Event>();

  void _onMapCreated(GoogleMapController controller) async {
    mapController = controller;
    _makeMarkers(events);
  }

  void _makeMarkers(List<Event> events) {
    events.forEach((event) {
      markers.add(Marker(
          markerId: MarkerId(event.id),
          position: LatLng(event.location.latitude, event.location.longitude)));
    });
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
        drawer: DrawerWidget(),
        body: Stack(children: [
          GoogleMap(
            onMapCreated: _onMapCreated,
            initialCameraPosition: CameraPosition(
              target: LatLng(33.209438, -87.541493),
              zoom: 13.0,
            ),
            myLocationEnabled: true,
            onTap: _handleTap,
            markers: markers,
          ),
        ]));
  }
}
