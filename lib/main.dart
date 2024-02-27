import 'dart:async';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  StreamController<String> streamController = StreamController<String>();
  late Stream<String> dataStream;
  TextEditingController textEditingController = TextEditingController();

  @override
  void initState() {
  dataStream=streamController.stream.asBroadcastStream();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              StreamBuilder<String>(
                stream: dataStream,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    //Subscriber
                    return Text(
                      snapshot.data ?? "Null Data ",
                      style: const TextStyle(fontSize: 20),
                    );
                  } else {
                    return const Text(
                      "No data",
                      style: TextStyle(fontSize: 20),
                    );
                  }
                },
              ),
              StreamBuilder<String>(
                stream: dataStream,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    //Subscriber
                    return Text(
                      snapshot.data ?? "Null Data",
                      style: const TextStyle(fontSize: 20),
                    );
                  } else {
                    return const Text(
                      "No data",
                      style: TextStyle(fontSize: 20),
                    );
                  }
                },
              ),
              const SizedBox(
                height: 20,
              ),
              //Text
               SizedBox(
                width: 200,
                child: TextField(
                  controller: textEditingController,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              //Done Button
              ElevatedButton(
                onPressed: () {
                  streamController.add(textEditingController.text);
                },
                child: const Text('Done'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
