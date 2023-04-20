import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:testing_codelab/models/favorites.dart';

class FavoritesPage extends StatelessWidget {
  static String routeName = 'favorites_page';

  const FavoritesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Favorites"),
      ),
      body: Consumer<Favorites>(
        builder: (cntxt, value, child) => ListView.builder(
          itemCount: value.items.length,
          padding: const EdgeInsets.symmetric(vertical: 16),
          itemBuilder: (c, index) => FavoriteItemTile(value.items[index]),
        ),
      ),
    );
  }
}

class FavoriteItemTile extends StatelessWidget {
  final int itemNo;

  const FavoriteItemTile(this.itemNo, {super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Colors.primaries[itemNo % Colors.primaries.length],
        ),
        title: Text(
          "Item $itemNo",
          key: Key("favorites_text_$itemNo"),
        ),
        trailing: IconButton(
          key: Key("remove_icon_$itemNo"),
          icon: const Icon(Icons.close),
          onPressed: () {
            removeItem(context);
          },
        ),
      ),
    );
  }

  void removeItem(BuildContext context) {
    Provider.of<Favorites>(context, listen: false).remove(itemNo);

    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Text("Removed from favs"),
      duration: Duration(milliseconds: 1000),
    ));
  }
}
