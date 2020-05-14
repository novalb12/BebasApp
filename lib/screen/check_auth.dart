import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:bebasapps/screen/mahasiswa_page.dart';
import 'package:bebasapps/screen/dosen_page.dart';
import 'package:bebasapps/screen/index_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CheckAuth extends StatefulWidget {
  @override
  _CheckAuthState createState() => _CheckAuthState();
}

class _CheckAuthState extends State<CheckAuth> {
  bool isAuth = false;
  String role = '';
  @override
  void initState() {
    _checkIfLoggedIn();
    super.initState();
  }
  
  void _checkIfLoggedIn() async{
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var token = localStorage.getString('token');
    var user =  localStorage.getString('user');
    var roles;
    if(user!=null){
      roles = json.decode(user)['role'];
    }
    
    if(token != null){
      setState(() {
        isAuth = true;
        role = roles;
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    Widget child;
    if (isAuth) {
      if(role == 'dosen'){
        child = DosenPage();
      }
      else if(role == 'mahasiswa'){
        child = MahasiswaPage();
      }
    } else {
      child = IndexPage();
    }
    
    return Scaffold(
      body: child,
    );
  }
}