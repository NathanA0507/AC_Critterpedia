import 'package:flutter/material.dart';
import 'package:critterpedia/Login.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Critterpedia',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: LoginScreen(),
    );
  }
}

class LoginScreen extends StatefulWidget {
  LoginScreen({Key key}) : super(key: key);

  @override
  _LoginScreen createState() => _LoginScreen();
}

///_LoginScreen is the state for LoginScreen, it's used to login to the app
class _LoginScreen extends State {
  Login _loginData = new Login();
  GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  bool _loading = false;

  @override
  Widget build(BuildContext inContext) {
    return Scaffold(
        appBar: AppBar(title: Text("Login")),
        body: _loading
            ? Center(child: CircularProgressIndicator())
            : Container(
            padding: EdgeInsets.all(40.0),
            child: Form(
                key: this._formKey,
                child: Column(children: [
                  TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      validator: (String inValue) {
                        if (inValue.length == 0) {
                          return "Please enter username";
                        }
                        return null;
                      },
                      onSaved: (String inValue) {
                        this._loginData.username = inValue;
                      },
                      decoration: InputDecoration(
                          hintText: "naaun", labelText: "Username")),
                  TextFormField(
                      obscureText: true,
                      validator: (String inValue) {
                        if (inValue.length == 0) {
                          return "Please enter password";
                        }
                        return null;
                      },
                      onSaved: (String inValue) {
                        this._loginData.password = inValue;
                      },
                      decoration: InputDecoration(
                          hintText: "Password", labelText: "Password")),
                  RaisedButton(
                      child: Text("Log In!"),
                      onPressed: () async {
                        if (_formKey.currentState.validate()) {
                          setState(() {
                            _loading = true;
                          });
                          _formKey.currentState.save();

                          if (await _loginData.validate()) {
                            setState(() {
                              _loading = false;
                            });
                            Navigator.push(
                                inContext,
                                MaterialPageRoute(
                                    builder: (context) => MyHomePage(title: 'Flutter Demo Home Page')));
                          } else {
                            setState(() {
                              _loading = false;
                            });
                            return showDialog(
                                context: inContext,
                                barrierDismissible: false,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                      content: Text(
                                          "Username or password incorrect"),
                                      actions: [
                                        FlatButton(
                                            child: Text("Ok"),
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            })
                                      ]);
                                });
                          }
                        }
                      })
                ]))));
  }
}




class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
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
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Invoke "debug painting" (press "p" in the console, choose the
          // "Toggle Debug Paint" action from the Flutter Inspector in Android
          // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
          // to see the wireframe for each widget.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.display1,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
