import 'package:flutter/material.dart';
import 'dart:async';
import 'package:python_channel/python_channel.dart';

Future<void> main() async {
  await PythonChannel.initialize("python311.dll",
      pythonHome:
          "C:\\Users\\Admin\\AppData\\Local\\Programs\\Python\\Python311");
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late PyModule module;
  String text = "12 + 45";
  @override
  void initState() {
    super.initState();
    module = PyModule.open("main");
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
                onPressed: () {
                  setState(() {
                    text = module
                        .attr("test")
                        .call([12, 45])
                        .cast<int>()
                        .toString();
                  });
                },
                child: const Text("Thực Thi")),
            Text(text),
          ],
        )),
      ),
    );
  }
}
