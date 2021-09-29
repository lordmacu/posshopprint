
import 'dart:convert';

import 'package:get/get.dart';
import 'package:dio/dio.dart';
import 'package:poshop/home/controllers/HomeController.dart';

import 'package:poshop/service.dart';
import 'package:shared_preferences/shared_preferences.dart';


class AuthContoller extends GetxController{

  var isLogin=true.obs;
  var isLogged=false.obs;
  var email= "".obs;
  var password= "".obs;

  @override
  void onInit() {

  }

  void loginUserSystem(login,data) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool("isLogged", login);

    if(data!=null){
      prefs.setString("user", jsonEncode(data));
      prefs.setString("token", data["token"]);
    }

    isLogged.value=login;
  }

  login() async{
    Client _client = new Client();
    var _endpointProvider = new AuthProvider(_client.init());
    try{
      var data = await _endpointProvider.login(email,password);
       if(data["success"]){
        loginUserSystem(true,data["data"]);
        return true;
      }
    }catch(e){

      loginUserSystem(false,null);
      return false;

    }
  }

}