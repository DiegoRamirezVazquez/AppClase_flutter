import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int valor = 0;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Center(
          child: Text("Contador de clicks: $valor", style: TextStyle(fontSize: 25)),
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: const Color.fromARGB(255, 239, 131, 131),
          child: Icon(Icons.ads_click, color: const Color.fromARGB(255, 19, 19, 19)),
          onPressed: (){
            valor++;
            setState(() {});
            print(valor);
          }
        ),
      )
    ); 
  }
}