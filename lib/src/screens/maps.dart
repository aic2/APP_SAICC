import 'package:flutter/material.dart';
import '../definitions/colors.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong/latlong.dart';

class Maps extends StatefulWidget {
  @override
  createState() => _MapsState();
}

class _MapsState extends State<Maps> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Maps'),
        backgroundColor: ColorsDefinitions().obterAppBarColor(),
      ),
      body: new FlutterMap(
        options: new MapOptions(
          center: new LatLng(-32.072703, -52.168770),
          minZoom: 10.0),
        layers: [
          new TileLayerOptions(
              urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
              subdomains: ['a', 'b', 'c']),
          new MarkerLayerOptions(
            markers: [
              new Marker(
                width: 45.0,
                height: 45.0,
                point: new LatLng(-32.072703, -52.168770),
                builder: (context) => new Container(
                  child: IconButton(
                    icon: Icon(Icons.location_on),
                    color: Colors.red,
                    iconSize: 40.0,
                    onPressed: (){},
                  ),
                )
              )
            ]
          )
        ],
      ),
    );
  }
}
