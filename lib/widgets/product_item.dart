import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_assessment/models/cart.dart';
import 'package:provider/provider.dart';
import '../models/product/product.dart';
import '../screens/product_detail.dart';

class ProductItem extends StatelessWidget {
  final Product product;

  const ProductItem({super.key, required this.product});
  
  @override
  Widget build(BuildContext context) {
    final listnableCart = Provider.of<Cart>(context);
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (ctx) => ProductDetailScreen(product: product),
          ),
        );
      },
      child: Container(
        margin: EdgeInsets.all(5),
        height: 350,
        width: MediaQuery.sizeOf(context).width * 0.45,
        child: Column(
          children: [
            Container(
              height: 200,
              width: MediaQuery.sizeOf(context).width * 0.45,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                
              ),
              child: SizedBox(
                width: double.infinity,

                child: CachedNetworkImage(
                  fit: BoxFit.fill,
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
            ),

            const SizedBox(height: 10),
            Container(
              alignment: Alignment.centerLeft,
              child: Text(
                product.title != null? product.title!.substring(0, min(product.title!.length, 40)) : "No title",
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Spacer(),
            ElevatedButton(

              style: ElevatedButton.styleFrom(
                        minimumSize: Size(180, 50),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        foregroundColor: Colors.white,
                        backgroundColor: Color(0xff704f38),
                      ),
              onPressed: (){
                listnableCart.addItem(product: product);
              }, child: const Text("Add to Cart")),
          ],
        ),
      ),
    );
  }
}
