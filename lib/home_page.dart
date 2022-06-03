import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:steam_example/stream_class.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // StreamController streamController = StreamController();
  //
  // getStreamData() async {
  //   print("here");
  //   while (!streamController.isClosed) {
  //     await Future.delayed(const Duration(seconds: 2));
  //     double random = Random().nextDouble();
  //     print("$random");
  //     streamController.sink.add(random);
  //   }
  // }

  StreamClassData streamClassData = StreamClassData();
  List dataList = [];

  @override
  void initState() {
    // StreamClassData().getStreamData();
    //
    // streamController.stream.listen((event) {
    //   print("event");
    //   setState(() {
    //     dataList.add(event);
    //   });
    // });
    // streamClassData.getStreamData();
    streamClassData.stream.listen((event) {
      setState(() {
        dataList.add(event);
      });
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          TextButton(
            onPressed: () {
              streamClassData.getStreamData();
            },
            child: const Text("Stream"),
          ),
          TextButton(
            onPressed: () {
              streamClassData.dispose();
              // streamController.close();
            },
            child: const Text("Dispose"),
          )
        ],
      ),
      appBar: AppBar(
        title: const Text("Stream Example"),
      ),
      body:
          // dataList.length != 0
          //     ? ListView.builder(
          //         itemCount: dataList.length,
          //         itemBuilder: (context, index) {
          //           var data = dataList[index];
          //           return Text("$data");
          //         })
          //     : const CircularProgressIndicator()
          StreamBuilder(
        stream: streamClassData.stream,
        builder: (context, snapshot) {
          return Text(snapshot.data.toString());
          // print("snapshot");
          // if (snapshot.hasData) {
          //   return Text("${snapshot.data}");
          // } else {
          //   return const CircularProgressIndicator();
        },
      ),
    );
  }
}
