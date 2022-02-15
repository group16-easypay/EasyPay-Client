import 'dart:convert';

import 'package:client/models/Items.dart';

void main() {
  const String responseData =
      '[{"id":1,"name":"Product #1"},{"id":2,"name":"Product #2"}]';
  List g = [
    4,
    5,
    6,
    35,
    6,
    7,
    8,
    9,
    0,
    7,
    7,
    8,
    9,
    0,
    0,
    3,
    7,
    8,
    94,
    4,
    6,
    7,
    8,
    9
  ];

  final products = json.encode(responseData);
  // ignore: avoid_print
  // Items(itemName: itemName, price: price, date: date, user: user, vendor: vendor)
  print(json.decode(g.toString()));
}
