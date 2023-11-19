import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/product.dart';
import '../providers/products.dart';

class EditProductScreen extends StatefulWidget {
  EditProductScreen({Key? key}) : super(key: key);

  static const routeName = '/edit-product-screen';

  @override
  State<EditProductScreen> createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen> {
  final _priceFocusNode = FocusNode();
  final _descriptionFocusNode = FocusNode();
  final _imageUrlFocusNode = FocusNode();
  final _imageUrlController = TextEditingController();
  final _form = GlobalKey<FormState>();

  var editedProduct = Product(
    id: '',
    title: '',
    description: '',
    price: 0,
    imageUrl: '',
  );

  var initValues = {
    'title': '',
    'description': '',
    'price': '',
    'imageUrl': '',
  };

  bool isInit = true;

  bool editingProduct = true;

  bool isLoading = false;

  void _saveForm() async {
    final isValid = _form.currentState!.validate();

    if (!isValid) return;

    _form.currentState?.save();

    setState(() {
      isLoading = true;
    });

    if (editedProduct.id.isNotEmpty) {
      await Provider.of<Products>(context, listen: false)
          .updateProduct(editedProduct.id, editedProduct);
    } else {
      try {
        await Provider.of<Products>(context, listen: false)
            .addProduct(editedProduct);
      } catch (error) {
        await showDialog<Null>(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: Text('error occured'),
                content: Text("something went wrong"),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text('Okay'),
                  )
                ],
              );
            });
      }
      // finally {
      //   setState(() {
      //     isLoading = false;
      //   });

      //   Navigator.of(context).pop();
      // }
    }
    setState(() {
      isLoading = false;
    });
    Navigator.of(context).pop();
  }

  void _updateImageUrl() {
    if (!_imageUrlFocusNode.hasFocus) {
      if (!_imageUrlController.text.startsWith('http') ||
          !_imageUrlController.text.startsWith('https')) return;
      setState(() {});
    } else {
      print('image focus');
    }
  }

  @override
  void initState() {
    super.initState();
    _imageUrlFocusNode.addListener(_updateImageUrl);

    //test:
    _priceFocusNode.addListener(() {
      if (!_priceFocusNode.hasFocus) {
        print('lost focus');
      }
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (isInit) {
      final productId = ModalRoute.of(context)?.settings.arguments;

      if (productId != null) {
        editedProduct = Provider.of<Products>(context, listen: false)
            .findById(productId as String);
        initValues = {
          'title': editedProduct.title,
          'description': editedProduct.description,
          'price': editedProduct.price.toString(),
          // 'imageUrl': editedProduct.imageUrl,
        };
        _imageUrlController.text = editedProduct.imageUrl;
      } else {
        editingProduct = false;
      }
    }

    isInit = false;
  }

  @override
  void dispose() {
    super.dispose();
    _priceFocusNode.dispose();
    _descriptionFocusNode.dispose();
    _imageUrlController.dispose();
    _imageUrlFocusNode.dispose();
    _imageUrlFocusNode.removeListener(_updateImageUrl);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(editingProduct ? 'Edit Product' : 'Add Product'),
        actions: [
          IconButton(onPressed: _saveForm, icon: Icon(Icons.save)),
        ],
      ),
      body: isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _form,
                // autovalidateMode: AutovalidateMode.always,
                child: ListView(
                  children: [
                    TextFormField(
                      initialValue: initValues['title'],
                      decoration: const InputDecoration(labelText: 'Title'),
                      textInputAction: TextInputAction.next,
                      onFieldSubmitted: (value) {
                        FocusScope.of(context).requestFocus(_priceFocusNode);
                      },
                      // initialValue: editedProduct.title,
                      onSaved: (val) {
                        editedProduct = Product(
                          id: editedProduct.id,
                          title: val!,
                          description: editedProduct.description,
                          price: editedProduct.price,
                          imageUrl: editedProduct.imageUrl,
                          isFavorite: editedProduct.isFavorite,
                        );
                      },
                      validator: (val) {
                        if (val == null || val.isEmpty) {
                          return 'Please provide value';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      initialValue: initValues['price'],
                      decoration: const InputDecoration(labelText: 'Price'),
                      textInputAction: TextInputAction.next,
                      keyboardType:
                          const TextInputType.numberWithOptions(signed: true),
                      focusNode: _priceFocusNode,
                      onFieldSubmitted: (_) {
                        FocusScope.of(context)
                            .requestFocus(_descriptionFocusNode);
                      },
                      onSaved: (val) {
                        editedProduct = Product(
                          id: editedProduct.id,
                          title: editedProduct.title,
                          description: editedProduct.description,
                          price: double.tryParse(val!) ?? 0.0,
                          imageUrl: editedProduct.imageUrl,
                          isFavorite: editedProduct.isFavorite,
                        );
                      },
                      validator: (val) {
                        if (val == null || val.isEmpty) {
                          return 'Please provide value';
                        } else if (double.tryParse(val) == null) {
                          return 'Provide correct value';
                        } else if (double.parse(val) <= 0) {
                          return 'Provide Greater than 0';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      initialValue: initValues['description'],
                      decoration:
                          const InputDecoration(labelText: 'Description'),
                      keyboardType: TextInputType.multiline,
                      maxLines: 3,
                      focusNode: _descriptionFocusNode,
                      onSaved: (val) {
                        editedProduct = Product(
                          id: editedProduct.id,
                          title: editedProduct.title,
                          description: val!,
                          price: editedProduct.price,
                          imageUrl: editedProduct.imageUrl,
                          isFavorite: editedProduct.isFavorite,
                        );
                      },
                      validator: (val) {
                        if (val == null || val.isEmpty) {
                          return 'Please provide value';
                        } else if (val.length <= 10) {
                          return 'Provide more than 10';
                        }
                        return null;
                      },
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Container(
                          width: 100,
                          height: 100,
                          margin: EdgeInsets.only(top: 20, right: 10),
                          decoration: BoxDecoration(
                              border: Border.all(width: 1, color: Colors.grey)),
                          child: _imageUrlController.text.isEmpty
                              ? Align(child: Text('Enter URL'))
                              : Image.network(
                                  _imageUrlController.text,
                                  fit: BoxFit.cover,
                                ),
                        ),
                        Expanded(
                          child: TextFormField(
                            // initialValue: initValues['imageUrl'], // initialValues da Controllers ertad ver gamoviyenebt
                            decoration: InputDecoration(labelText: 'Image Url'),
                            keyboardType: TextInputType.url,
                            textInputAction: TextInputAction.done,
                            focusNode: _imageUrlFocusNode,
                            controller: _imageUrlController,
                            onEditingComplete: () {
                              setState(() {});
                            },
                            onFieldSubmitted: (_) {
                              _saveForm();
                            },
                            // onChanged: (val) {
                            //   setState(() {});
                            // },
                            onSaved: (val) {
                              editedProduct = Product(
                                id: editedProduct.id,
                                title: editedProduct.title,
                                description: editedProduct.description,
                                price: editedProduct.price,
                                imageUrl: val!,
                                isFavorite: editedProduct.isFavorite,
                              );
                            },
                            validator: (val) {
                              if (val == null || val.isEmpty) {
                                return 'Please provide value';
                              } else if (!val.startsWith('http') &&
                                  !val.startsWith('https')) {
                                return 'Incorrect URL';
                              }
                              // else if (val.endsWith('.jpg') &&
                              //     val.endsWith('.png')) {
                              //   return 'Incorrect format';
                              // }
                              return null;
                            },
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
    );
  }
}
