import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_assessment/models/cart.dart';
import 'package:provider/provider.dart';
import '../models/product/product.dart';

class ProductDetailScreen extends StatelessWidget {
  final Product product;

  const ProductDetailScreen({required this.product, super.key});

  @override
  Widget build(BuildContext context) {
    final listnableCart = Provider.of<Cart>(context);
    return Scaffold(
      appBar: AppBar(
          title: Text(product.title!),
          centerTitle: true,
          automaticallyImplyLeading: true,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                ),
                padding: const EdgeInsets.all(20),
                height: MediaQuery.sizeOf(context).height * .6,
                child: CachedNetworkImage(
                  imageUrl: product.image!,
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                  placeholder: (context, url) => Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircularProgressIndicator(
                          color: Colors.orange[900],
                        ),
                        const SizedBox(height: 24),
                        const Text(
                          "Getting item image",
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Text(
                '\$${product.price}',
                style: const TextStyle(
                  color: Colors.grey,
                  fontSize: 20,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                product.description!,
                textAlign: TextAlign.justify,
                softWrap: true,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'price \$${product.price}',
                    style: const TextStyle(
                      color: Colors.grey,
                      fontSize: 20,
                    ),
                  ),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        minimumSize: Size(200, 60),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        foregroundColor: Colors.white,
                        backgroundColor: Color(0xff704f38),
                      ),
                      onPressed: () {
                        listnableCart.addItem(product: product);
                        ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                backgroundColor: Color.fromARGB(255, 255, 229, 214),
                                content: Text(
                                  "Item added",
                                  style: TextStyle(
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            );
                      },
                      child: const Text("Add to Cart")),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
