import 'package:easy_mask/easy_mask.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:poshop/checkout/models/ItemSimple.dart';
import 'package:poshop/discounts/controllers/DiscountContoller.dart';
import 'package:poshop/discounts/model/Discount.dart';
import 'package:poshop/helpers/widgetsHelper.dart';
import 'package:poshop/tickets/controllers/TicketsController.dart';
import 'package:poshop/tickets/model/Ticket.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:flutter_switch/flutter_switch.dart';

class Discounts extends StatelessWidget {

  DiscountContoller controllerDiscounts= Get.put(DiscountContoller());
  WidgetsHelper helpers = WidgetsHelper();
  TextEditingController nameController= TextEditingController();
  TextEditingController valueController= TextEditingController();
  var loadingHud;

  deleteDiscount(context,id){

    Alert(
      context: context,
      type: AlertType.warning,
      title: "Borrar descuento",
      desc: "¿Estas seguro de borrar este descuento?",
      buttons: [
        DialogButton(
          child: Text(
            "NO",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: () {

            Navigator.pop(context);
            FocusScope.of(context).unfocus();

          },
          color: Color(0xff298dcf),
        ),
        DialogButton(
          child: Text(
            "SI",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: () async {



            Navigator.pop(context);
            FocusScope.of(context).unfocus();
            loadingHud.show();
            await controllerDiscounts.deleteDiscounts(id);
            loadingHud.dismiss();

          },
          color: Colors.redAccent,

        )
      ],
    ).show();
  }

  @override
  Widget build(BuildContext context) {
    loadingHud = helpers.initLoading(context);

    return Scaffold(
      appBar: AppBar(
        title: Text("Descuentos"),
        actions: [
          InkWell(
            onTap: (){
              controllerDiscounts.DiscountSingular.value= Discount();
              controllerDiscounts.DiscountSingular.value.calculationType="PERCENT";
              controllerDiscounts.panelController.value.open();
            },
            child: Container(
              padding: EdgeInsets.only(right: 10,top: 20,bottom: 20,left: 10),
              child: Text("Agregar"),
            ),
          )
        ],
      ),
      body: SlidingUpPanel(
        backdropTapClosesPanel: true,
        backdropEnabled: true,
        controller: controllerDiscounts.panelController.value,
        minHeight: 0,

        panel: Obx(()=>controllerDiscounts.DiscountSingular.value != null ? Container(
          padding: EdgeInsets.only(left: 10,right: 10,top: 20),
          child: Form(
            key: controllerDiscounts.formKey.value,
            child: Column(
              children: [
                TextFormField(
                   controller: nameController,
                  onChanged: (value){
                    controllerDiscounts.nameDiscount.value=value;
                  },
                  cursorColor: Colors.black,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Ingresa el valor';
                    }
                    return null;
                  },
                  
                  decoration: new InputDecoration(

                      contentPadding:
                      EdgeInsets.only(left: 15, bottom: 11, top: 11, right: 15),
                      hintText: "Nombre"),
                ),
                Container(
                  margin: EdgeInsets.only(top: 10),
                  child: Row(
                    children: [
                      Expanded(child: TextFormField(
                        keyboardType: TextInputType.number,

                        
                        controller: valueController,
                        onChanged: (value){
                          controllerDiscounts.valueDiscount.value=value;
                        },
                        cursorColor: Colors.black,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Ingresa el valor';
                          }
                          if(controllerDiscounts.typeDiscount.value){
                            if (int.parse(value) >100) {
                              return 'Ingresar un valor menor a 100%';
                            }
                          }


                          return null;
                        },
                        decoration: new InputDecoration(

                            contentPadding:
                            EdgeInsets.only(left: 15, bottom: 11, top: 11, right: 15),
                            hintText: "Valor"),
                      )),

                     Container(
                       padding: EdgeInsets.only(left: 20),
                       child:  FlutterSwitch(

                         value: controllerDiscounts.typeDiscount.value,
                         activeText: "%",
                         inactiveText: "Σ",
                         borderRadius: 30.0,
                         padding: 8.0,
                         valueFontSize: 25,
                         toggleSize: 30,
                         height: 50,
                         width: 120,
                         showOnOff: true,
                         onToggle: (val) {

                           controllerDiscounts.typeDiscount.value=val;

                         },
                       ),
                     )

                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 10),

                  child: RaisedButton(
                    padding: EdgeInsets.only(top: 10, bottom: 10),
                    onPressed: () async {

                      if (controllerDiscounts.formKey.value.currentState.validate()) {

                        try{



                        controllerDiscounts.DiscountSingular.value.name=controllerDiscounts.nameDiscount.value;
                        controllerDiscounts.DiscountSingular.value.value=controllerDiscounts.valueDiscount.value;
                        if(controllerDiscounts.typeDiscount.value==true){
                          controllerDiscounts.DiscountSingular.value.calculationType="PERCENT";
                        }else{
                          controllerDiscounts.DiscountSingular.value.calculationType="AMOUNT";
                        }
                        controllerDiscounts.DiscountSingular.value.limitedAccess=0;
                        var result;

                        print("erste es el valor   ${controllerDiscounts.DiscountSingular.value.id}");
                        loadingHud.show();
                        if(controllerDiscounts.DiscountSingular.value.id!=null){
                           result= await controllerDiscounts.editDiscounts();
                           FocusScope.of(context).unfocus();

                        }else{
                           result= await controllerDiscounts.createDiscounts();
                           FocusScope.of(context).unfocus();

                        }

                        loadingHud.dismiss();

                        if(result=="ok"){
                         controllerDiscounts.DiscountSingular.value= Discount();
                         controllerDiscounts.DiscountSingular.value.calculationType="PERCENT";
                         controllerDiscounts.panelController.value.close();
                       }else{
                         helpers.defaultAlert(context, "error", "${result["message"]}",
                             "${result["data"]}");
                       }

                        valueController.text="";
                        nameController.text="";
                        }catch(e){
                          helpers.defaultAlert(context, "error", "error",
                              "${e.message}");
                        }
                      }




                    },

                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                    color: Color(0xff298dcf),
                    child: Text(
                      "Guardar",
                      style: TextStyle(color: Colors.white, fontSize: 17),
                    ),
                  ),
                )
              ],
            ),
          ),
        ) : Container()),
        body: Container(
          padding: EdgeInsets.only(left: 20, right: 20, top: 15),

          child:  Obx(()=>ListView.builder(
              itemCount: controllerDiscounts.discounts.length,
              itemBuilder: (context, index) {
                Discount discount = controllerDiscounts.discounts[index];


                return Container(
                    padding: EdgeInsets.only(
                        left: 10, right: 10, top: 10, bottom: 10),
                    child: Container(
                      padding: EdgeInsets.all(10),
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
                            offset:
                            Offset(0, 3), // changes position of shadow
                          ),
                        ],
                      ),
                      child: Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(child: Text("${discount.name} ${double.parse(discount.value).toInt()} ${discount.calculationType == "PERCENT" ? '%' : ''}")),
                            Container(
                              child: Row(
                                children: [
                                  Container(
                                    margin: EdgeInsets.only(left: 10),
                                    width: 50,
                                    child: ElevatedButton(
                                      style: ButtonStyle(
                                          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                              RoundedRectangleBorder(
                                                  borderRadius: BorderRadius.circular(18.0),
                                                  side: BorderSide(color: Colors.teal, width: 2.0)))),
                                      child: Icon(Icons.edit),
                                      onPressed: () {

                                        controllerDiscounts.DiscountSingular.value= Discount();
                                        controllerDiscounts.DiscountSingular.value.calculationType=discount.calculationType;
                                        controllerDiscounts.DiscountSingular.value.id=discount.id;
                                        controllerDiscounts.DiscountSingular.value.name=discount.name;
                                        controllerDiscounts.DiscountSingular.value.value="${double.parse(discount.value).toInt()}";
                                        valueController.text=controllerDiscounts.DiscountSingular.value.value;
                                        nameController.text=discount.name;
                                        controllerDiscounts.nameDiscount.value=discount.name;

                                        print(controllerDiscounts.DiscountSingular.value.name);

                                        if(discount.calculationType=="PERCENT"){
                                          controllerDiscounts.typeDiscount.value=true;
                                        }else{
                                          controllerDiscounts.typeDiscount.value=false;
                                        }
                                        controllerDiscounts.panelController.value.open();

                                      },
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(left: 10),
                                    width: 50,
                                    child: ElevatedButton(
                                      style: ButtonStyle(
                                          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                              RoundedRectangleBorder(
                                                  borderRadius: BorderRadius.circular(18.0),
                                                  side: BorderSide(color: Colors.teal, width: 2.0)))),
                                      child: Icon(Icons.delete),
                                      onPressed: () {

                                        deleteDiscount(context,discount.id);
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ));
              })),
        ),
      ),
    );
  }
}
