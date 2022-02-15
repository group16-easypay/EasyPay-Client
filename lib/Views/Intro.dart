import 'package:client/Authenticate.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Intro extends StatefulWidget {
  const Intro({Key? key}) : super(key: key);

  @override
  State<Intro> createState() => _IntroState();
}

class _IntroState extends State<Intro> {
  @override
  Widget build(BuildContext context) {
    // ignore: prefer_const_constructors
    return Scaffold(
      appBar: AppBar(
        // titleSpacing: 100,
        title: const Text("E-Shop"),
        shadowColor: Colors.transparent,
        titleTextStyle: Theme.of(context).textTheme.headline4!.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.w300,
              fontSize: 35,
            ),
      ),
      // ignore: prefer_const_constructors
      body: Center(
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Positioned(
              top: 0,
              child: Transform.rotate(
                origin: const Offset(-39, -120),
                angle: 10,
                child: Container(
                  decoration: const BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(
                        30,
                      ),
                    ),
                  ),
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height / 2,
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(10.0),
              child: SizedBox(
                width: MediaQuery.of(context).size.width / 1.2,
                height: MediaQuery.of(context).size.height / 2,
                child: SvgPicture.asset(
                  "images/intro.svg",
                ),
              ),
            ),

            Positioned(
              top: MediaQuery.of(context).size.height / 5.6,
              left: MediaQuery.of(context).size.width / 18,
              child: ElevatedButton(
                style: ButtonStyle(
                  fixedSize: MaterialStateProperty.all(
                    const Size(120, 50),
                  ),
                  padding: MaterialStateProperty.all(const EdgeInsets.all(10)),
                  textStyle: MaterialStateProperty.all(
                    const TextStyle(
                      fontSize: 18,
                    ),
                  ),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const Authenticate(),
                    ),
                  );
                },
                child: const Text(
                  "Shop Now",
                ),
              ),
            ),
            //  CircleAvatar()
          ],
        ),
      ),
    );
  }
}
