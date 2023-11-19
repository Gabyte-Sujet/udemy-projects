import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/products.dart';

class ProductDetailScreen extends StatelessWidget {
  const ProductDetailScreen({
    Key? key,
  }) : super(key: key);

  static const routeName = '/detail-screen';

  @override
  Widget build(BuildContext context) {
    final productId = ModalRoute.of(context)?.settings.arguments != null
        ? ModalRoute.of(context)?.settings.arguments as String
        : 'Null';

    // final loadedProduct = Provider.of<Products>(context)
    //     .items
    //     .firstWhere((item) => item.id == productId);

    // final loadedProduct =
    //     Provider.of<Products>(context, listen: false).findById(productId);

    // final loadedProduct = context.select(
    //   (Products value) => value.findById(productId),
    // );

    final loadedProduct = context.read<Products>().findById(productId);

    return Scaffold(
      appBar: AppBar(
        title: Text(loadedProduct.title),
      ),
      body: Column(
        children: [
          Container(
            height: 300,
            width: double.infinity,
            child: Image.network(
              loadedProduct.imageUrl,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(height: 20),
          Text(loadedProduct.description),
          const SizedBox(height: 10),
          Text('Price: \$${loadedProduct.price}'),
          const SizedBox(height: 10),
          Text('ID: ${productId}')
        ],
      ),
    );
  }
}
