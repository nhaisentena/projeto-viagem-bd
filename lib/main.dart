import 'package:flutter/material.dart';
import 'pantallas/Pantalla.dart';

void main() {
  runApp(MyApp());
}


class MyApp extends StatelessWidget {
  @override
  
  Widget build(BuildContext context) {
    return MaterialApp(
      title:  'Calculadora de Costo de Viaje',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: Pantalla(),
    );
  }
}
