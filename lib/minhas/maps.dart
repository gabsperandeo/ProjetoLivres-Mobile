import 'dart:async';
import 'dart:convert';

import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter/material.dart';
import 'package:label_marker/label_marker.dart';

class Maps extends StatefulWidget {
  Maps({super.key});

  @override
  State<Maps> createState() => _MapsState();
}

class _MapsState extends State<Maps> {
  Completer<GoogleMapController> _controller = Completer();

  Set<Polyline> _polylines = Set<Polyline>();
  Set<Marker> _markers = Set<Marker>();
  int _polylineIdCounter = 1;
  int _markerIdCounter = 1;
  double _latitudeInicial = 0;
  double _longitudeInicial = 0;

  @override
  Widget build(BuildContext context){
    final arg = ModalRoute.of(context)!.settings.arguments as String;
    Map<String, dynamic> result = jsonDecode(arg);

    //pegando as posições iniciais (sede do livres)
    _latitudeInicial = result['routes'][0]['legs'][0]['startLocation']['lat'];
    _longitudeInicial = result['routes'][0]['legs'][0]['startLocation']['lng'];

    //realizando a chamada aos métodos responsáveis por auxiliar na montagem do mapa
    _setPolyline(PolylinePoints().decodePolyline(result['routes'][0]['overviewPolyline']['encodedPath']));
    _setMarkers(result['routes'][0]['legs']);

    //setando a posição inicial da câmera no maps
    final CameraPosition _kGooglePlex = CameraPosition(
      target: LatLng(_latitudeInicial, _longitudeInicial),
      zoom: 14.4746,
    );

    return Scaffold(
      appBar: AppBar(
        title: Text('Google Maps',
          style: const TextStyle(
            color: Color(0xFF80d9ff),
          ),
        ),
        centerTitle: true,
        backgroundColor: Color(0xFF086790),
      ),
      body: GoogleMap(
        mapType: MapType.normal,
        markers: _markers,
        polylines: _polylines,
        initialCameraPosition: _kGooglePlex,
        onMapCreated: (GoogleMapController controller) {
          setState(() {
            _controller.complete(controller);
          });
        },
      ),
    );
  }

  //método responsável por determinar as rotas traçadas no mapa
  _setPolyline(List<PointLatLng> points) {
    final String polylineIdVal = 'polyline_$_polylineIdCounter';
    _polylineIdCounter++;

    _polylines.add(
      Polyline(
        polylineId: PolylineId(polylineIdVal),
        width: 2,
        points: points
            .map(
              (point) => LatLng(point.latitude, point.longitude),
            )
            .toList(),
      ),
    );
  }

  //método responsável por determinar onde ficarão os marcadores (e sua ordem) para a rota passada
  _setMarkers(List<dynamic> legs) {
    String _livresMarker = 'LIVRES ';
    String _markerInfo;
    legs.forEach((leg){
      double _lat = leg['startLocation']['lat'];
      double _lng = leg['startLocation']['lng'];
      String _markerIdVal;

      if(_lat == _latitudeInicial && _lng == _longitudeInicial) { //se for na sede do Livres
        _markerIdVal = '1';
        _livresMarker += '$_markerIdCounter, ';
        _markerInfo = _livresMarker;
        _markerIdCounter++;
      } else {
        _markerIdVal = '$_markerIdCounter';
        _markerInfo = _markerIdVal;
        _markerIdCounter++;
      }

      _markers.addLabelMarker(LabelMarker(
        label: '$_markerInfo',
        markerId: MarkerId(_markerIdVal),
        position: LatLng(_lat, _lng),
        backgroundColor: Colors.lightBlueAccent,
      ));
    });
  }
}