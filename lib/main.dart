import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:logger/logger.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.red,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: '1ManStartup.com'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String _message = "Click Subscribe";
  Logger logger = Logger();
  TextEditingController _nameController = TextEditingController();
  bool _btnActive = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
          elevation: 0,
        ),
        body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
              gradient: LinearGradient(
            colors: [Colors.red, Colors.yellow],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          )),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Spacer(),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Enter your name',
                    ),
                    controller: _nameController,
                    onChanged: (value) {
                      setState(() {
                        _btnActive = value.length >= 1 ? true : false;
                      });
                    },
                    textInputAction: TextInputAction.done,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(_message),
                ),
                ElevatedButton(
                    child:
                        Text("Subscribe", style: TextStyle(color: Colors.white)),
                    onPressed: _btnActive == true ? _subscribe : null),
                Spacer()
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _subscribe() {
    setState(() {
      _message = "${_nameController.text} Subscribed!";
    });
    HapticFeedback.heavyImpact();
    logger.d("Subscribed");
  }

  Widget repeatText({text, count}) {
    List<Widget> children = [];
    for (int i = 1; i <= count; i++) {
      children.add(Text(text));
    }
    return Column(
      children: children,
    );
  }
}
