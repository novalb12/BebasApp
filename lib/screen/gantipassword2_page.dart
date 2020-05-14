import 'dart:convert';

import 'package:bebasapps/network_utils/api.dart';
import 'package:bebasapps/screen/index_page.dart';
import 'package:bebasapps/screen/dosen_page.dart';
import 'package:flutter/material.dart';

class GantiPassword2Page extends StatefulWidget {
  static String tag = 'gantipassword2-page';
  @override
  _GantiPassword2PageState createState() => new _GantiPassword2PageState();
}

class _GantiPassword2PageState extends State<GantiPassword2Page> {
   bool _isLoading = false;
  final _formKey = GlobalKey<FormState>();
  var passLama;
  var passBaru;
  var passBaruConfirm;
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


    final passwordlama = TextFormField(
      keyboardType: TextInputType.emailAddress,
      autofocus: false,
      decoration: InputDecoration(
        prefixIcon: Icon(Icons.person, size: 25,),
        hintText: 'Password Lama',
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
      ),
      validator: (passlamaValue) {
        if (passlamaValue.isEmpty) {
          return 'Please enter some text';
        }
        passLama=passlamaValue;
        return null;
      },
    );

    final passwordbaru = TextFormField(
      autofocus: false,
      obscureText: true,
      decoration: InputDecoration(
        prefixIcon: Icon(Icons.lock, size: 25),
        hintText: 'Password Baru',
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
      ),
      validator: (passbaruValue) {
        if (passbaruValue.isEmpty) {
          return 'Please enter some text';
        }
        passBaru=passbaruValue;
        return null;
      },
    );

    final confirmpassword = TextFormField(
      autofocus: false,
      obscureText: true,
      decoration: InputDecoration(
        prefixIcon: Icon(Icons.lock, size: 25),
        hintText: 'Konfirmasi Password Baru',
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
      ),
      validator: (passbaruValue) {
        if (passbaruValue.isEmpty) {
          return 'Please enter some text';
        }
        passBaruConfirm=passbaruValue;
        return null;
      },
    );

    final ubahPassButton = Padding(
      padding: EdgeInsets.symmetric(vertical: 16.0),
      child: RaisedButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
        
        onPressed: () {
          if (_formKey.currentState.validate()) {
                _ubahPass();
          }
        },

        padding: EdgeInsets.all(12),
        color: Colors.black,
        child: Text(_isLoading? 'Proccessing...' : 'Ubah Password', style: TextStyle(color: Colors.white)),
      ),
    );
    final form = Form(
      key: _formKey,  
      child:Column(
        children: <Widget>[
          passwordlama,
            SizedBox(height: 8.0),
            passwordbaru,
            SizedBox(height: 8.0),
            confirmpassword,
            SizedBox(height: 24.0),
            ubahPassButton,
        ],
      )
    );
    final kembali = FlatButton(
      child: Text(
        'Batal',
        style: TextStyle(color: Colors.black54),
      ),
      onPressed: () {
        Navigator.of(context).pushNamed(DosenPage.tag);
      },
    );

    final logout = FlatButton(
      child: Text(
        'Logout',
        style: TextStyle(color: Colors.black54),
      ),
      onPressed: () {
        Navigator.of(context).pushNamed(IndexPage.tag);
      },
    );

    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.white,
      body: Center(
        child: ListView(
          shrinkWrap: true,
          padding: EdgeInsets.only(left: 24.0, right: 24.0),
          children: <Widget>[
            logo,
            SizedBox(height: 5.0),
            form,
            kembali,
            logout,
          ],
        ),
        
      ),
    );
  }
  void _ubahPass() async{
    setState(() {
      _isLoading = true;
    });
    var data = {
      'password_lama' : passLama,
      'password_baru' : passBaru,
      'password_baru_confirmation' : passBaruConfirm,
    };
    var res = await Network().postData(data, '/changepassword');
    var body = json.decode(res.body);
    print(body);
    if(body['success']){
      _showMsg(body['message']);
      Navigator.of(context).pushNamed(IndexPage.tag);
    }else{
      _showMsg(body['message']);
    }

    setState(() {
      _isLoading = false;
    });
  }
}