import 'package:flutter/material.dart';
import 'auth.dart';
import 'constants.dart';
class Register extends StatefulWidget {

  final Function toggleView;
  Register({this.toggleView});

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  
  String email;
  String password;
  String error = '';
  bool isLoading = false; 
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
     appBar: AppBar(backgroundColor: Colors.grey, title: Text("Regiseter"), actions: [
       FlatButton(child: Text("Sign In"), onPressed: (){
         widget.toggleView();
       })
     ],),
      body: Center(
        child: Column(children: [
          Form(
            key: _formKey,
            child: Column(
              children: [
                SizedBox(height: 20.0), 
                TextFormField(
                  decoration: textInputDecoration.copyWith(hintText: "Email"),
                  validator: (val) => val.isEmpty ? "Enter an Email" : null,
                  onChanged: (val) {
                    setState(() {
                      email = val;
                    });
                  } 
                ),
                SizedBox(height: 10.0),
                TextFormField(
                  decoration: textInputDecoration.copyWith(hintText: "Password"),
                  validator: (val) => val.length < 6 ? "Enter a Password 6+ characters long" : null,
                  onChanged: (val) {
                    setState(() {
                      password = val;
                    });
                  },
                  obscureText: true,
                ),
                SizedBox(height: 10.0), 
                FlatButton(
                  child: Text("Register"), 
                  color: Colors.red, 
                  onPressed: () async {
                    if (_formKey.currentState.validate()) {
                      setState(() {
                        isLoading = true;
                      });
                       dynamic result = await _auth.registerWithEmailAndPassword(email, password);
                       if (result == null) {
                         setState(() {
                           error = 'Invalid Email Please Try Again';
                           isLoading = false;
                         });
                       }
                    }
                  }
                ),
                SizedBox(height: 15.0), 
                Text(error),
              ],
            ),
          ),
        ]),
      ),
    );
  }
}