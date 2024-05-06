import 'package:flutter/material.dart';
import 'package:fancy_border/fancy_border.dart';
import 'package:wx_text/wx_text.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fancy Border Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const WxText.displayLarge(
              'FancyBorder',
              fontWeight: FontWeight.bold,
              outlineColor: Colors.white,
              outlineWidth: 1.5,
              shadows: [
                Shadow(
                  color: Colors.green,
                  blurRadius: 3,
                ),
              ],
              gradient: LinearGradient(
                colors: [
                  Colors.green,
                  Colors.blue,
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
            const SizedBox(height: 45),
            Wrap(
              spacing: 30,
              children: [
                Container(
                  width: 100,
                  height: 50,
                  decoration: const ShapeDecoration(
                    color: Colors.yellow,
                    shape: FancyBorder(
                      shape: RoundedRectangleBorder(),
                      style: FancyBorderStyle.solid,
                      width: 4,
                      offset: 2,
                      gradient:
                          LinearGradient(colors: [Colors.blue, Colors.red]),
                      corners: BorderRadius.all(Radius.circular(10)),
                    ),
                  ),
                  alignment: Alignment.center,
                  child: const Text('Rounded'),
                ),
                Container(
                  width: 100,
                  height: 50,
                  decoration: const ShapeDecoration(
                    color: Colors.yellow,
                    shape: FancyBorder(
                      shape: ContinuousRectangleBorder(),
                      style: FancyBorderStyle.solid,
                      width: 4,
                      offset: 2,
                      gradient:
                          LinearGradient(colors: [Colors.blue, Colors.red]),
                      corners: BorderRadius.all(Radius.circular(40)),
                    ),
                  ),
                  alignment: Alignment.center,
                  child: const Text('Continuous'),
                ),
              ],
            ),
            const SizedBox(height: 30),
            Wrap(
              spacing: 30,
              children: [
                Container(
                  width: 100,
                  height: 50,
                  decoration: const ShapeDecoration(
                    color: Colors.yellow,
                    shape: FancyBorder(
                      shape: BeveledRectangleBorder(),
                      style: FancyBorderStyle.dashed,
                      width: 4,
                      offset: 2,
                      gradient:
                          LinearGradient(colors: [Colors.blue, Colors.red]),
                      corners: BorderRadius.all(Radius.circular(10)),
                    ),
                  ),
                  alignment: Alignment.center,
                  child: const Text('Beveled'),
                ),
                Container(
                  width: 100,
                  height: 50,
                  decoration: const ShapeDecoration(
                    color: Colors.yellow,
                    shape: FancyBorder(
                      shape: StadiumBorder(),
                      style: FancyBorderStyle.dashed,
                      width: 4,
                      offset: 2,
                      gradient:
                          LinearGradient(colors: [Colors.blue, Colors.red]),
                      corners: BorderRadius.all(Radius.circular(10)),
                    ),
                  ),
                  alignment: Alignment.center,
                  child: const Text('Stadium'),
                ),
              ],
            ),
            const SizedBox(height: 30),
            Wrap(
              crossAxisAlignment: WrapCrossAlignment.center,
              spacing: 30,
              children: [
                Container(
                  width: 60,
                  height: 60,
                  decoration: const ShapeDecoration(
                    color: Colors.yellow,
                    shape: FancyBorder(
                      shape: CircleBorder(),
                      style: FancyBorderStyle.dotted,
                      width: 5,
                      offset: 2,
                      gradient:
                          LinearGradient(colors: [Colors.blue, Colors.red]),
                      corners: BorderRadius.all(Radius.circular(10)),
                    ),
                  ),
                  alignment: Alignment.center,
                  child: const Text('Circle'),
                ),
                Container(
                  width: 100,
                  height: 50,
                  decoration: const ShapeDecoration(
                    color: Colors.yellow,
                    shape: FancyBorder(
                      shape: OvalBorder(),
                      style: FancyBorderStyle.dotted,
                      width: 5,
                      offset: 2,
                      gradient:
                          LinearGradient(colors: [Colors.blue, Colors.red]),
                      corners: BorderRadius.all(Radius.circular(10)),
                    ),
                  ),
                  alignment: Alignment.center,
                  child: const Text('Oval'),
                ),
              ],
            ),
            const SizedBox(height: 30),
            Wrap(
              crossAxisAlignment: WrapCrossAlignment.center,
              spacing: 30,
              children: [
                Container(
                  width: 90,
                  height: 90,
                  decoration: const ShapeDecoration(
                    color: Colors.yellow,
                    shape: FancyBorder(
                      shape: StarBorder(innerRadiusRatio: .6),
                      style: FancyBorderStyle.morse,
                      width: 3,
                      offset: 5,
                      gradient:
                          LinearGradient(colors: [Colors.blue, Colors.red]),
                      corners: BorderRadius.all(Radius.circular(10)),
                    ),
                  ),
                  alignment: Alignment.center,
                  child: const Text('Star'),
                ),
                Container(
                  width: 100,
                  height: 60,
                  decoration: const ShapeDecoration(
                    color: Colors.yellow,
                    shape: FancyBorder(
                      shape: RoundedRectangleBorder(),
                      style: FancyBorderStyle.morse,
                      width: 3,
                      offset: 3,
                      gradient:
                          LinearGradient(colors: [Colors.blue, Colors.red]),
                      corners: BorderRadius.only(
                        topLeft: Radius.circular(35),
                        bottomRight: Radius.circular(35),
                      ),
                    ),
                  ),
                  alignment: Alignment.center,
                  child: const Text('Leaf'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
