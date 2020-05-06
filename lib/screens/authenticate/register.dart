import 'package:flutter/material.dart';
import 'package:critterpedia/services/authenticate.dart';
import 'package:critterpedia/shared/loading.dart';

///[Register] is a screen for users to register and join the service
class Register extends StatefulWidget {
  ///[toggleView] will swap the view between Register and SignIn
  final Function toggleView;

  Register({this.toggleView});

  @override
  _RegisterState createState() => _RegisterState();
}
///[_RegisterState] is the state for [Register]
class _RegisterState extends State<Register> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();

  String _email = '';
  String _password = '';
  String _passRepeat = '';
  String error = '';
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return loading ? Loading() : Scaffold(
        appBar: AppBar(
            title: Text('Register to Critterpedia'),
          actions: <Widget>[
            FlatButton.icon(
                icon: Icon(Icons.person),
                label: Text('Sign In'),
              onPressed: () => widget.toggleView(),
            )
          ],
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
                      TextFormField(
                        obscureText: true,
                        onChanged: (val){
                          _passRepeat = val;
                        },
                        validator: (val){
                          if(_passRepeat != _password){
                            return 'Passwords must match';
                          }
                          return null;
                        },
                        decoration: InputDecoration(labelText: 'Re-Enter Password'),
                      ),
                      RaisedButton(
                        child: Text('Sign Up'),
                        onPressed: () async {
                          if(_formKey.currentState.validate()){
                            setState(() => loading = true);
                            var result = await _auth.registerWithEmailAndPassword(_email, _password);
                            if(result == null){
                              setState((){
                                loading = false;
                                error = 'Please enter a valid email address';});
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
