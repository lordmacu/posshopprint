
import 'dart:convert';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:poshop/auth/controllers/AuthController.dart';
import 'package:poshop/categories/category_provider.dart';
import 'package:poshop/categories/models/Category.dart';
import 'package:poshop/checkout/controllers/CheckoutController.dart';
import 'package:poshop/clients/client_provider.dart';
import 'package:poshop/clients/clientsUser.dart';
import 'package:poshop/clients/models/ClientUserModel.dart';
import 'package:poshop/home/model/Tax.dart';

import 'package:poshop/service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:poshop/products/controllers/ProductContoller.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class ClientContoller extends GetxController{

  AuthContoller controllerAuth=AuthContoller();
  ProductsContoller controllerProduct = Get.find();

  CheckoutContoller controllerCheckout=  Get.put(CheckoutContoller());

  var panelController= PanelController().obs;

  var isPanelOpen=false.obs;
  var selectedClient=0.obs;
  var selectedClientName="".obs;

  var categoryName="".obs;
  var categoryColor= "".obs;
  var id= 0.obs;


  var name="".obs;
  var email="".obs;
  var address="".obs;
  var city="".obs;
  var postalCode="".obs;
  var customerCode="".obs;


  RxList<ClientUserModel> items = RxList<ClientUserModel>();
  RxList<ClientUserModel> itemsTemp = RxList<ClientUserModel>();
  RxList<Tax> taxes = RxList<Tax>();


  var controllerName= TextEditingController().obs;
  var controllerEmail= TextEditingController().obs;
  var controllerAddress= TextEditingController().obs;
  var controllerPostalCode= TextEditingController().obs;
  var controllerCustomerCode= TextEditingController().obs;
  var controllerCity= TextEditingController().obs;


  Client _client = new Client();
  var _endpointProvider;
  SharedPreferences prefs;

  @override
  void onInit() async{
    //var  prefs = await SharedPreferences.getInstance();
    //_endpointProvider = new CategoryProvider(_client.init(prefs.getString("token")));
    //getCategories();
  }

  filterByName(name){

    if(name.length == 0 ){
      itemsTemp.assignAll(items);
    }else{
      itemsTemp.value = items
          .where((item) => item.name.toLowerCase().contains(name.toLowerCase()))
          .toList();
    }


  }

  deleteClient() async{

    var  prefs = await SharedPreferences.getInstance();


    try{
      var data = await _endpointProvider.deleteClients({
        "id":"${id}"
      });
      getClients();


      if(data["success"]){
        return "ok";
      }
    }catch(e){
      return replaceExeptionText(e.message);

    }
  }

  updateClient() async{

    var  prefs = await SharedPreferences.getInstance();



    try{
      var data = await _endpointProvider.updateCategories({
        "name":name,
        "email":email,
        "address":address,
        "city":city,
        "postalCode":postalCode,
        "customerCode":customerCode,
        "id":"${id}"
      });
      getClients();


      if(data["success"]){
        return "ok";

      }
    }catch(e){
      return replaceExeptionText(e.message);

    }
  }

  createClient() async{

    var  prefs = await SharedPreferences.getInstance();
    _endpointProvider = new ClientProvider(_client.init(prefs.getString("token")));



    try{
      var data = await _endpointProvider.createCategories({
        "name":name,
        "email":email,
        "address":address,
        "city":city,
        "postalCode":postalCode,
        "customerCode":customerCode
       });


      if(data["success"]){
        getClients();

        return "ok";

      }

      }catch(e){
      return replaceExeptionText(e.toString());

    }
  }



  getClients() async{

    var  prefs = await SharedPreferences.getInstance();

    _endpointProvider = new ClientProvider(_client.init(prefs.getString("token")));


    items.refresh();

    items.clear();

    items.refresh();

   // try{
      var data = await _endpointProvider.getClientes();

    if(data["success"]){
      var dataJson=(data["data"]);
      List<ClientUserModel> clients=[];

      for(var i = 0 ; i<  dataJson.length; i++){
        ClientUserModel clientUserModel= ClientUserModel();
        clientUserModel.name=dataJson[i]["name"];
        clientUserModel.id=dataJson[i]["id"];
        clientUserModel.city=dataJson[i]["city"];
        clientUserModel.customerCode=dataJson[i]["customerCode"];
        clientUserModel.postalCode=dataJson[i]["postalCode"];
        clientUserModel.address=dataJson[i]["address"];
        clientUserModel.email=dataJson[i]["email"];

        clients.add(clientUserModel);
      }

      items.assignAll(clients);

      itemsTemp.assignAll(items);



      return true;
    }
  }

  replaceExeptionText(String text){
    return  jsonDecode(text.replaceAll("Exception: ", ""));
  }


}
