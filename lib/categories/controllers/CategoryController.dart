
import 'dart:convert';

import 'package:get/get.dart';
import 'package:poshop/auth/controllers/AuthController.dart';
import 'package:poshop/categories/category_provider.dart';
import 'package:poshop/categories/models/Category.dart';

import 'package:poshop/service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CategoryContoller extends GetxController{

  AuthContoller controllerAuth=AuthContoller();
  var isPanelOpen=false.obs;
  var categorySelect=0.obs;

  RxList<Category> items = RxList<Category>();


  Client _client = new Client();
  var _endpointProvider;
  SharedPreferences prefs;

  @override
  void onInit() async{
    var  prefs = await SharedPreferences.getInstance();
    _endpointProvider = new CategoryProvider(_client.init(prefs.getString("token")));
    getCategories();
  }

  getCategories() async{

    try{
      var data = await _endpointProvider.getCategories();


      if(data["success"]){
        var dataJson=(data["data"]);
        List<Category> categoryes=[];

        if(dataJson.length>0){
          categorySelect.value= dataJson[0]["id"];
        }

        for(var i = 0 ; i<  dataJson.length; i++){
          categoryes.add(Category(dataJson[i]["id"], dataJson[i]["idOrg"], dataJson[i]["name"], dataJson[i]["color"]));
        }
        items.value=categoryes;

        return true;
      }
    }catch(e){
      print("aqui esta el error ${e}");
      return false;
    }
  }


}
