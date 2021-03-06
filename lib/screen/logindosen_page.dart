import 'dart:ui';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:flutter/material.dart';
import 'package:bebasapps/network_utils/api.dart';
import 'dosen_page.dart';
import 'index_page.dart';

class LoginDosenPage extends StatefulWidget {
  static String tag = 'logindosen-page';
  @override
  _LoginDosenPageState createState() => new _LoginDosenPageState();
}

class _LoginDosenPageState extends State<LoginDosenPage> {
  bool _isLoading = false;
  final _formKey = GlobalKey<FormState>();
  var idDosen;
  var pass;
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  _showMsg(msg) {
    final snackBar = SnackBar(
      content: Text(msg),
      action: SnackBarAction(
        label: 'Close',
        onPressed: () {
          // Some code to undo the change!
        },
      ),
    );
    _scaffoldKey.currentState.showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    final logo = Hero(
      tag: 'hero',
      child: CircleAvatar(
        backgroundColor: Colors.transparent,
        radius: 48.0,
        child: Image.asset('assets/user2.png'),
      ),
    );

    final welcome = Padding(
      padding: EdgeInsets.all(0.0),
      
      child: Text(
        'Login Sebagai Dosen',
        style: TextStyle(fontSize: 20.0, color: Colors.black),
      ),
    );

    final email = TextFormField(
      keyboardType: TextInputType.emailAddress,
      autofocus: false,
      decoration: InputDecoration(
        prefixIcon: Icon(Icons.person, size: 25,),
        hintText: 'Id Dosen',
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
      ),
      validator: (idValue) {
        if (idValue.isEmpty) {
          return 'Please enter some text';
        }
        idDosen=idValue;
        return null;
      },
    );

    final password = TextFormField(
      autofocus: false,
      obscureText: true,
      decoration: InputDecoration(
        prefixIcon: Icon(Icons.lock, size: 25,),
        hintText: 'Password',
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
      ),
      validator: (passwordValue) {
        if (passwordValue.isEmpty) {
          return 'Please enter some text';
        }
        pass=passwordValue;
        return null;
      },
    );

    final loginButton = Padding(
      padding: EdgeInsets.symmetric(vertical: 16.0),
      child: RaisedButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
        onPressed: () {
          print('nice');
          if (_formKey.currentState.validate()) {
                _login();
          }
          //Navigator.of(context).pushNamed(DosenPage.tag);
        },
        padding: EdgeInsets.all(12),
        color: Colors.black,
        child: Text(_isLoading? 'Proccessing...' : 'Login'
                      , style: TextStyle(color: Colors.white)),
      ),
    );

    final forgotLabel = FlatButton(
      child: Text(
        'Lupa password?',
        style: TextStyle(color: Colors.black54),
      ),
      onPressed: () {},
    );

    final kembali = FlatButton(
      child: Text(
        'Kembali',
        style: TextStyle(color: Colors.black54),
      ),
      onPressed: () {
        Navigator.of(context).pushNamed(IndexPage.tag);
      },
    );
    final form = Form(
      key: _formKey,
      child:Column(children: <Widget>[
        email,
        SizedBox(height: 8.0),
        password,
        SizedBox(height: 24.0),
        loginButton,
      ],)
    );
    return Scaffold(
      key : _scaffoldKey,
      backgroundColor: Colors.white,
      body: Center(
        child: ListView(
          shrinkWrap: true,
          padding: EdgeInsets.only(left: 24.0, right: 24.0),
          children: <Widget>[
            logo,
            SizedBox(height: 5.0),
            welcome,
            form,
            forgotLabel,
            kembali
          ],
        ),
        
      ),
    );
  }

  void _login() async{
    print('au');
    setState(() {

      _isLoading = true;
    });
    var data = {
      'nomor_induk' : idDosen,
      'password' : pass,
      'role' : 'dosen',
    };

    var res = await Network().postData(data, '/login');
    print('su');
    var body = json.decode(res.body);
    if(body['success']){
      SharedPreferences localStorage = await SharedPreferences.getInstance();
      localStorage.setString('token', json.encode(body['token']));
      localStorage.setString('user', json.encode(body['user']));
      
      Navigator.of(context).pushNamed(DosenPage.tag);
    }else{
      _showMsg(body['message']);
    }

    setState(() {
      _isLoading = false;
    });
  }

}

