import 'dart:convert';

import 'package:client/helpers/TextHelper.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class CartItem extends StatefulWidget {
  final String productUrl;
  final String productName;
  final String price;
  final int id;

  const CartItem(
      {Key? key,
      required this.productUrl,
      required this.productName,
      required this.price,
      required this.id})
      : super(key: key);

  @override
  State<CartItem> createState() => _CartItemState();
}

class _CartItemState extends State<CartItem> {
  @override
  Widget build(BuildContext context) {
    return GridTile(
      header: Center(
        child: Text(
          widget.productName,
          style: Theme.of(context).textTheme.headline6!.copyWith(
                fontSize: 19,
              ),
        ),
      ),
      footer: Row(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              widget.price,
              style: Theme.of(context).textTheme.headline6!.copyWith(
                    fontSize: 16,
                  ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: CircleAvatar(
              radius: 25,
              child: IconButton(
                color: Colors.white,
                iconSize: 27,
                onPressed: () {
                  var data = {
                    'id': widget.id,
                    'name': widget.productName,
                    'price': widget.price,
                    'url': widget.productUrl,
                    'date': DateTime.now().toString(),
                    'user': FirebaseAuth.instance.currentUser!.email,
                    'vendor': 'Shoprite'
                  };
                  store.add(data);
                  showBarCart(widget.productName);
                },
                icon: const Icon(Icons.add_shopping_cart_rounded),
              ),
            ),
          ),
        ],
      ),
      child: Card(
        elevation: 2,
        child: SizedBox(
          width: 20,
          height: 60,
          child: Padding(
            padding: const EdgeInsets.all(38.0),
            child: Image.asset(
              widget.productUrl,
              width: 60,
              height: 60,
              scale: 0.5,
              fit: BoxFit.contain,
            ),
          ),
        ),
      ),
    );
  }

  void showBarCart(String name) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        behavior: SnackBarBehavior.floating,
        content: Text("Added $name to the shopping cart"),
      ),
    );
  }
}
