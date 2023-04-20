import 'package:test/test.dart';
import 'package:testing_codelab/models/favorites.dart';

void main() {
  late Favorites fav = Favorites();

  group("Favorites", () {
    test('When adding element then added to the list', () {
      fav.add(5);

      assert(fav.items.contains(5));
      assert(fav.items.isNotEmpty);
    });

    test('When removing element then removed from the list', () {
      fav.remove(5);

      assert(!fav.items.contains(5));
      assert(fav.items.isEmpty);
    });
  });
}
