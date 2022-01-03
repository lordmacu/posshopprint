
import 'dart:convert';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:poshop/auth/controllers/AuthController.dart';
import 'package:poshop/categories/category_provider.dart';
import 'package:poshop/categories/models/Category.dart';
import 'package:poshop/checkout/controllers/CheckoutController.dart';
import 'package:poshop/checkout/models/DiscountSimple.dart';
import 'package:poshop/checkout/models/ItemSimple.dart';
import 'package:poshop/checkout/models/PaymentSimple.dart';
import 'package:poshop/clients/client_provider.dart';
import 'package:poshop/clients/clientsUser.dart';
import 'package:poshop/clients/models/ClientUserModel.dart';
import 'package:poshop/home/model/Tax.dart';
import 'package:poshop/home/model/TaxCart.dart';
import 'package:intl/intl.dart';

import 'package:poshop/service.dart';
import 'package:poshop/tickets/model/Ticket.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:poshop/products/controllers/ProductContoller.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class ClientContoller extends GetxController{

  AuthContoller controllerAuth=AuthContoller();
  ProductsContoller controllerProduct = Get.find();

  CheckoutContoller controllerCheckout=  Get.put(CheckoutContoller());

  var panelController= PanelController().obs;

  var  points="0".obs;
  var lastVisit="0".obs;
  var isPanelOpen=false.obs;
  var selectedClient=0.obs;
  var selectedClientName="".obs;

  var categoryName="".obs;
  var categoryColor= "".obs;
  var id= 0.obs;

  Rx<int> indexTicket= Rx<int>();

  var name="".obs;
  var email="".obs;
  var address="".obs;
  var city="".obs;
  var postalCode="".obs;
  var customerCode="".obs;

  RxList<Ticket> tickets = RxList<Ticket>();

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

        log("este es del servidor   ${dataJson[i]}");
        ClientUserModel clientUserModel= ClientUserModel();
        clientUserModel.name=dataJson[i]["name"];
        clientUserModel.id=dataJson[i]["id"];
        clientUserModel.city=dataJson[i]["city"];
        clientUserModel.customerCode=dataJson[i]["customerCode"];
        clientUserModel.postalCode=dataJson[i]["postalCode"];
        clientUserModel.address=dataJson[i]["address"];
        clientUserModel.email=dataJson[i]["email"];
        clientUserModel.points="${dataJson[i]["points"]}";
        clientUserModel.last_visit=dataJson[i]["last_visit"];


        List<Ticket> itemsLocal = [];

        var tickets= dataJson[i]["tickets"];

        for (var t = 0; t < tickets.length; t++) {
          var payments = tickets[t]["payments"];
          var items = tickets[t]["items"];

          List<PaymentSimple> paymentsSimple = [];
          List<TaxCart> taxCartList = [];
          List<ItemSimple> itemsSimple = [];

          for (var p = 0; p < payments.length; p++) {
            paymentsSimple.add(PaymentSimple(payments[p]["name"],
                double.parse("${payments[p]["amount"]}"), payments[p]["method"]));
          }

          for (var t = 0; t < items.length; t++) {
            List<DiscountSimple> discountsSimple = [];

            var discounts = items[t]["discounts"];
            for (var d = 0; d < discounts.length; d++) {

              DiscountSimple simpled=DiscountSimple(
                  discounts[d]["discount_id"], discounts[d]["discount_applied"]);

              simpled.name=discounts[d]["name"];
              simpled.discount=discounts[d]["discount"];
              simpled.type=discounts[d]["type_discount"];
              simpled.calculationType=discounts[d]["calculation_type_discount"];

              discountsSimple.add(simpled);
            }



            var itemSimple=ItemSimple(items[t]["name"], double.parse("${items[t]["quantity"]}"),
                items[t]["amount"], discountsSimple);

            itemSimple.divisible=items[t]["divisible"];

            itemsSimple.add(itemSimple);
          }

          if(tickets[t]["taxes"]!=null){
            for(var t=0 ; t <tickets[t]["taxes"].length ; t ++){

              var tax=tickets[t]["taxes"][t];
              TaxCart taxCart = TaxCart(0, "${tax["rate"]}", tax["name"], "${tax["total_tax"]}", tax["tax_type"]);
              taxCartList.add(taxCart);
            }
          }



          DateTime parseDate =
          new DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'").parse(tickets[t]["date"]);
          var inputDate = DateTime.parse(parseDate.toString());
          var outputFormat = DateFormat('MM/dd/yyyy hh:mm a');
          var outputDate = outputFormat.format(inputDate);

          print("asdfasdf asd datetime  ${outputDate}");

          Ticket ticket = Ticket();
          ticket.id=tickets[t]["id"];
          ticket.total=tickets[t]["total"];
          ticket.email=tickets[t]["email"];
          ticket.code=tickets[t]["code"];
          ticket.date=outputDate;
          ticket.taxes=taxCartList;
          ticket.payments=paymentsSimple;
          ticket.items=itemsSimple;
          itemsLocal.add(ticket);
        }
        clientUserModel.tickets.assignAll(itemsLocal);



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
