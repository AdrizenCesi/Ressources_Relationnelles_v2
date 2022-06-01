import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ressources_relationnelles_v1/main.dart';
import 'package:ressources_relationnelles_v1/pages/auth/authenticateScreen.dart';

void main() {

  testWidgets("Flutter Widget Test",  (WidgetTester tester) async {
  await tester.pumpWidget(MaterialApp(home: AuthenticateScreen(),));
  var button = find.text("Créer un compte");
  expect(button,findsOneWidget);
  print('Reverse Text');
  await tester.tap(button);
  await tester.pump();
  expect(find.text("Déjà un compte ? Connectez-vous !"),findsNothing);
  print('sveD rettulF');
});
}