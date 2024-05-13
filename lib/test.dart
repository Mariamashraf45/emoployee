import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// Define a model for the item
class Item {
  final String name;
  bool isFavorite;

  Item(this.name, {this.isFavorite = false});
}

// Define a class to hold the favorite items

class FavoriteItems extends ChangeNotifier {
  List<Item> _items = [];

  List<Item> get items => _items;

  void addItem(Item item) {
    _items.add(item);
    notifyListeners();
  }

  void removeItem(Item item) {
    _items.remove(item);
    notifyListeners();
  }

  bool isFavorite(Item item) {
    return _items.contains(item);
  }
}

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => FavoriteItems(),
      child: MaterialApp(
        title: 'Favorite Items',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        initialRoute: '/',
        routes: {
          '/': (context) => HomePage(),
          '/favorites': (context) => FavoriteScreen(),
        },
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Favorite Items'),
        actions: [
          IconButton(
            icon: Icon(Icons.favorite),
            onPressed: () {
              Navigator.pushNamed(context, '/favorites');
            },
          ),
        ],
      ),
      body: ItemList(),
    );
  }
}

class ItemList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: itemList.length,
      itemBuilder: (context, index) {
        final item = itemList[index];
        return ListTile(
          title: Text(item.name),
          trailing: FavoriteButton(item: item),
        );
      },
    );
  }
}

class FavoriteButton extends StatelessWidget {
  final Item item;

  const FavoriteButton({required this.item});

  @override
  Widget build(BuildContext context) {
    final favoriteItems = Provider.of<FavoriteItems>(context);
    final isFavorite = favoriteItems.isFavorite(item);
    return IconButton(
      icon: Icon(
        isFavorite ? Icons.favorite : Icons.favorite_border,
        color: isFavorite ? Colors.red : null,
      ),
      onPressed: () {
        if (isFavorite) {
          favoriteItems.removeItem(item);
        } else {
          favoriteItems.addItem(item);
        }
      },
    );
  }
}

final itemList = [
  Item('Item 1'),
  Item('Item 2'),
  Item('Item 3'),
  Item('Item 4'),
  Item('Item 5'),
];

class FavoriteScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final favoriteItems = Provider.of<FavoriteItems>(context);
    final favoriteList = favoriteItems.items;
    return Scaffold(
      appBar: AppBar(
        title: Text('Favorite Items'),
      ),
      body: ListView.builder(
        itemCount: favoriteList.length,
        itemBuilder: (context, index) {
          final item = favoriteList[index];
          return ListTile(
            title: Text(item.name),
            trailing: IconButton(
              icon: Icon(Icons.favorite, color: Colors.red),
              onPressed: () {
                favoriteItems.removeItem(item);
              },
            ),
          );
        },
      ),
    );
  }}
