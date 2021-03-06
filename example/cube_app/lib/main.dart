import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_cube/flutter_cube.dart';

import 'package:flutter/services.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    /*** 
    return MaterialApp(
      title: 'Flutter Cube',
      theme: ThemeData.dark(),
      home: MyHomePage(title: 'Démo Cube'),
    );
  ****/
    return MyHomePage(title: 'Démo Cube');
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  Scene _scene;
  Object _cube;
  AnimationController _controller;

  void _onSceneCreated(Scene scene) {
    _scene = scene;
    // scene.camera.position.z = 50;
    scene.camera.position.z = 6; // FIrst value was 10
    _cube = Object(
        // scale: Vector3(2.0, 2.0, 2.0),
        scale: Vector3(4.0, 4.0, 4.0),
        backfaceCulling: false,
        // fileName: 'assets/cube/cube.obj');
        // fileName: 'assets/beer/beer.obj');
        fileName: 'assets/earth/earth.obj');
    // final int samples = 4; // Initial value 100
    final int samples = 0; // Initial value 100
    // To get only one object
    // final double radius = 8;
    final double radius = 2;
    final double offset = 2 / samples;
    final double increment = pi * (3 - sqrt(5));
    for (var i = 0; i < samples; i++) {
      final y = (i * offset - 1) + offset / 2;
      final r = sqrt(1 - pow(y, 2));
      final phi = ((i + 1) % samples) * increment;
      final x = cos(phi) * r;
      final z = sin(phi) * r;
      final Object cube = Object(
        position: Vector3(x, y, z)..scale(radius),
        // fileName: 'assets/beer/beer.obj',
        // fileName: 'assets/cube/cube.obj',
        fileName: 'assets/earth/earth.obj',
      );
      _cube.add(cube);
    }
    scene.world.add(_cube);
  }

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        duration: Duration(milliseconds: 30000), vsync: this)
      ..addListener(() {
        if (_cube != null) {
          _cube.rotation.y = _controller.value * 360;
          _cube.updateTransform();
          _scene.update();
        }
      })
      ..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([]);
    /*** 
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Cube(
          onSceneCreated: _onSceneCreated,
        ),
      ),
    );
  ***/
    return Center(
      child: Cube(
        onSceneCreated: _onSceneCreated,
      ),
    );
  }
}
