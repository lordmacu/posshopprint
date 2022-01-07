import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:poshop/clients/clientIndividual.dart';
import 'package:poshop/clients/controllers/ClientController.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:poshop/clients/tickets.dart';

class ClientView extends StatelessWidget {
  ClientContoller controllerClient = Get.find();

  getDateSpanish(date){
    return DateFormat( "dd MMM yyyy", "es_ES").format(DateTime.parse(date));
  }

  @override
  Widget build(BuildContext context) {
    initializeDateFormatting();

    return Scaffold(
      appBar: AppBar(
        title: Text("Perfil del cliente"),
      ),
      body: Container(
        margin: EdgeInsets.only(top: 20,left: 20,right: 20),
        child: SingleChildScrollView(
          child: Obx(()=>Column(
            children: [
              controllerClient.name.value != null  ?  Container(

                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text("${controllerClient.name.value}",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),)
                  ],
                ),
                margin: EdgeInsets.only(bottom: 30),
              ): Container(),
              controllerClient.email.value != null ? Container(
                margin: EdgeInsets.only(bottom: 20),
                child: Row(

                  children: [
                    Container(

                      child: Icon(Icons.email,color: Colors.grey,),
                      margin: EdgeInsets.only(right: 20),
                    ),
                    Text("${controllerClient.email.value}",style: TextStyle(fontSize: 15),)
                  ],
                ),
              ) : Container(),
              controllerClient.address.value != null ? Container(
                margin: EdgeInsets.only(bottom: 20),
                child: Row(

                  children: [
                    Container(

                      child: Icon(Icons.location_on,color: Colors.grey,),
                      margin: EdgeInsets.only(right: 20),
                    ),
                    Text("${controllerClient.address.value}",style: TextStyle(fontSize: 15),)
                  ],
                ),
              ) : Container(),
              controllerClient.city.value != null ? Container(
                margin: EdgeInsets.only(bottom: 20),
                child: Row(

                  children: [
                    Container(

                      child: Icon(Icons.location_city,color: Colors.grey,),
                      margin: EdgeInsets.only(right: 20),
                    ),
                    Text("${controllerClient.city.value}",style: TextStyle(fontSize: 15),)
                  ],
                ),
              ): Container(),
              controllerClient.postalCode.value != null ?  Container(
                margin: EdgeInsets.only(bottom: 20),
                child: Row(

                  children: [
                    Container(

                      child: Icon(Icons.location_history_outlined,color: Colors.grey,),
                      margin: EdgeInsets.only(right: 20),
                    ),
                    Text("${controllerClient.postalCode.value}",style: TextStyle(fontSize: 15),)
                  ],
                ),
              ) : Container(),
              controllerClient.customerCode.value != null ? Container(
                margin: EdgeInsets.only(bottom: 20),
                child: Row(

                  children: [
                    Container(

                      child: Icon(Icons.confirmation_number,color: Colors.grey,),
                      margin: EdgeInsets.only(right: 20),
                    ),
                    Text("${controllerClient.customerCode.value}",style: TextStyle(fontSize: 15),)
                  ],
                ),
              )  : Container(),
              Container(
                margin: EdgeInsets.only(bottom: 20,top: 20),
                child: null,
                height: 1,
                color: Colors.grey.withOpacity(0.3),
              )
              ,
              controllerClient.points.value != null  ? InkWell(
                onTap: (){

                },
                child: Container(
                  margin: EdgeInsets.only(top: 10,bottom: 10),

                  child: Row(

                    children: [
                      Container(

                        child: Icon(Icons.star,color: Colors.grey,),
                        margin: EdgeInsets.only(right: 20),
                      ),
                      Text("${controllerClient.points.value}",style: TextStyle(fontSize: 15),)
                    ],
                  ),
                ),
              ) : Container(),
              controllerClient.tickets.value !=null ? InkWell(
                onTap: (){
                  Get.to(() => TicketsClient());
                },
                child: Container(
                  margin: EdgeInsets.only(top: 10,bottom: 10),

                  child: Row(

                    children: [
                      Container(

                        child: Icon(Icons.shopping_cart,color: Colors.grey,),
                        margin: EdgeInsets.only(right: 20),
                      ),
                      Text("${controllerClient.tickets.value.length}",style: TextStyle(fontSize: 15),)
                    ],
                  ),
                ),
              )  : Container(),
              controllerClient.lastVisit.value!= null ? Container(
                margin: EdgeInsets.only(top: 20),
                child: Row(

                  children: [
                    Container(

                      child: Icon(Icons.calendar_today_outlined,color: Colors.grey,),
                      margin: EdgeInsets.only(right: 20),
                    ),
                    Text("${getDateSpanish(controllerClient.lastVisit.value)}",style: TextStyle(fontSize: 15),)
                  ],
                ),
              ): Container(),
              InkWell(
                onTap: () async{
                  var individidual= await Get.to(() => ClientIndividual());
                  if(individidual!=null){
                    if(individidual=="delete"){
                      Get.back();
                    }
                  }



                },
                child: Container(

                  padding: EdgeInsets.only(bottom: 30,top: 30,left: 10),
                  child: Row(

                    children: [

                      Text("EDITAR PERFIL",style: TextStyle(fontSize: 15,color: Colors.blueAccent),)
                    ],
                  ),
                ),
              ),
            ],
          )),
        ),
      ),
    );
  }

}