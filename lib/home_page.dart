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
            },
            child: const Text("Dispose"),
          ),
          TextButton(
            onPressed: () {
              // streamClassData.dispose();
              streamClassData.getWeatherData();
            },
            child: const Text("Get Weather"),
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
        builder: (context, AsyncSnapshot snapshot) {
          // return Center(child: Text(snapshot.data.toString(),),);
          if (snapshot.connectionState == ConnectionState.active) {
            print("snapshot");
            if (snapshot.hasData) {
              // return Text("${snapshot.data}");
              return Center(
                child: Text(
                    "Temperature of ${snapshot.data[0]} is ${snapshot.data[1]}"),
              );
            } else {
              return const Text(
                "No Data :)",
              );
            }
          } else {
            const Center(child: CircularProgressIndicator());
          }
          return Container();
        },
      ),
    );
  }
}
