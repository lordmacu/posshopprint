
import 'dart:convert';

import 'package:get/get.dart';

import 'package:poshop/service.dart';
import 'package:shared_preferences/shared_preferences.dart';


class AuthContoller extends GetxController{

  var isLogin=true.obs;
  var isLogged=false.obs;
  var email= "".obs;
  var password= "".obs;
  var pin= "".obs;
  var business= "".obs;

  Client _client = new Client();
  var _endpointProvider;
  var token="".obs;
  SharedPreferences prefs;

  @override
  void onInit() async {
    var  prefs = await SharedPreferences.getInstance();

    if(prefs.getString("token") != null){
      _endpointProvider = new AuthProvider(_client.init(prefs.getString("token")));

    }else{
      _endpointProvider = new AuthProvider(_client.init(" "));
    }

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

    print("esta es la data del login   ${data}");
    if(data!=null){
      prefs.setString("user", jsonEncode(data));
      //prefs.setInt("outletId",  data["user"]["outlet"]["id"]);
      //prefs.setInt("cashRegister",  data["user"]["cashRegister"]["id"]);


          prefs.setInt("idOrg", data["user"]["idOrg"]);






      prefs.setString("token", data["token"]);
      token.value=data["token"];
      outletsAvailable();

    }

    isLogged.value=login;
  }

  login() async{
    try{
      var data = await _endpointProvider.login(email,password);
       if(data["success"]){
        loginUserSystem(true,data["data"]);

        return "ok";
      }
    }catch(e){
      loginUserSystem(false,null);
      return replaceExeptionText(e.message);
    }
  }


  outletsAvailable() async{
    prefs = await SharedPreferences.getInstance();

    _endpointProvider = new AuthProvider(_client.init(prefs.getString("token")));

    try{
      var data = await _endpointProvider.outletAvailable();
      if(data["success"]){

        prefs = await SharedPreferences.getInstance();

        if(data["data"]!=null){
          prefs.setString("outlet", jsonEncode(data["data"][0]));
          prefs.setInt("outletId", data["data"][0]["id"]);
          prefs.setString("cashier", jsonEncode(data["data"][0]["cashregisters_inactives"][0]));
          prefs.setInt("cashierId", data["data"][0]["cashregisters_inactives"][0]["id"]);

          print("aquiii esta la cosa ${prefs.getInt("cashierId")}");
          cashRegister();
        }

        return true;
      }
    }catch(e){
      prefs = await SharedPreferences.getInstance();
      prefs.setString("outlet", "");
      prefs.setInt("outletId", 0);
      prefs.setString("cashier", "");
      prefs.setInt("cashierId", 0);
      //prefs.clear();

      print("error : ${e}");

      return false;
    }
  }

  cashRegister() async{
    prefs = await SharedPreferences.getInstance();

     _endpointProvider = new AuthProvider(_client.init(prefs.getString("token")));

    try{
      var data = await _endpointProvider.cashRegister(prefs.getInt("cashierId"));

      if(data["success"]){

        return true;
      }
    }catch(e){

      return false;
    }
  }


  loginPin() async{
    prefs = await SharedPreferences.getInstance();
    try{
      var data = await _endpointProvider.loginPin(pin,prefs.getString("idOrg"));
      if(data["success"]){
        loginUserSystem(true,data["data"]);
        return true;
      }
    }catch(e){
      print("sadfasd   ${e}");
    //  loginUserSystem(false,null);
      return false;
    }
  }

  register() async{
    try{
      var data = await _endpointProvider.register(email,password,business);

      print("esta es la data ${data}");
      if(data["success"]){
        loginUserSystem(true,data["data"]);
        return "ok";
      }
    }catch(e){

    loginUserSystem(false,null);
     return replaceExeptionText(e.message);

    }
  }

  replaceExeptionText(String text){
   return  jsonDecode(text.replaceAll("Exception: ", ""));
  }

}