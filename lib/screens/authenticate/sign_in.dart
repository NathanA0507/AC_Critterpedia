import 'package:flutter/material.dart';
import 'package:critterpedia/services/authenticate.dart';
import 'package:critterpedia/shared/loading.dart';

class SignIn extends StatefulWidget {
  final Function toggleView;
  SignIn({this.toggleView});

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();

  String _email = '';
  String _password = '';
  String error = '';
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return loading ? Loading() : Scaffold(
        appBar: AppBar(
            title: Text('Sign in to Critterpedia'),
            actions: <Widget>[
              FlatButton.icon(
                  icon: Icon(Icons.person),
                  label: Text('Register'),
                onPressed: () => widget.toggleView(),
              )
            ]
        ),
        body: Container(
            padding: EdgeInsets.all(20),
            child: Form(
                key: _formKey,
                child: Column(
                    children: <Widget>[
                      TextFormField(
                        onChanged: (val) {
                          _email = val;
                        },
                        validator: (val) {
                          if (val == null) {
                            return 'Field cannot be blank';
                          }
                          return null;
                        },
                        decoration: InputDecoration(labelText: 'Email'),
                      ),
                      TextFormField(
                          obscureText: true,
                          onChanged: (val){
                            _password = val;
                          },
                          validator: (val) {
                            if (val.length < 6){
                              return 'Password must be at least 6 characters';
                            }
                            return null;
                          },
                          decoration: InputDecoration(labelText: 'Password')
                      ),
                      RaisedButton(
                          child: Text('Sign In'),
                          onPressed: () async {
                            if(_formKey.currentState.validate()){
                              setState(() => loading = true);
                              var result = await _auth.signInWithEmailAndPassword(_email, _password);
                              if(result == null){
                                setState((){
                                  loading = false;
                                  error = 'Invalid Credentials';});
                              }
                            }
                          }
                      ),
                      Text(
                          error,
                          style: TextStyle(color: Colors.red)
                      )
                    ])
            )
        )
    );
  }
}
