import 'dart:async';
import 'dart:convert';
import 'dart:ui' as ui;

import 'package:client/Views/Home.dart';
import 'package:client/helpers/TextHelper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:qr_flutter/qr_flutter.dart';

/// This is the screen that you'll see when the app starts
// ignore: use_key_in_widget_constructors
class QrCodeGene extends StatefulWidget {
  final String paymentDetails;
  final String userDetails;

  const QrCodeGene({
    Key? key,
    required this.userDetails,
    required this.paymentDetails,
  }) : super(key: key);
  @override
  _QrCodeGeneState createState() => _QrCodeGeneState();
}

class _QrCodeGeneState extends State<QrCodeGene> {
  @override
  Widget build(BuildContext context) {
    String encryptedData = jsonEncode(
        {'details': widget.paymentDetails, 'user': widget.userDetails});

    final qrFutureBuilder = FutureBuilder<ui.Image>(
      future: _loadOverlayImage(),
      builder: (ctx, snapshot) {
        const size = 280.0;
        if (!snapshot.hasData) {
          return const SizedBox(width: size, height: size);
        }
        return CustomPaint(
          size: const Size.square(size),
          painter: QrPainter(
            data: encryptedData,
            version: QrVersions.auto,
            eyeStyle: const QrEyeStyle(
              eyeShape: QrEyeShape.square,
              color: Color(0xff128760),
            ),
            dataModuleStyle: const QrDataModuleStyle(
              dataModuleShape: QrDataModuleShape.square,
              color: Color(0xff1a5441),
            ),
            // size: 320.0,
            embeddedImage: snapshot.data,
            embeddedImageStyle: QrEmbeddedImageStyle(
              size: const Size.square(60),
            ),
          ),
        );
      },
    );

    return Scaffold(
      body: Material(
        color: Colors.white,
        child: SafeArea(
          top: true,
          bottom: true,
          // ignore: avoid_unnecessary_containers
          child: Container(
            child: Column(
              children: <Widget>[
                Expanded(
                  child: Center(
                    child: SizedBox(
                      width: 280,
                      child: qrFutureBuilder,
                    ),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 20, horizontal: 10)
                          .copyWith(bottom: 80),
                  child: Padding(
                    padding: const EdgeInsets.all(38.0),
                    child: Text(
                      "Thank you for your evaluation...",
                      style: Theme.of(context)
                          .textTheme
                          .headline6!
                          .copyWith(fontSize: 16),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          store.clear();
          Navigator.push(
            context,
            MaterialPageRoute(
              settings: const RouteSettings(name: "../Views/Home.dart"),
              maintainState: false,
              builder: (context) => const Home(),
              fullscreenDialog: true,
            ),
          );
        },
        label: const Text("Back to home"),
      ),
    );
  }

  Future<ui.Image> _loadOverlayImage() async {
    final completer = Completer<ui.Image>();
    final byteData = await rootBundle.load('images/sm.png');
    ui.decodeImageFromList(byteData.buffer.asUint8List(), completer.complete);
    return completer.future;
  }
}
