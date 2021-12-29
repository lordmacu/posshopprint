import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:masonry_grid/masonry_grid.dart';
import 'package:poshop/api_client.dart';
import 'package:poshop/categories/colors.dart';
import 'package:poshop/categories/controllers/CategoryController.dart';
import 'package:poshop/categories/models/Category.dart';
import 'package:poshop/clients/clientIndividual.dart';
import 'package:poshop/clients/clientView.dart';
import 'package:poshop/clients/controllers/ClientController.dart';
import 'package:poshop/clients/models/ClientUserModel.dart';

import 'package:poshop/helpers/widgetsHelper.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:get/get.dart';

class ClientUser extends StatelessWidget {
  ClientContoller controllerClient = Get.put(ClientContoller());

  WidgetsHelper helpers = WidgetsHelper();
  var loadingHud;


  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    loadingHud = helpers.initLoading(context);

    double height = MediaQuery.of(context).size.height;

    var boxWidth=(width/4)-30;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,


        actions: [
          GestureDetector(
            onTap: (){
              controllerClient.isPanelOpen.value=true;
              controllerClient.id.value=0;
              controllerClient.controllerName.value.text="";
              controllerClient.controllerEmail.value.text="";
              controllerClient.controllerAddress.value.text="";
              controllerClient.controllerCity.value.text="";
              controllerClient.controllerPostalCode.value.text="";
              controllerClient.controllerCustomerCode.value.text="";
              controllerClient.categoryColor.value="";
              controllerClient.categoryName.value="";
              controllerClient.name.value="";

              controllerClient.points.value="0";
              controllerClient.lastVisit.value="0";

              controllerClient.tickets.clear();
              controllerClient.tickets.refresh();

              Get.to(() => ClientIndividual());
            },
            child: Container(
              padding: EdgeInsets.all(15),
              child: Text("Agregar"),
            ),
          )
        ],
        title: Text(
          "Clientes",
         ),
      ),
      body: Obx(()=>ListView.builder(
        itemCount: controllerClient.items.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: (){
              ClientUserModel client=controllerClient.items[index];


              print("dando click a esto mano  ${client}");

              controllerClient.name.value=client.name;
              controllerClient.email.value=client.email;
              controllerClient.address.value=client.address;
              controllerClient.city.value=client.city;
              controllerClient.postalCode.value=client.postalCode;
              controllerClient.customerCode.value=client.customerCode;

              controllerClient.points.value=client.points;
              controllerClient.lastVisit.value=client.last_visit;

              controllerClient.id.value=client.id;


              controllerClient.controllerName.value.text=client.name;
              controllerClient.controllerEmail.value.text=client.email;
              controllerClient.controllerAddress.value.text=client.address;
              controllerClient.controllerCity.value.text=client.city;
              controllerClient.controllerPostalCode.value.text=client.postalCode;
              controllerClient.controllerCustomerCode.value.text=client.customerCode;
              controllerClient.tickets.assignAll(client.tickets);

              controllerClient.tickets.refresh();

              print("aquiii estoy cliente  ${client}");



              controllerClient.isPanelOpen.value=true;
               Get.to(() => ClientView());

            },
            child: Container(
              margin: EdgeInsets.only(left: 20,right: 20,top: 10,bottom: 10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10),
                    bottomLeft: Radius.circular(10),
                    bottomRight: Radius.circular(10)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: Offset(0,
                        3), // changes position of shadow
                  ),
                ],
              ),
              child: ListTile(
                title: Text(controllerClient.items[index].name),
              ),
            ),
          );
        },
      )),
    );
  }
}
