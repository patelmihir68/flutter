import 'dart:async';
import 'dart:ffi';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
// This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(

          primarySwatch: Colors.blue,
        ),
        home: CounterApp()
    );
  }
}

class CounterApp extends StatefulWidget {
  const CounterApp({Key? key}) : super(key: key);

  @override
  _CounterAppState createState() => _CounterAppState();
}

class _CounterAppState extends State<CounterApp> {

// create instance of streamcontroller class
  StreamController _controller = StreamController();
  int _counter = 0;
  List<Int> logItems = [];

  void StartTimer() async{
    // Timer Method that runs every second
    Timer.periodic(Duration(seconds: 1), (timer) {
      _counter++;

      // add event/data to stream controller using sink
      _controller.sink.add(_counter);

      // will stop Count Down Timer when _counter value is 0
      if(_counter>=36000){
        timer.cancel();
        _controller.close();
      }
    });
  }

  @override
  void dispose() {
    super.dispose();

    // Destroy the Stream Controller when use exit the app
    _controller.close();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            StreamBuilder(
                initialData: _counter,
                stream: _controller.stream,
                builder: (context,snapshot){
                  return Text('${snapshot.data}');
                }
            ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(onPressed: (){

              // start the timer
              StartTimer();
            }, child: const Text('Start Count Down'))
          ],
        ),
      ),
    );
  }



}

class ListDisplay extends StatefulWidget {
  @override
  State createState() => new DyanmicList();
}

class DyanmicList extends State<ListDisplay> {
  List<String> litems = [];
  final TextEditingController eCtrl = new TextEditingController();
  @override
  Widget build (BuildContext ctxt) {
    return new Scaffold(
        appBar: new AppBar(title: new Text("Dynamic Demo"),),
        body: new Column(
          children: <Widget>[
            new TextField(
              controller: eCtrl,
              onSubmitted: (text) {
                litems.add(text);
                eCtrl.clear();
                setState(() {});
              },
            ),
            new Expanded(
                child: new ListView.builder
                  (
                    itemCount: litems.length,
                    itemBuilder: (BuildContext ctxt, int Index) {
                      return new Text(litems[Index]);
                    }
                )
            )
          ],
        )
    );
  }
}

/*class ListViewBuilder extends StatelessWidget {
  const ListViewBuilder({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
          itemCount: 5,
          itemBuilder: (BuildContext context,int index){
            return ListTile(
                leading: const Icon(Icons.alarm),
                title:Text("log $index")
            );
          }
      ),
    );
  }
}*/
