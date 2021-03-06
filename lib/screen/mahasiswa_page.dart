import 'dart:convert';
import 'package:bebasapps/network_utils/api.dart';
import 'package:bebasapps/screen/gantipassword_page.dart';
import 'package:flutter/material.dart';
import 'package:bebasapps/screen/index_page.dart';
import 'package:shared_preferences/shared_preferences.dart';


class MahasiswaPage extends StatefulWidget {
  static String tag = 'mahasiswa-page';
  @override
  _MahasiswaPageState createState() => _MahasiswaPageState();
}

class _MahasiswaPageState extends State<MahasiswaPage> {
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
    final profil = Hero(
      tag: 'hero',
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: CircleAvatar(
          radius: 72.0,
          backgroundColor: Colors.transparent,
          backgroundImage: AssetImage('assets/profil.jpg'),
        ),
      ),
    );

    final menu1 = Padding(
      padding: EdgeInsets.symmetric(vertical: 16.0),
      child: RaisedButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
        
        onPressed: () {},

        padding: EdgeInsets.all(12),
        color: Colors.black,
        child: Text('Absen', style: TextStyle(color: Colors.white)),
      ),
    );
    
    final menu2 = Padding(
      padding: EdgeInsets.symmetric(vertical: 16.0),
      child: RaisedButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),

        onPressed: () {},

        padding: EdgeInsets.all(12),
        color: Colors.black,
        child: Text('Cek Absen', style: TextStyle(color: Colors.white)),
      ),
    );

    final menu3 = Padding(
      padding: EdgeInsets.symmetric(vertical: 16.0),
      child: RaisedButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
        onPressed: () {
          Navigator.of(context).pushNamed(GantiPasswordPage.tag);
        },
        padding: EdgeInsets.all(12),
        color: Colors.black,
        child: Text('Ganti Password', style: TextStyle(color: Colors.white)),
      ),
    );

    final logout = FlatButton(
      child: Text(
        'Logout',
        style: TextStyle(color: Colors.black),
      ),
      onPressed: () {
        _logout();
        //Navigator.of(context).pushNamed(IndexPage.tag);
      },
    );
    
    final body = Container(
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.all(28.0),
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: [
          Colors.lightBlueAccent,
          Colors.lightBlueAccent,
        ]),
      ),
      child: Column(
        children: <Widget>[profil, menu1,menu2,menu3,logout],
      ),
    );

    return Scaffold(
      key: _scaffoldKey,
      body: body,
    );
  }

  void _logout() async{
    var res = await Network().getData('/logout');
    var body = json.decode(res.body);
    if(body['success']){
      SharedPreferences localStorage = await SharedPreferences.getInstance();
      localStorage.remove('user');
      localStorage.remove('token');
      _showMsg(body['message']);
      Navigator.of(context).pushNamed(IndexPage.tag);
    }
    else{
      _showMsg(body['message']);
    }
  }
}