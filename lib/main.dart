import 'package:flutter/material.dart';
import 'package:mapbox_mapas/src/theme/theme.dart';
import 'package:mapbox_mapas/src/views/fullscreenmap.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Mapas',
      home: const FulllSreenMap(),
      theme: myTheme,
    );
  }
}
