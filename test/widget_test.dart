import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:livres_entregas_mobile/minhas/maps.dart';

//88% maps.dart Coverage
Future<void> main() async {
  testWidgets('MapsTest', (WidgetTester tester) async {
    String routes = getRoutes();

    await tester.pumpWidget(
        MaterialApp(
          onGenerateRoute: (settings) {
            return MaterialPageRoute(
              settings: RouteSettings(arguments: routes,),
              builder: (context) {
                return Maps();
              },
            );
          },
        )
    );
    final mapsFinder = find.byType(GoogleMap);
    expect(mapsFinder, findsOneWidget);
  });
}

String getRoutes() {
  var routes = '{"routes": [{"legs": [{"startLocation": {"lat": 41.86947,"lng": -87.64902},"startLocation": {"lat": 41.81883,'
      + '"lng": -87.68507},"startLocation": {"lat": 41.85080,"lng": -87.70876}}],"overviewPolyline": {"encodedPath": "esp~Fj}}uOn{Hh`FyfE`sC"}}]}';
  return routes.toString();
}