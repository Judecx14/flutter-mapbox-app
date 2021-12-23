import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mapbox_gl/mapbox_gl.dart';
import 'package:http/http.dart' as http;

class FulllSreenMap extends StatefulWidget {
  const FulllSreenMap({Key? key}) : super(key: key);

  @override
  State<FulllSreenMap> createState() => _FulllSreenMapState();
}

class _FulllSreenMapState extends State<FulllSreenMap> {
  MapboxMapController? mapController;
  final LatLng initialLocation = const LatLng(25.7580375, -102.9861554);
  String mapStyle = "mapbox://styles/judecx14/ckxij99jp1fm114ntmj6aqqus";
  final streetsStyle = "mapbox://styles/judecx14/ckxij99jp1fm114ntmj6aqqus";
  final sateliteStyle = "mapbox://styles/judecx14/ckxijsndj1s3514sdfm89s8nt";

  void _onMapCreated(MapboxMapController controller) {
    mapController = controller;
    _onStyleLoaded();
  }

  void _onStyleLoaded() {
    addImageFromAsset("assetImage", "assets/custom-icon.png");
    addImageFromUrl("networkImage", Uri.https("via.placeholder.com", "/50"));
  }

  /// Adds an asset image to the currently displayed style
  Future<void> addImageFromAsset(String name, String assetName) async {
    final ByteData bytes = await rootBundle.load(assetName);
    final Uint8List list = bytes.buffer.asUint8List();
    return mapController!.addImage(name, list);
  }

  /// Adds a network image to the currently displayed style
  Future<void> addImageFromUrl(String name, Uri uri) async {
    var response = await http.get(uri);
    return mapController!.addImage(name, response.bodyBytes);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _crearMapa(),
      floatingActionButton: _botonesFlotantes(),
    );
  }

  Column _botonesFlotantes() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        FloatingActionButton(
          child: const Icon(Icons.location_on),
          onPressed: () {
            mapController!.addSymbol(
              SymbolOptions(
                geometry: initialLocation,
                textField: "PLAZA SAN PEDRO!!!",
                textColor: "#FE3A3A",
                iconImage: "networkImage",
                textOffset: const Offset(0.0, 2),
                iconSize: 3,
              ),
            );
            setState(() {});
          },
        ),
        const SizedBox(
          height: 15.0,
        ),
        FloatingActionButton(
          child: const Icon(Icons.arrow_drop_up),
          onPressed: () {
            mapController!.animateCamera(
              CameraUpdate.tiltTo(60),
            );
            setState(() {});
          },
        ),
        const SizedBox(
          height: 15.0,
        ),
        FloatingActionButton(
          child: const Icon(Icons.arrow_drop_down),
          onPressed: () {
            mapController!.animateCamera(
              CameraUpdate.tiltTo(0),
            );
            setState(() {});
          },
        ),
        const SizedBox(
          height: 15.0,
        ),
        FloatingActionButton(
          child: const Icon(Icons.zoom_out),
          onPressed: () {
            mapController!.animateCamera(
              CameraUpdate.zoomOut(),
            );
            setState(() {});
          },
        ),
        const SizedBox(
          height: 15.0,
        ),
        FloatingActionButton(
          child: const Icon(Icons.zoom_in),
          onPressed: () {
            mapController!.animateCamera(
              CameraUpdate.zoomIn(),
            );
            setState(() {});
          },
        ),
        const SizedBox(
          height: 15.0,
        ),
        FloatingActionButton(
          child: const Icon(Icons.layers),
          onPressed: () {
            if (mapStyle == streetsStyle) {
              mapStyle = sateliteStyle;
            } else {
              mapStyle = streetsStyle;
            }
            _onStyleLoaded();
            setState(() {});
          },
        ),
      ],
    );
  }

  MapboxMap _crearMapa() {
    return MapboxMap(
      styleString: mapStyle,
      initialCameraPosition: CameraPosition(
        target: initialLocation,
        zoom: 15,
      ),
      onMapCreated: _onMapCreated,
    );
  }
}
