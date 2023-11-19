import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shop_app/models/http_exception.dart';

import 'product.dart';

class Products with ChangeNotifier {
  Products(this.authToken, this.userId, this._items);

  final String? authToken;
  final String? userId;

  List<Product> _items = [
    // Product(
    //   id: 'p1',
    //   title: 'Red Shirt',
    //   description: 'A red shirt - it is pretty red!',
    //   price: 29.99,
    //   imageUrl:
    //       'https://cdn.pixabay.com/photo/2016/10/02/22/17/red-t-shirt-1710578_1280.jpg',
    // ),
    // Product(
    //   id: 'p2',
    //   title: 'Trousers',
    //   description: 'A nice pair of trousers.',
    //   price: 59.99,
    //   imageUrl:
    //       'https://upload.wikimedia.org/wikipedia/commons/thumb/e/e8/Trousers%2C_dress_%28AM_1960.022-8%29.jpg/512px-Trousers%2C_dress_%28AM_1960.022-8%29.jpg',
    // ),
    // Product(
    //   id: 'p3',
    //   title: 'Yellow Scarf',
    //   description: 'Warm and cozy - exactly what you need for the winter.',
    //   price: 19.99,
    //   imageUrl:
    //       'https://live.staticflickr.com/4043/4438260868_cc79b3369d_z.jpg',
    // ),
    // Product(
    //   id: 'p4',
    //   title: 'A Pan',
    //   description: 'Prepare any meal you want.',
    //   price: 49.99,
    //   imageUrl:
    //       'https://upload.wikimedia.org/wikipedia/commons/thumb/1/14/Cast-Iron-Pan.jpg/1024px-Cast-Iron-Pan.jpg',
    // ),
  ];

  //  https://img.freepik.com/premium-photo/opened-book-bible-background_112554-164.jpg?w=360

  List<Product> get items {
    return [..._items];
  }

  Product findById(String id) {
    return items.firstWhere((prod) => prod.id == id);
  }

  List<Product> get favoriteItems {
    return _items.where((product) => product.isFavorite).toList();
  }

  Future<void> fetchAndSetData([bool filterByUser = false]) async {
    final filterString =
        filterByUser ? 'orderBy="creatorId"&equalTo="$userId"' : "";
    var url = Uri.parse(
        'https://fir-shop-app-d4c93-default-rtdb.europe-west1.firebasedatabase.app/products.json?auth=$authToken&$filterString');

    try {
      final response = await http.get(url);
      final resBody = json.decode(response.body) as Map<String, dynamic>;
      final List<Product> loadedProducts = [];

      if (response.statusCode >= 400) return;

      url = Uri.parse(
          'https://fir-shop-app-d4c93-default-rtdb.europe-west1.firebasedatabase.app/userFavorites/$userId.json?auth=$authToken');
      final favoriteResponse = await http.get(url);
      final favoriteData = json.decode(favoriteResponse.body);
      print(favoriteData);

      resBody.forEach((prodId, prodVal) {
        loadedProducts.add(Product(
          id: prodId,
          title: prodVal['title'],
          description: prodVal['description'],
          price: prodVal['price'],
          imageUrl: prodVal['imageUrl'],
          isFavorite:
              favoriteData == null ? false : favoriteData[prodId] ?? false,
        ));
      });
      _items = loadedProducts;
      notifyListeners();
    } catch (error) {
      rethrow;
    }
  }

  Future<void> addProduct(Product product) async {
    final url = Uri.parse(
        'https://fir-shop-app-d4c93-default-rtdb.europe-west1.firebasedatabase.app/products.json?auth=$authToken');

    try {
      final response = await http.post(
        url,
        body: json.encode(
          {
            'title': product.title,
            'description': product.description,
            'imageUrl': product.imageUrl,
            'price': product.price,
            'creatorId': userId,
          },
        ),
      );

      final newProduct = Product(
        id: json.decode(response.body)['name'],
        title: product.title,
        description: product.description,
        price: product.price,
        imageUrl: product.imageUrl,
      );

      _items.add(newProduct);
      // _items.insert(0, newProduct);

      notifyListeners();
    } catch (error) {
      print(error);
      rethrow;
    }
  }

  Future<void> updateProduct(String id, Product product) async {
    var productIndex = items.indexWhere((prod) => prod.id == id);

    if (productIndex >= 0) {
      final url = Uri.parse(
          'https://fir-shop-app-d4c93-default-rtdb.europe-west1.firebasedatabase.app/products/$id.json?auth=$authToken');
      await http.patch(url,
          body: json.encode({
            'description': product.description,
            'imageUrl': product.imageUrl,
            'price': product.price,
            'title': product.title,
          }));
      _items[productIndex] = product;
      notifyListeners();
    } else {
      print('cant find id...');
    }
  }

  Future<void> deleteProduct(String id) async {
    // var productIndex = items.indexWhere((prod) => prod.id == id);
    // _items.removeAt(productIndex);

    // _items.removeWhere((product) => product.id == id);

    final url = Uri.parse(
        'https://fir-shop-app-d4c93-default-rtdb.europe-west1.firebasedatabase.app/products/$id.json?auth=$authToken');

    final existingProductIndex = _items.indexWhere((prod) => prod.id == id);
    dynamic existingProduct = _items[existingProductIndex];

    _items.removeAt(existingProductIndex);
    notifyListeners();

    final response = await http.delete(url);

    if (response.statusCode >= 400) {
      await Future.delayed(Duration(seconds: 2));

      _items.insert(existingProductIndex, existingProduct);
      notifyListeners();
      throw HttpException('error occured');
    }
    existingProduct = null;
  }
}
