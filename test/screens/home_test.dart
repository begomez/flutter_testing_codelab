// ignore_for_file: depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:testing_codelab/models/favorites.dart';
import 'package:testing_codelab/screens/home.dart';

Widget _createHomeScreen() => ChangeNotifierProvider<Favorites>(
    create: (_) => Favorites(),
    child: const MaterialApp(
      home: HomePage(),
    ));

void main() {
  group('Home Page Widget', () {
    testWidgets('When added to tree then UI displayed', (tester) async {
      await tester.pumpWidget(_createHomeScreen());

      expect(find.byType(HomePage), findsOneWidget);
      expect(find.byType(ListView), findsOneWidget);
      expect(find.byType(ListTile), findsWidgets);
    });

    testWidgets('When scrolling then contents are shown', (tester) async {
      const double speed = 3000.0;
      const offset = Offset(0, -200);

      await tester.pumpWidget(_createHomeScreen());

      expect(find.text("Item 0"), findsOneWidget);
      expect(find.text("Item 101"), findsNothing);

      // force scroll
      final list = find.byType(ListView);
      await tester.fling(list, offset, speed);
      await tester.pumpAndSettle();

      expect(find.text("Item 0"), findsNothing);
    });

    Future<void> selectItemAndCheck(WidgetTester tester) async {
      // tap 1st item
      final target = find.byKey(const Key("icon_0"));
      await tester.tap(target);

      // wait for snack
      await tester.pumpAndSettle(const Duration(milliseconds: 1000));

      // snack shown
      expect(find.text("Added"), findsOneWidget);
      expect(find.text("Removed"), findsNothing);

      // item updated
      expect(find.byIcon(Icons.favorite), findsOneWidget);
    }

    Future<void> unselectItemAndCheck(WidgetTester tester) async {
      // tap 1st item again
      final target = find.byKey(const Key("icon_0"));
      await tester.tap(target);

      // wait for snack
      await tester.pumpAndSettle(const Duration(milliseconds: 1000));

      // snack shown
      expect(find.text("Added"), findsNothing);
      expect(find.text("Removed"), findsOneWidget);

      // item updated
      expect(find.byIcon(Icons.favorite), findsNothing);
    }

    testWidgets('When selecting item then set as fav', (tester) async {
      await tester.pumpWidget(_createHomeScreen());

      // no initial selection
      expect(find.byIcon(Icons.favorite_border), findsWidgets);
      expect(find.byIcon(Icons.favorite), findsNothing);

      await selectItemAndCheck(tester);
    });

    testWidgets('When unselecting item then unset as fav', (tester) async {
      await tester.pumpWidget(_createHomeScreen());

      // no initial selection
      expect(find.byIcon(Icons.favorite_border), findsWidgets);
      expect(find.byIcon(Icons.favorite), findsNothing);

      await selectItemAndCheck(tester);

      await unselectItemAndCheck(tester);
    });
  });
}
