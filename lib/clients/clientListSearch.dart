import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:poshop/clients/clientsUser.dart';
import 'package:poshop/clients/controllers/ClientController.dart';
import 'package:poshop/helpers/widgetsHelper.dart';

class ClientListSearch extends StatelessWidget{
  ClientContoller controllerClient = Get.put(ClientContoller());

  WidgetsHelper helpers = WidgetsHelper();
  var loadingHud;
  @override
  Widget build(BuildContext context) {
    loadingHud = helpers.initLoading(context);

    return Scaffold(
      appBar: AppBar(
        actions: [
          InkWell(
            onTap: ()  async{
              Get.to(() => ClientUser());
              loadingHud.show();

              await controllerClient.getClients();
              loadingHud.dismiss();


            },
            child: Container(
              padding: EdgeInsets.only(left: 20,right: 20,top: 10,bottom: 10),
              child: Icon(
                Icons.person_add,
            
              ),
            ),
          ),
        ],
      ),
      body: Obx(()=>Column(
        children: [
          SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: TextField(
              onChanged: (value) {
                controllerClient.filterByName(value);

              },
              decoration: InputDecoration(
                labelText: 'Cliente',
                suffixIcon: Icon(Icons.search),
              ),
            ),
          ),
          SizedBox(height: 10),
          Expanded(child: ListView.builder(
            itemCount: controllerClient.itemsTemp.length,
            itemBuilder: (context, index) {



              return GestureDetector(
                onTap: (){

                  controllerClient.selectedClient.value=controllerClient.itemsTemp[index].id;
                  controllerClient.selectedClientName.value=controllerClient.itemsTemp[index].name;
                  Navigator.of(context).pop();
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
                    title: Text(controllerClient.itemsTemp[index].name),
                  ),
                ),
              );
            },
          ))
        ],
      )),
    );
  }

}