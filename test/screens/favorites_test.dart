// ignore_for_file: depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:testing_codelab/models/favorites.dart';
import 'package:testing_codelab/screens/favorites.dart';

const numFavs = 5;

Widget _createFavsScreen() => ChangeNotifierProvider<Favorites>(
    create: (_) {
      var temp = Favorites();

      for (var i = 0; i < numFavs; i++) {
        temp.add(i * 10);
      }

      return temp;
    },
    child: const MaterialApp(
      home: FavoritesPage(),
    ));

void main() {
  group('Favorites Page Widget', () {
    testWidgets('When added to tree then UI displayed', (tester) async {
      await tester.pumpWidget(_createFavsScreen());

      expect(find.byType(FavoritesPage), findsOneWidget);
      expect(find.byType(ListView), findsOneWidget);
      expect(find.byType(ListTile), findsWidgets);
    });

    testWidgets('When clicking item then removed', (tester) async {
      await tester.pumpWidget(_createFavsScreen());

      expect(find.byIcon(Icons.close), findsNWidgets(numFavs));

      final target = find.byIcon(Icons.close).first;

      await tester.tap(target);
      await tester.pumpAndSettle();

      expect(find.text("Removed from favs"), findsOneWidget);
      expect(find.byIcon(Icons.close), findsNWidgets(numFavs - 1));
    });
  });
}
