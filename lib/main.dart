import 'package:client/Views/Intro.dart';
import 'package:client/firebase_options.dart';
import 'package:client/helpers/TextHelper.dart';
import 'package:client/models/Items.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

Future<void> main() async {
  await Hive.initFlutter();
  //**Registering the database */
  Hive.registerAdapter(ItemsAdapter());

  Hive.openBox(dbStore);

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.android,
  );
  runApp(const Client());
}

class Client extends StatelessWidget {
  const Client({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Client App',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: const Intro(),
    );
  }
}
