import 'dart:ffi';

import 'package:flutter/material.dart';
import 'dart:async';
import 'package:python_channel/python_channel.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await PythonChannel.initialize("python311.dll");
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late PyModule module;
  late PyDict dict;
  String text = "12 + 45";
  @override
  void initState() {
    super.initState();
    module = PyModule.open("main");
    dict = PyDict.fromMap({});
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
                  final key = "Hello world".toPyString();
                  dict[key] = "hello";

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
