import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:geoflutterfire/geoflutterfire.dart';
import 'package:CrimsonMinistry/widgets/drawer.dart';
import 'package:CrimsonMinistry/screens/events/add.dart';

class Map extends StatefulWidget {
  @override
  _MapPageState createState() => _MapPageState();
}

class _MapPageState extends State<Map> {
  GoogleMapController mapController;
  Location location = new Location();
  Geoflutterfire geo = Geoflutterfire();

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Map"),
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
        ),
      ]),
    );
  }
}
