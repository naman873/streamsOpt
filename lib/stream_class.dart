import 'dart:async';
import 'dart:math';

class StreamClassData {
  //controller

  StreamController streamController = StreamController.broadcast();

  //stream
  Stream get stream => streamController.stream;

  //sinks
  // StreamSink  streamSink (){
  //   return streamController.sink;
  // }
  ////// orr
  StreamSink get streamSink => streamController.sink;

  //Subscription
  StreamSubscription get streamSubscription => stream.listen((event) {});

  getStreamData() async {
    print("here");
    while (!streamController.isClosed) {
      await Future.delayed(const Duration(seconds: 2));
      double random = Random().nextDouble();
      print("$random");
      streamSink.add(random);
    }
  }

  Stream<double> getStreamData1() async* {
    while (!streamController.isClosed) {
      await Future.delayed(const Duration(seconds: 2));
      double random = Random().nextDouble();
      print(random);
      yield random;
    }
  }

  // To close the stream
  void dispose() {
    streamController.close();
  }
}
