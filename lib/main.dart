import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Convertor from Eur to RON'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String? errorMessage;
  double? amountStringConvertedToDouble;
  double? amountConvertedToRON = 0;
  String amountDoubleDigit = '';
  TextEditingController myController = TextEditingController();

  void convertToRon() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      if (errorMessage == null) {
        amountStringConvertedToDouble = double.parse(myController.text);
        amountConvertedToRON = amountStringConvertedToDouble! * 5;
        amountDoubleDigit = amountConvertedToRON!.toStringAsFixed(2);
      }
    });
  }

  void showProperErrorMessage(String x) {
    setState(() {
      amountStringConvertedToDouble = double.tryParse(x);
      if ((x.length <= 5 && amountStringConvertedToDouble == null) ||
          (x.length > 5 && amountStringConvertedToDouble == null)) {
        errorMessage = 'please enter a valid amount';
      } else if (x.length < 5) {
        errorMessage = 'please enter minimum 5 digits';
      } else {
        errorMessage = null;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Center(
          // Center is a layout widget. It takes a single child and positions it
          // in the middle of the parent.
          child: Column(
            children: <Widget>[
              const Image(image: AssetImage('imagini/money2.jpeg')),
              Padding(
                padding: const EdgeInsets.all(16),
                child: TextFormField(
                    controller: myController,
                    style: const TextStyle(fontSize: 20),
                    decoration: InputDecoration(
                        hintText: 'Please enter the amount',
                        border: const OutlineInputBorder(
                            borderSide: BorderSide(width: 2),
                            borderRadius:
                                BorderRadius.all(Radius.circular(20)),),
                        errorStyle: const TextStyle(),
                        errorText: errorMessage,
                        suffixIcon: IconButton(
                            onPressed: () {
                              myController.clear();
                              setState(() {
                                amountDoubleDigit = '';
                              });
                            },
                            icon: const Icon(Icons.clear),),),
                    keyboardType: TextInputType.number,
                    onChanged: (String orice) {
                      showProperErrorMessage(myController.text);
                    },),
              ),
              ElevatedButton(
                  child: const Text(
                    'Convert to RON',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  onPressed: () {
                    convertToRon();
                  },),
              Padding(
                padding: const EdgeInsets.all(10),
                child: Text(
                  '$amountDoubleDigit RON',
                  style: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
      ),
      //  floatingActionButton: FloatingActionButton(
      //   onPressed: _incrementCounter,
      //   tooltip: 'Increment',
      //    child: const Icon(Icons.add),
      // ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
