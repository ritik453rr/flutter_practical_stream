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
  StreamController<String> streamController = StreamController();
  late Stream<String> dataStream;
  TextEditingController textEditingController = TextEditingController();

  @override
  void initState() {
    dataStream = streamController.stream.asBroadcastStream();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              //Subscriber1
              StreamBuilder<String>(
                stream: dataStream,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Text(
                      snapshot.data!,
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
              //Subscriber2
              StreamBuilder<String>(
                stream: dataStream,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
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
              //Space
              const SizedBox(
                height: 20,
              ),
              //Text
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: textEditingController,
                  decoration: InputDecoration(border: OutlineInputBorder()),
                ),
              ),
              //Space
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
