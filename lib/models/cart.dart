import 'package:flutter/material.dart';
import 'package:flutter_assessment/models/product/product.dart';

class CartItem {
  final String id;
  final String title;
  final int quantity;
  final String image;
  final double price;

  CartItem({
    required this.id,
    required this.title,
    required this.quantity,
    required this.image,
    required this.price,
  });
}

class Cart with ChangeNotifier {
  Map<String, CartItem> _items = {};

  Map<String, CartItem> get items {
    return {..._items};
  }

  int get itemCount {
    return _items.length;
  }

  double get totalAmount {
    double total = 0.0;
    _items.forEach((key, cartItem) {
      total += cartItem.price * cartItem.quantity;
    });
    return total;
  }

  void addItem({required Product product}) {
    if (_items.containsKey(product.id.toString())) {
      _items.update(
        product.id.toString(),
        (existingCartItem) => CartItem(
          id: existingCartItem.id,
          title: existingCartItem.title,
          image: existingCartItem.image,
          quantity: existingCartItem.quantity + 1,
          price: existingCartItem.price,
        ),
      );
    } else {
      _items.putIfAbsent(
        product.id.toString(),
        () => CartItem(
          id: DateTime.now().toString(),
          title: product.title!,
          quantity: 1,
          image:  product.image??"",
          price: product.price!,
        ),
      );
    }
    notifyListeners();
  }

  void removeItem(String productId) {
    _items.remove(productId);
    notifyListeners();
  }

  void clear() {
    _items = {};
    notifyListeners();
  }
}
