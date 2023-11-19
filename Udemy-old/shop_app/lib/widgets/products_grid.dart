import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/product.dart';
import '../providers/products.dart';
import 'product_item.dart';

class ProductsGrid extends StatelessWidget {
  const ProductsGrid(
    this.showFavs,
    this.refreshFavorites, {
    Key? key,
  }) : super(key: key);

  final bool showFavs;

  final VoidCallback refreshFavorites;

  @override
  Widget build(BuildContext context) {
    final productsData = Provider.of<Products>(context);
    final products = showFavs ? productsData.favoriteItems : productsData.items;

    return GridView.builder(
      padding: const EdgeInsets.all(10),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 3 / 2,
        mainAxisSpacing: 10,
        crossAxisSpacing: 10,
      ),
      itemBuilder: (context, index) {
        return ChangeNotifierProvider.value(
          value: products[index],
          // create: (context) => products[index],
          child: ProductItem(
            refreshFavorites,
            // id: products[index].id,
            // title: products[index].title,
            // imageUrl: products[index].imageUrl,
          ),
        );
      },
      itemCount: products.length,
    );
  }
}
