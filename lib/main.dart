import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:testing_codelab/models/favorites.dart';
import 'package:testing_codelab/screens/favorites.dart';
import 'package:testing_codelab/screens/home.dart';

/// https://codelabs.developers.google.com/codelabs/flutter-app-testing#0

void main() {
  runApp(const TestingApp());
}

class TestingApp extends StatelessWidget {
  const TestingApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<Favorites>(
      create: (_) => Favorites(),
      child: MaterialApp.router(
        title: 'Testing sample',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          useMaterial3: true,
        ),
        routerConfig: GoRouter(
          routes: [
            GoRoute(
              path: HomePage.routeName,
              builder: (cntxt, state) => const HomePage(),
              routes: [
                GoRoute(
                  path: FavoritesPage.routeName,
                  builder: (cntxt, state) => const FavoritesPage(),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
