import 'package:flutter/material.dart';

class Grocery extends StatefulWidget {
  final String productUrl;
  final String productName;
  final String price;

  const Grocery(
      {Key? key,
      required this.productUrl,
      required this.productName,
      required this.price})
      : super(key: key);

  @override
  State<Grocery> createState() => _GroceryState();
}

class _GroceryState extends State<Grocery> {
  @override
  Widget build(BuildContext context) {
    return GridTile(
      header: Center(
        child: Text(
          widget.productName,
          style: Theme.of(context).textTheme.headline4,
        ),
      ),
      footer: Padding(
        padding: const EdgeInsets.all(18.0),
        child: ElevatedButton.icon(
          onPressed: () {},
          icon: const Icon(Icons.add_shopping_cart_rounded),
          label: const Text("Add to Cart"),
        ),
      ),
      child: Card(
        elevation: 2,
        child: SizedBox(
          width: 20,
          height: 60,
          child: Padding(
            padding: const EdgeInsets.all(28.0),
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
}
