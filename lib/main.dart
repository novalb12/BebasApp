import 'package:flutter/material.dart';
import 'package:bebasapps/screen/index_page.dart';
import 'package:bebasapps/screen/loginmahasiswa_page.dart';
import 'package:bebasapps/screen/mahasiswa_page.dart';
import 'package:bebasapps/screen/gantipassword_page.dart';
import 'package:bebasapps/screen/logindosen_page.dart';
import 'package:bebasapps/screen/dosen_page.dart';
import 'package:bebasapps/screen/gantipassword2_page.dart';
import 'package:bebasapps/screen/check_auth.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  final routes = <String, WidgetBuilder>{
    
    IndexPage.tag: (context) => IndexPage(),
    LoginMahasiswaPage.tag: (context) => LoginMahasiswaPage(),
    MahasiswaPage.tag: (context) => MahasiswaPage(),
    GantiPasswordPage.tag: (context) => GantiPasswordPage(),
    LoginDosenPage.tag: (context) => LoginDosenPage(),
    DosenPage.tag: (context) => DosenPage(),
    GantiPassword2Page.tag: (context) => GantiPassword2Page()
  };

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Kodeversitas',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.lightBlue,
        fontFamily: 'Nunito',
      ),
      home: CheckAuth(),
      routes: routes,
    );
  }
}