
import 'dart:convert';

import 'package:get/get.dart';

import 'package:poshop/service.dart';
import 'package:shared_preferences/shared_preferences.dart';


class AuthContoller extends GetxController{

  var isLogin=true.obs;
  var isLogged=false.obs;
  var email= "".obs;
  var password= "".obs;
  Client _client = new Client();
  var _endpointProvider;
  var token="".obs;
  SharedPreferences prefs;

  @override
  void onInit() {
     _endpointProvider = new AuthProvider(_client.init(token.value));
     initPRefs();
  }

  initPRefs() async{
  }

  setToken() async{
  var  prefs = await SharedPreferences.getInstance();

     token.value= prefs.getString("token");

  }

  checkIfLogged() async{
    prefs = await SharedPreferences.getInstance();
    return prefs.getBool("isLogged");
  }

  logout() async{
    prefs = await SharedPreferences.getInstance();
      prefs.setBool("isLogged",false);
  }

  void loginUserSystem(login,data) async{
    prefs = await SharedPreferences.getInstance();

    prefs.setBool("isLogged", login);
    if(data!=null){
      prefs.setString("user", jsonEncode(data));
      prefs.setString("token", data["token"]);
      token.value=data["token"];
    }

    isLogged.value=login;
  }

  login() async{
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