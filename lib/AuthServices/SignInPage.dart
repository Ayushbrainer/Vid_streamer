import 'package:flutter/material.dart';
import 'package:vid_streamer/AuthServices/Auth.dart';
import 'package:vid_streamer/main.dart';

class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  String email;
  String password;
  String error = "";
  String correctEmail = "helloworld@hi.com";
  String correctPassWord = "HelloWorld";
  int t = 0;
  final _key = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("SignIn"),
      ),
      body: Form(
          key: _key,
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 40,
              ),
              TextField(
                onChanged: (v) {
                  email = v;
                  if (v == correctEmail) t++;
                },
              ),
              SizedBox(
                height: 30,
              ),
              TextField(
                  obscureText: true,
                  onChanged: (v) {
                    password = v;
                    if (v == correctPassWord) t++;
                  }),
              RaisedButton(
                onPressed: () {
                  if (t == 2) {
                    setState(() {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => VidStrm()));
                    });
                  }
                  /*dynamic result = new AuthServ().SignIn(password,email);
            if(result == null){
              setState(() {
                error = "please supply valid credentials";
              });
            }
            if (result.user!=null){
              Navigator.push(context, MaterialPageRoute(builder: (context)=>VidStrm()));
            }*/
                },
                child: Text("SignIn"),
              ),
              Text(
                error,
                style: TextStyle(color: Colors.red, fontSize: 12),
              )
            ],
          )),
    );
  }
}
