import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/screens/product_detail_screen.dart';

import '../providers/auth.dart';
import '../providers/cart.dart';
import '../providers/product.dart';

class ProductItem extends StatelessWidget {
  const ProductItem(
    this.refreshFavorites, {
    Key? key,
    // required this.id,
    // required this.title,
    // required this.imageUrl,
  }) : super(key: key);

  final VoidCallback refreshFavorites;

  // final String id;
  // final String title;
  // final String imageUrl;

  @override
  Widget build(BuildContext context) {
    print('Product rebuilds');
    var product = Provider.of<Product>(context);
    var cart = Provider.of<Cart>(context, listen: false);
    var authData = Provider.of<Auth>(context, listen: false);

    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: GridTile(
        footer: GridTileBar(
          backgroundColor: Colors.black54,
          title: Text(
            product.title,
            textAlign: TextAlign.center,
          ),
          leading: Material(
            type: MaterialType.transparency,
            child: IconButton(
              splashColor: Colors.green,
              onPressed: () async {
                try {
                  await product.toggleFavorite(
                    authData.token.toString(),
                    authData.userId.toString(),
                  );
                } catch (err) {
                  ScaffoldMessenger.of(context)
                      .showSnackBar(SnackBar(content: Text('err')));
                }

                // refreshFavorites();
              },
              icon: Icon(
                product.isFavorite ? Icons.favorite : Icons.favorite_border,
                color: Colors.redAccent,
              ),
            ),
          ),
          trailing: Material(
            type: MaterialType.transparency,
            child: IconButton(
              splashColor: Colors.red,
              onPressed: () {
                cart.addItem(product.id, product.price, product.title);
                ScaffoldMessenger.of(context).hideCurrentSnackBar();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: const Text(
                      'Added item to cart!',
                    ),
                    duration: const Duration(seconds: 3),
                    action: SnackBarAction(
                      label: 'UNDO',
                      onPressed: () {
                        cart.removeSingleItem(product.id);
                      },
                    ),
                  ),
                );
              },
              icon: const Icon(
                Icons.shopping_cart,
                color: Colors.redAccent,
              ),
            ),
          ),
        ),
        child: InkWell(
          onTap: () {
            Navigator.of(context).pushNamed(
              ProductDetailScreen.routeName,
              arguments: product.id,
            );
          },
          child: Image.network(
            product.imageUrl,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
