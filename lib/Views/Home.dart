// ignore_for_file: unnecessary_const, avoid_unnecessary_containers

import 'dart:io';

import 'package:client/Utils/CartItem.dart';
import 'package:client/Views/Cart.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    super.initState();
  }

  FirebaseAuth authorize = FirebaseAuth.instance;
  Future<void> logoutUser() async {
    await authorize.signOut();
  }

// Header
  String header = "Drinks";

// Demo items
  String urls = "images/beverages_images/";
  String category = "images/categories_images/";
  String gurl = "images/grocery_images/";
  String prefix = "Shs ";

  ///* Tag names */
  List<String> items = [
    "apple_and_grape_juice.png",
    "coca_cola.png",
    "diet_coke.png",
    "orange_juice.png",
    "pepsi.png",
    "sprite.png"
  ];

  List<String> tag = [
    "bakery.png",
    "beverages.png",
    "dairy.png",
    "fruit.png",
    "meat.png",
    "oil.png"
  ];

  List<String> names = [
    "App & Grap Juice",
    "Coca-Cola",
    "Diet-Coke",
    "Orange Juice",
    "Pepsi",
    "Sprite"
  ];

  /// *Gross Names */
  List<String> grocery = [
    "Barkery",
    "Beverages",
    "Dairy",
    "Fruit",
    "Meat",
    "Oil"
  ];

  List<String> more = [
    "apple.png",
    "banana.png",
    "beef.png",
    "chicken.png",
    "ginger.png",
    "pepper.png"
  ];

  List<String> gnames = [
    "Apples",
    "Banana",
    "Beef",
    "Chicken",
    "Ginger",
    "Pepper"
  ];

  List<double> gprice = [2900, 2500, 22250, 1000, 4500, 1000];

  List<int> q = [01, 02, 03, 04, 05, 06];

  /// Prices */
  List<double> prices = [5000, 2500, 3500, 3000, 1800, 2000];
  List<double> gross = [3000, 1000, 3300, 2000, 5000, 6000];

  ///*** Product Ids*/
  // ignore: non_constant_identifier_names
  List<int> g_ids = [33, 44, 55, 66, 88, 77];
  // ignore: non_constant_identifier_names
  List<int> d_ids = [12, 13, 14, 15, 16, 17];

  ///***Drawer */
  GlobalKey<ScaffoldState> drawerKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(header),
        leading: Padding(
          padding: const EdgeInsets.all(10.0),
          child: IconButton(
            iconSize: 30,
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const Cart(),
                  fullscreenDialog: true,
                ),
              );
            },
            icon: const Icon(Icons.shopping_cart),
          ),
        ),
      ),
      // ignore: prefer_const_constructors
      body: Center(child: displayItem()),
      endDrawer: Drawer(
        elevation: 20,
        key: drawerKey,
        child: ListView(
          children: [
            UserAccountsDrawerHeader(
              accountName: Text("UserId ${authorize.currentUser?.uid}"),
              accountEmail:
                  Text("Logined in as ${authorize.currentUser!.email}"),
            ),
            ListTile(
              leading: const Icon(
                Icons.category_rounded,
              ),
              title: const Text("Categories"),
              onTap: () {
                Navigator.pop(context);

                showBottomCart();
              },
            ),
            ListTile(
              leading: const Icon(Icons.logout_rounded),
              title: const Text("Logout"),
              onTap: () {
                logoutUser();
                Navigator.pop(context);
              },
            ),
            const Divider(),
            // ignore: prefer_const_constructors
            ListTile(
              leading: const Icon(
                Icons.exit_to_app_rounded,
              ),
              title: const Text("Exit App"),
              onTap: () {
                exit(0);
              },
            )
          ],
        ),
      ),
    );
  }

  void showBottomCart() {
    showModalBottomSheet(
        backgroundColor: Colors.transparent,
        context: context,
        builder: (context) {
          return BottomSheet(
              backgroundColor: Colors.transparent,
              onClosing: () {},
              builder: (context) {
                return Padding(
                  padding: const EdgeInsets.all(0),
                  child: Container(
                    height: 300,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30),
                      ),
                    ),
                    child: GridView.count(
                      crossAxisCount: 2,
                      mainAxisSpacing: 4,
                      crossAxisSpacing: 3,
                      children: [
                        TextButton(
                          onPressed: () {
                            setState(() {
                              setState(() {
                                header = "Drinks";
                              });
                            });
                            Navigator.pop(context);
                          },
                          // ignore: prefer_const_constructors
                          child: Card(
                            elevation: 3,
                            child: Center(
                              child: Text(
                                "Drinks",
                                style: Theme.of(context)
                                    .textTheme
                                    .headline6!
                                    .copyWith(
                                      fontSize: 18,
                                    ),
                              ),
                            ),
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            setState(() {
                              header = "Grocery";
                            });
                            Navigator.pop(context);
                          },
                          // ignore: prefer_const_constructors
                          child: Card(
                            elevation: 3,
                            child: Center(
                              child: Text(
                                "Groceries",
                                style: Theme.of(context)
                                    .textTheme
                                    .headline6!
                                    .copyWith(
                                      fontSize: 18,
                                    ),
                              ),
                            ),
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            setState(() {
                              setState(() {
                                header = "gitems";
                              });
                            });
                            Navigator.pop(context);
                          },
                          // ignore: prefer_const_constructors
                          child: Card(
                            elevation: 3,
                            child: Center(
                              child: Text(
                                "Fresh Cuts",
                                style: Theme.of(context)
                                    .textTheme
                                    .headline6!
                                    .copyWith(
                                      fontSize: 18,
                                    ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              });
        });
  }

  Widget displayItem() {
    if (header == "Drinks") {
      return GridView.count(
        mainAxisSpacing: 10,
        crossAxisCount: 2,
        crossAxisSpacing: 10,
        children: List.generate(
          items.length,
          (index) => CartItem(
            productUrl: urls + items[index],
            productName: names[index],
            price: prefix + prices[index].toString(),
            id: d_ids[index],
          ),
        ),
      );
    } else if (header == "gitems") {
      return GridView.count(
        mainAxisSpacing: 10,
        crossAxisCount: 2,
        crossAxisSpacing: 10,
        children: List.generate(
          tag.length,
          (index) => CartItem(
            productUrl: gurl + more[index],
            productName: gnames[index],
            price: prefix + gprice[index].toString(),
            id: q[index],
          ),
        ),
      );
    } else {
      return GridView.count(
        mainAxisSpacing: 10,
        crossAxisCount: 2,
        crossAxisSpacing: 10,
        children: List.generate(
          tag.length,
          (index) => CartItem(
            productUrl: category + tag[index],
            productName: grocery[index],
            price: prefix + gross[index].toString(),
            id: g_ids[index],
          ),
        ),
      );
    }
  }
}
