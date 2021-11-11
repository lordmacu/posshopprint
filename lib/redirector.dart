import 'package:flutter/material.dart';
import 'package:poshop/auth/auth.dart';
import 'package:poshop/auth/controllers/AuthController.dart';
import 'package:get/get.dart';
import 'package:poshop/auth/pin.dart';
import 'package:poshop/home/home.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Redirector extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _Redirector();
  }
}

class _Redirector extends State<Redirector> {
  AuthContoller controllerAuth = Get.put(AuthContoller());



  checkLogged() async{

    var  prefs = await SharedPreferences.getInstance();


    prefs.setString("url","https://poschile.bbndev.com/api");


    await controllerAuth.setToken();
    var checkIfLogged= await controllerAuth.checkIfLogged();
    print("aquiii esta la cosa  ${checkIfLogged} ");

    if(checkIfLogged!=null){

       if(checkIfLogged){
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Home()),
        );
      }else{
         Navigator.push(
           context,
           MaterialPageRoute(builder: (context) => Auth()),
         );
       }

    }else{
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => Auth()),
      );
    }
  }


  @override
  void initState()  {
    // TODO: implement initState
    super.initState();

    checkLogged();
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
   return  Scaffold(
     body: Text(""),
   );
  }

}