import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:poshop/clients/controllers/ClientController.dart';
import 'package:poshop/clients/tickets.dart';
import 'package:poshop/helpers/widgetsHelper.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class ClientIndividual extends StatelessWidget{
  ClientContoller controllerClient = Get.put(ClientContoller());




  WidgetsHelper helpers = WidgetsHelper();
  var loadingHud;
  @override
  Widget build(BuildContext context) {
    loadingHud = helpers.initLoading(context);

    return Scaffold(
      appBar: AppBar(
        actions: [
          GestureDetector(
            onTap: (){
              Get.to(() => TicketsClient());
            },
            child: Container(
              padding: EdgeInsets.all(20),
              child: Text("Tickets"),
            ),
          )
        ],
      ),
      body:  SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(10),
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.only(top: 20,left: 10,bottom: 5),
                child: Row(
                  children: [
                    Text("Nombres",style: TextStyle(color:  Color(0xff298dcf),fontSize: 18),)
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only( left: 10 ,right: 10),

                child:

                TextFormField(
                  controller:controllerClient.controllerName.value ,
                  onChanged: (value){
                    controllerClient.name.value=value;
                  },
                  decoration: InputDecoration(
                      hintText: 'Escribe los nombres'
                  ),
                  // The validator receives the text that the user has entered.
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor ingrese los nombres';
                    }
                    return null;
                  },
                ),
              ),

              Container(
                margin: EdgeInsets.only(top: 20,left: 10,bottom: 5),
                child: Row(
                  children: [
                    Text("Correo electrónico",style: TextStyle(color:  Color(0xff298dcf),fontSize: 18),)
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only( left: 10 ,right: 10),

                child:

                TextFormField(
                  controller:controllerClient.controllerEmail.value ,
                  onChanged: (value){
                    controllerClient.email.value=value;
                  },
                  decoration: InputDecoration(
                      hintText: 'Escribe el correco electrónico'
                  ),
                  // The validator receives the text that the user has entered.
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor ingrese el correo electrónico';
                    }
                    return null;
                  },
                ),
              ),


              Container(
                margin: EdgeInsets.only(top: 20,left: 10,bottom: 5),
                child: Row(
                  children: [
                    Text("Dirección",style: TextStyle(color:  Color(0xff298dcf),fontSize: 18),)
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only( left: 10 ,right: 10),

                child:

                TextFormField(
                  controller:controllerClient.controllerAddress.value ,
                  onChanged: (value){
                    controllerClient.address.value=value;
                  },
                  decoration: InputDecoration(
                      hintText: 'Escribe la dirección'
                  ),
                  // The validator receives the text that the user has entered.
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor ingrese la dirección';
                    }
                    return null;
                  },
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 20,left: 10,bottom: 5),
                child: Row(
                  children: [
                    Text("Ciudad",style: TextStyle(color:  Color(0xff298dcf),fontSize: 18),)
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only( left: 10 ,right: 10),

                child:

                TextFormField(
                  controller:controllerClient.controllerCity.value ,
                  onChanged: (value){
                    controllerClient.city.value=value;
                  },
                  decoration: InputDecoration(
                      hintText: 'Escribe la ciudad'
                  ),
                  // The validator receives the text that the user has entered.
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor ingrese la ciudad';
                    }
                    return null;
                  },
                ),
              ),


              Column(
                children: [
                  Row(
                    children: [
                      Expanded(child: Column(
                        children: [
                          Container(
                            margin: EdgeInsets.only(top: 20,left: 10,bottom: 5),
                            child: Row(
                              children: [
                                Text("Código postal",style: TextStyle(color:  Color(0xff298dcf),fontSize: 18),)
                              ],
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only( left: 10 ,right: 10),

                            child:

                            TextFormField(
                              controller:controllerClient.controllerPostalCode.value ,
                              onChanged: (value){
                                controllerClient.postalCode.value=value;
                              },
                              decoration: InputDecoration(
                                  hintText: 'Escribe el código postal'
                              ),
                              // The validator receives the text that the user has entered.

                            ),
                          ),
                        ],
                      )),
                      Expanded(child: Column(
                        children: [
                          Container(
                            margin: EdgeInsets.only(top: 20,left: 10,bottom: 5),
                            child: Row(
                              children: [
                                Text("Código del cliente",style: TextStyle(color:  Color(0xff298dcf),fontSize: 18),)
                              ],
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only( left: 10 ,right: 10),

                            child:

                            TextFormField(
                              controller:controllerClient.controllerCustomerCode.value ,
                              onChanged: (value){
                                controllerClient.customerCode.value=value;
                              },
                              decoration: InputDecoration(
                                  hintText: 'Escribe el código del cliente'
                              ),
                              // The validator receives the text that the user has entered.

                            ),
                          ),
                        ],
                      ))
                    ],
                  )
                ],
              ),

              Container(
                margin: EdgeInsets.only(top: 30),
                width: double.infinity,
                child: RaisedButton(
                  shape: new RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(30.0),
                  ),
                  color:Color(0xff298dcf) ,
                  onPressed: () async{

                    loadingHud.show();

                    if(controllerClient.id.value==0){
                      var result= await controllerClient.createClient();

                      if(result!="ok"){
                        helpers.defaultAlert(context, "error", "${result["message"]}",
                            "${result["data"]}");
                      }



                    }else{
                      var result= await controllerClient.updateClient();
                      if(result!="ok"){
                        helpers.defaultAlert(context, "error", "${result["message"]}",
                            "${result["data"]}");
                      }

                    }
                    loadingHud.dismiss();

                    Navigator.pop(context);



                  },
                  child: Text(controllerClient.id.value==0 ? "Crear cliente" :"Actualizar cliente"  ,style: TextStyle(color: Colors.white)),
                ),
              ),
              controllerClient.id.value>0 ? Container(
                width: double.infinity,
                child: RaisedButton(
                  shape: new RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(30.0),
                  ),
                  color:Colors.redAccent ,
                  onPressed: () async{


                    Alert(
                      context: context,
                      type: AlertType.warning,
                      title:"Borrar Cliente",
                      desc: "¿Quieres borrar este cliente?",
                      buttons: [
                        DialogButton(
                          radius: BorderRadius.circular(20),
                          child: Text(
                            "Si",
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          ),
                          onPressed: () async {
                            Navigator.pop(context);
                            loadingHud.show();

                            await controllerClient.deleteClient();
                            loadingHud.dismiss();


                            Navigator.pop(context);

                          },
                          color:  Colors.redAccent,

                        ),

                        DialogButton(
                          radius: BorderRadius.circular(20),
                          child: Text(
                            "No",
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          ),
                          onPressed: () => Navigator.pop(context),
                          color:  Color(0xff298dcf),

                        ),

                      ],
                    ).show();


                  },
                  child: Text("Borrar Cliente"  ,style: TextStyle(color: Colors.white)),
                ),
              ): Container()
            ],
          ),
        ),
      ),
    );
  }

}