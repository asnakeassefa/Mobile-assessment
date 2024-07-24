import 'package:flutter/material.dart';
import 'package:flutter_assessment/models/cart.dart';
import 'package:flutter_assessment/screens/cart_screen.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'dart:convert';
import '../models/product/product.dart';
import '../widgets/product_item.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Product> _products = [];

  @override
  void initState() {
    super.initState();
    _fetchProducts();
  }

  Future<void> _fetchProducts() async {
    final response =
        await http.get(Uri.parse('https://fakestoreapi.com/products'));
    final List<dynamic> productData = json.decode(response.body);
    setState(() {
      _products = productData.map((json) => Product.fromMap(json)).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    final listnableCart = Provider.of<Cart>(context);
    return ListenableBuilder(
        listenable: listnableCart,
        builder: (context, child) {
          return Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              backgroundColor: Colors.white,
              title: const Text('Products'),
              centerTitle: true,
              actions: [
                GestureDetector(
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const CartScreen(),
                    ),
                  ),
                  child: CircleAvatar(
                    backgroundColor: Color(0xff704F38),
                    child: Badge(
                      child: const Icon(Icons.shopping_cart, color: Colors.white),
                      label: Text(listnableCart.itemCount.toString()),
                    ),
                  ),
                  
                ),
                const SizedBox(width: 10),
              ],
            ),
            body: SingleChildScrollView(
              child: SizedBox(
                height: MediaQuery.of(context).size.height + 300,
                child: RefreshIndicator(
                  onRefresh: () async {
                    await _fetchProducts();
                  },
                  child: Wrap(
                    spacing: 10,
                    children: _products
                        .map((product) => ProductItem(product: product))
                        .toList(),
                  ),
                ),
              ),
            ),
          );
        });
  }
}
