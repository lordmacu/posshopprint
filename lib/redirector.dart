import 'package:flutter/material.dart';
import 'package:poshop/auth/auth.dart';
import 'package:poshop/auth/controllers/AuthController.dart';
import 'package:get/get.dart';
import 'package:poshop/home/home.dart';

class Redirector extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _Redirector();
  }
}

class _Redirector extends State<Redirector> {
  AuthContoller controllerAuth = Get.put(AuthContoller());

  checkLogged() async{
    await controllerAuth.setToken();
    var checkIfLogged= await controllerAuth.checkIfLogged();

    if(checkIfLogged!=null){
      if(checkIfLogged){
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Home()),
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