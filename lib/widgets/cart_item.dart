import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/cart.dart';

class CartItemWidget extends StatelessWidget {
  final CartItem cartItem;
  final Function removeItem;

  const CartItemWidget(
      {super.key, required this.cartItem, required this.removeItem});

  @override
  Widget build(BuildContext context) {
     final listnableCart = Provider.of<Cart>(context);
    return ListenableBuilder(
      listenable: listnableCart,
      builder: (context,child) {
        return Card(
          margin: const EdgeInsets.symmetric(
            horizontal: 15,
            vertical: 4,
          ),
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: ListTile(
              leading: Container(
                child: Image.network(cartItem.image, fit: BoxFit.fill),
              ),
              title: Text(cartItem.title),
              subtitle: Text('Total: \$${cartItem.price * cartItem.quantity}'),
              trailing: Text('${cartItem.quantity} x'),
            ),
          ),
        );
      }
    );
  }
}
