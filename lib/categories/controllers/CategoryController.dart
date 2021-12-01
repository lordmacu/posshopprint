
import 'dart:convert';

import 'package:get/get.dart';
import 'package:poshop/auth/controllers/AuthController.dart';
import 'package:poshop/categories/category_provider.dart';
import 'package:poshop/categories/models/Category.dart';

import 'package:poshop/service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:poshop/products/controllers/ProductContoller.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class CategoryContoller extends GetxController{

  AuthContoller controllerAuth=AuthContoller();
  ProductsContoller controllerProduct = Get.find();
  var panelController= PanelController().obs;

  var isPanelOpen=false.obs;
  var categorySelect=0.obs;
  var categoryName="".obs;
  var categoryColor= "".obs;
  var categoryId= 0.obs;
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

  createCategories() async{

    var  prefs = await SharedPreferences.getInstance();

    print("getcatgegoriessss  ${prefs.getString("token")}");

    try{
      var data = await _endpointProvider.createCategories({
        "name":categoryName,
        "color":categoryColor
      });
      getCategories();


      if(data["success"]){
        return "ok";

      }
    }catch(e){
      return replaceExeptionText(e.message);

    }
  }
  deleteCategories() async{

    var  prefs = await SharedPreferences.getInstance();

    print("getcatgegoriessss  ${prefs.getString("token")}");

    try{
      var data = await _endpointProvider.deleteCategories({
        "id":"${categoryId}"
      });
      getCategories();


      if(data["success"]){
        return "ok";
      }
    }catch(e){
      return replaceExeptionText(e.message);

    }
  }

  updateCategories() async{

    var  prefs = await SharedPreferences.getInstance();

    print("getcatgegoriessss  ${prefs.getString("token")}");

    try{
      var data = await _endpointProvider.updateCategories({
        "name":categoryName,
        "color":categoryColor,
        "id":"${categoryId}"
      });
      getCategories();


      if(data["success"]){
        return "ok";

      }
    }catch(e){
      return replaceExeptionText(e.message);

    }
  }

  getCategories() async{

    var  prefs = await SharedPreferences.getInstance();

    print("getcatgegoriessss  ${prefs.getString("token")}");

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

        controllerProduct.getProducts();


        return true;
      }
    }catch(e){
      print("aqui esta el error category ${e}");
      return false;
    }
  }

  replaceExeptionText(String text){
    return  jsonDecode(text.replaceAll("Exception: ", ""));
  }


}
