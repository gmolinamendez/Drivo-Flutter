import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:drivo_sv/main.dart';
import 'package:drivo_sv/screens.dart';

void main() {
  testWidgets('welcome screen presents driver entry', (tester) async {
    await tester.pumpWidget(const DrivoApp());
    expect(find.text('El Airbnb de autos en El Salvador.'), findsOneWidget);
    expect(find.text('Quiero Rentar un Auto (Driver)'), findsOneWidget);
  });

  testWidgets('explore screen presents available vehicles', (tester) async {
    await tester.pumpWidget(const MaterialApp(home: ExploreScreen()));
    expect(find.text('Disponibles ahora'), findsOneWidget);
    expect(find.text('Toyota RAV4 2023 4×4'), findsOneWidget);
  });
}
