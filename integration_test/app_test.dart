// ignore_for_file: depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:testing_codelab/main.dart';
import 'package:testing_codelab/screens/favorites.dart';
import 'package:testing_codelab/screens/home.dart';

/// Run:
/// flutter test integration_test/app_test.dart
///

void main() {
  group('TestingApp', () {
    testWidgets('When selecting items on home then appear as fav on favorites',
        (tester) async {
      await tester.pumpWidget(const TestingApp());

      final iconKeys = [
        'icon_0',
        'icon_1',
        'icon_2',
      ];

      // ADDING

      for (int i = 0; i < iconKeys.length; i++) {
        var target = Key(iconKeys[i]);

        expect(find.byKey(target), findsOneWidget);

        await tester.tap(find.byKey(target));
        await tester.pumpAndSettle(const Duration(milliseconds: 1000));

        expect(find.text("Added"), findsOneWidget);
      }

      // NAV TO FAVS

      await tester.tap(find.text("Favorites"));
      await tester.pumpAndSettle();
      expect(find.byType(FavoritesPage), findsOneWidget);

      final removeIconKeys = [
        'remove_icon_0',
        'remove_icon_1',
        'remove_icon_2',
      ];

      // REMOVING

      for (int i = 0; i < removeIconKeys.length; i++) {
        var target = Key(removeIconKeys[i]);

        expect(find.byKey(target), findsOneWidget);

        await tester.tap(find.byKey(target));
        await tester.pumpAndSettle(const Duration(milliseconds: 1000));

        expect(find.text("Removed from favs"), findsOneWidget);
      }

      // BACK TO HOME

      await tester.tap(find.byTooltip('Back'));
      await tester.pumpAndSettle();

      expect(find.byType(HomePage), findsOneWidget);
      expect(find.byIcon(Icons.favorite), findsNothing);
    });
  });
}
