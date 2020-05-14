import 'package:flutter/material.dart';
import 'loginmahasiswa_page.dart';
import 'logindosen_page.dart';


class IndexPage extends StatelessWidget {
  static String tag = 'index-page';

  @override
  Widget build(BuildContext context) {
    final profil = Hero(
      tag: 'hero',
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: CircleAvatar(
          radius: 72.0,
          backgroundColor: Colors.transparent,
          backgroundImage: AssetImage('assets/user1.png'),
        ),
      ),
    );

    final welcome = Padding(
      padding: EdgeInsets.all(8.0),
      child: Text(
        'Login Sebagai',
        style: TextStyle(fontSize: 28.0, color: Colors.black),
      ),
    );

    final mahasiswa = Padding(
      padding: EdgeInsets.symmetric(vertical: 16.0),
      child: RaisedButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
        onPressed: () {
          Navigator.of(context).pushNamed(LoginMahasiswaPage.tag);
        },
        padding: EdgeInsets.all(12),
        color: Colors.black,
        child: Text('Mahasiswa', style: TextStyle(color: Colors.white)),
      ),
    );
    
    final dosen = Padding(
      padding: EdgeInsets.symmetric(vertical: 16.0),
      child: RaisedButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
        onPressed: () {
          Navigator.of(context).pushNamed(LoginDosenPage.tag);
        },
        padding: EdgeInsets.all(12),
        color: Colors.black,
        child: Text('Dosen', style: TextStyle(color: Colors.white)),
      ),
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
        children: <Widget>[profil,welcome, mahasiswa, dosen],
      ),
    );

    return Scaffold(
      body: body,
    );
  }
}