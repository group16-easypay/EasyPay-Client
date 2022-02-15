// ignore_for_file: prefer_is_empty

import 'package:client/billing/Billing.dart';
import 'package:client/helpers/TextHelper.dart';
import 'package:flutter/material.dart';

// ignore: camel_case_types
class Cart extends StatefulWidget {
  const Cart({Key? key}) : super(key: key);

  @override
  State<Cart> createState() => _CartState();
}

class _CartState extends State<Cart> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Your shopping cart"),
      ),
      body: Center(
        child: store.length < 1
            ? Center(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 188.0),
                      child: Center(
                        child: Text(
                          "You currently have nothing",
                          style:
                              Theme.of(context).textTheme.headline5!.copyWith(
                                    fontSize: 19,
                                  ),
                        ),
                      ),
                    ),
                    const Center(
                      child: Icon(
                        Icons.hourglass_empty_rounded,
                      ),
                    ),
                  ],
                ),
              )
            : Column(
                children: [
                  Expanded(
                    child: ListView(
                      children: List.generate(
                        store.length,
                        (index) => Card(
                          elevation: 2,
                          child: ListBody(
                            children: [
                              Card(
                                child: Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: SizedBox(
                                    width: 100,
                                    height: 100,
                                    child: Image.asset(store[index]['url']),
                                  ),
                                ),
                                elevation: 0,
                              ),
                              ListTile(
                                title: const Text("Item"),
                                trailing: Text(store[index]['name']),
                              ),
                              ListTile(
                                title: const Text("Price"),
                                trailing: Text(store[index]['price']),
                              ),
                              ListTile(
                                title: const Text("Vendor"),
                                trailing: Text(store[index]['vendor']),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            Navigator.pop(context);
                            store.clear();
                          },
                          child: const Text("Decline"),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const Billing(
                                          title: "Process Payment",
                                        ),
                                    fullscreenDialog: true));
                          },
                          child: const Text("Procced"),
                        ),
                      ],
                    ),
                  )
                ],
              ),
      ),
    );
  }
}
