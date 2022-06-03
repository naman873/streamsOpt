import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:math' as math;
import 'package:http/http.dart' as http;

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
      double random = math.Random().nextDouble();
      print("$random");
      streamSink.add(random);
    }
  }

  Stream<double> getStreamData1() async* {
    while (!streamController.isClosed) {
      await Future.delayed(const Duration(seconds: 2));
      double random = math.Random().nextDouble();
      print(random);
      yield random;
    }
  }

  // To close the stream
  void dispose() {
    streamController.close();
  }

  getWeatherData() async {
    try {
      const apikey = 'f6ecf2f6f958a9aed7631592550608fe';
      const openWeatherMapUrl =
          'http://api.openweathermap.org/data/2.5/weather';
      var urll =
          'http://api.openweathermap.org/data/2.5/weather?q=Delhi&appid=$apikey&units=metric';
      // var url = '$openWeatherMapUrl?q=${"cityName"}"&appid=$apikey&units=metric';
      http.Response response = await http.get(Uri.parse(urll));
      // print(response.body);
      log(response.body);
      var respMap = jsonDecode(response.body);
      streamSink.add([respMap["name"], respMap["main"]["temp"]]);
    } catch (e) {
      print("$e");
    }
  }
}
