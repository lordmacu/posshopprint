import 'package:easy_mask/easy_mask.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:pop_bottom_menu/pop_bottom_menu.dart';
import 'package:poshop/cart/controllers/CartController.dart';
import 'package:poshop/categories/controllers/CategoryController.dart';
import 'package:poshop/checkout/card.dart';
import 'package:poshop/checkout/cash.dart';
import 'package:poshop/checkout/controllers/CheckoutController.dart';
import 'package:poshop/checkout/divide.dart';
import 'package:poshop/checkout/models/Payment.dart';
import 'package:poshop/clients/clientListSearch.dart';
import 'package:poshop/clients/controllers/ClientController.dart';
import 'package:poshop/helpers/MoneyTextInputFormatted.dart';
import 'package:poshop/helpers/widgetsHelper.dart';
import 'package:poshop/home/model/TaxCart.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:checkbox_grouped/checkbox_grouped.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class Checkout extends StatelessWidget {
  CheckoutContoller controllerCheckout = Get.find();
  CartContoller controllerCart = Get.find();
  TextEditingController textContoller= TextEditingController();

  WidgetsHelper helpers = WidgetsHelper();
  var loadingHud;

  ClientContoller controllerClient= Get.put(ClientContoller());

  final CurrencyTextInputFormatter _formatter = CurrencyTextInputFormatter();
  CategoryContoller controllerCategory = Get.find();

  formatedNumber(number) {


    //number = number.replaceAll(".", "");

    var numberText = int.parse(number);
    var formatCurrency;
    formatCurrency = new NumberFormat.currency(
        customPattern: "\u00A4#,##0.00\u00A0",
        symbol: "",
        decimalDigits: 0,
        locale: "es");

    return formatCurrency.format(numberText);

  }

  showClients(context){
    showModalBottomSheet(
      backgroundColor: Colors.transparent,
      context: context,
      builder: (context) {
        List<ItemPopBottomMenu> items = [];



        if(controllerClient.items.length>0){
          for (var i = 0; i < controllerClient.items.length; i++) {


            items.add(ItemPopBottomMenu(
              onPressed: () {


                Navigator.of(context).pop();
              },
              label: controllerClient.items[i].name,
              icon: Icon(
                Icons.check_circle,
                color: controllerClient.selectedClient.value ==
                    controllerClient.items[i].id
                    ? Colors.greenAccent
                    : Colors.grey.withOpacity(0.5),
              ),
            ));
          }

          return PopBottomMenu(
            title: TitlePopBottomMenu(
              label: "Categorías",
            ),
            items: items,
          );
        }else{

          items.add(ItemPopBottomMenu(
            onPressed: () {

              Navigator.of(context).pop();
            },
            label: "Agregar Cliente",
            icon: Icon(
              Icons.person_add,

            ),
          ));

          return PopBottomMenu(
            title: TitlePopBottomMenu(
              label: "Categorías",
            ),
            items: items,
          );
        }



      },
    );
  }

  canPressPayment(){




    if(controllerCheckout.valueCheckout.value!=""){
      print("aqwuiii el valor   ${controllerCheckout.totalCheckout.value}   ${double.parse (controllerCheckout.valueCheckout.value).toInt()} ");
      return controllerCheckout.totalCheckout.value>= double.parse (controllerCheckout.valueCheckout.value).toInt();
    }
    return false;

  }

  List<Widget> getPayments(_panelController) {
    List<Widget> paymentsLocal = [];
    for (var i = 0; i < controllerCheckout.paymentItems.length; i++) {
      paymentsLocal.add(Container(
        padding: EdgeInsets.only(left: 5, right: 5),
        child: RaisedButton(
          shape: new RoundedRectangleBorder(
            borderRadius: new BorderRadius.circular(30.0),
          ),
          color: Color(0xff298dcf),
          onPressed: canPressPayment() ?   () {
            if (textContoller.text.length > 0) {




            controllerCheckout.typePayment.value = 2;
            controllerCheckout.paymentCheckoutsItems.clear();
            controllerCheckout.paymentCheckoutsItems.add(Payment(
                controllerCheckout.paymentItems[i].id,
                controllerCheckout.paymentItems[i].name,
                double.parse(controllerCheckout.valueCheckout.value),
                controllerCheckout.paymentItems[i].type,
                controllerCheckout.paymentItems[i].balance,
                controllerCheckout.totalCheckout.value));


            List<TaxCart> taxLocal = [];


            var tempValue = double.parse(
                controllerCheckout.valueCheckout.value);
            for (var i = 0; i < controllerCategory.taxes.length; i ++) {
              for (var s = 0; s <
                  controllerCart.controllerCheckboxes.value.selectedItem
                      .length; s ++) {
                if (controllerCategory.taxes[i].id ==
                    controllerCart.controllerCheckboxes.value.selectedItem[s]) {
                  var taxValue = (double.parse(
                      "${controllerCategory.taxes[i].rate}") * tempValue) / 100;

                  if (controllerCategory.taxes[i].type == "INCLUDED") {
                    tempValue = tempValue - taxValue;
                  } else {
                    tempValue = tempValue + taxValue;
                  }


                  taxLocal.add(TaxCart(controllerCategory.taxes[i].id,
                      "${double.parse("${controllerCategory.taxes[i].rate}")}",
                      controllerCategory.taxes[i].name, "${taxValue}",
                      controllerCategory.taxes[i].type));
                }
              }
            }

            controllerCart.taxes.assignAll(taxLocal);


            _panelController.open();
          }

          }: null,
          child: Text(" ${controllerCheckout.paymentItems[i].name}",
              style: TextStyle(color: Colors.white)),
        ),
      ));
    }
    return paymentsLocal;
  }

getvalueCheckout(){
    var retorno="";

    try{
      retorno= formatedNumber("${double.parse(controllerCheckout.valueCheckout.value).toInt()}");
    }catch(e){

    }

    return retorno;
}


  @override
  Widget build(BuildContext context) {
    loadingHud = helpers.initLoading(context);


    List<int> taxesTextValues=[];
    List<String> taxesText=[];

    for(var i = 0; i <controllerCategory.taxes.length; i ++){
      taxesText.add("${controllerCategory.taxes[i].name} ${controllerCategory.taxes[i].rate}%");
      taxesTextValues.add(controllerCategory.taxes[i].id);
    }


    return Scaffold(
      appBar: AppBar(
        title: Text("Cobrar"),
        actions: [
          InkWell(
            onTap: () async{

              Get.to(() => ClientListSearch());
              controllerClient.selectedClient.value=0;
              controllerClient.selectedClientName.value="";

              loadingHud.show();
             await controllerClient.getClients();
              loadingHud.dismiss();

            },
            child: Container(

              padding: EdgeInsets.all(15),
              child: Icon(Icons.person),
            ),
          ),
          GestureDetector(
            onTap: () async {
              controllerCheckout.setPayments();
              var data = await Get.to(Divide());


              if (data != null) {
                controllerCheckout.panelControllerCheckout.value.open();
              }
            },
            child: Container(
              padding: EdgeInsets.only(right: 20.0, top: 20, bottom: 20),

              child: Text("Dividir"),
            ),
          ),
        ],
      ),
      body: SlidingUpPanel(
        backdropTapClosesPanel: true,
        backdropEnabled: true,
        controller: controllerCheckout.panelControllerCheckout.value,
        minHeight: 0,
        panel: Container(
          padding: EdgeInsets.only(left: 20, right: 20),
          child: CashPanel(),
        ),
        body: Container(
          padding: EdgeInsets.only(left: 20, right: 20, top: 20),
          child: Column(
            children: [

              Obx(() =>GestureDetector(
                onTap: (){
                  textContoller.text=formatedNumber("${double.parse(controllerCheckout.valueCheckout.value).toInt()}");
                  controllerCheckout.totalCheckout.value=double.parse(controllerCheckout.valueCheckout.value);
                },
                child:  Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      padding: EdgeInsets.only(
                          left: 20, right: 20, bottom: 10, top: 10),
                      margin: EdgeInsets.only(bottom: 30),
                      decoration: BoxDecoration(
                          color: Color(0xff298dcf).withOpacity(0.9),
                          borderRadius: BorderRadius.circular(20)),
                      child: Text(
                        "\$ ${getvalueCheckout()}",
                        style: TextStyle(color: Colors.white, fontSize: 25),
                      ),
                    ),
                  ],
                ),
              )),
              taxesTextValues.length> 0 ?  Container(
                margin: EdgeInsets.only(top: 15),
                child: Text("Impuestos"),
              ): Container(),
              Container(
                child: SingleChildScrollView(
                  child: SimpleGroupedSwitch<int>(
                    controller: controllerCart.controllerCheckboxes.value,
                    itemsTitle: taxesText,
                    values: taxesTextValues,




                    onItemSelected: (itesm){




                    },

                  ),
                ),
              ),
              Row(
                children: [
                  Expanded(
                      child: TextFormField(
                        controller: textContoller,
                    onChanged: (value) {
                      value= value.replaceAll("\$", "");
                      value= value.replaceAll(" ", "");
                      value= value.replaceAll(".", "");
                      if(value.length>0){

                        controllerCheckout.totalCheckout.value =
                            double.parse("${value}");
                      }

                    },
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      TextInputMask(
                          mask: '\$! !9+.999',
                          placeholder: '0',
                          maxPlaceHolders: 0,
                          reverse: true)
                    ],
                    decoration: InputDecoration(
                        labelText: "Efectivo recibido",
                        hintText: "Escribe el valor a cobrar"),
                    // The validator receives the text that the user has entered.
                    validator: (value) {

                      if (value == null || value.isEmpty) {
                        return 'Por favor ingrese el valor a cobrar';
                      }
                      return null;
                    },
                  ))
                ],
              ),

              Obx(()=>controllerClient.selectedClient.value>0 ? Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(

                    child: Text("Cliente:",style: TextStyle(fontWeight: FontWeight.bold),),
                    margin: EdgeInsets.only(top: 10,bottom: 10),
                  ),
                  Container(
                      child: controllerClient.selectedClient.value>0 ? Row(
                        children: [
                          InkWell(
                            onTap: (){
                              controllerClient.selectedClient.value=0;
                              controllerClient.selectedClientName.value="";
                            },
                            child: Container(
                              padding: EdgeInsets.all(10),
                              child: Icon(Icons.close),
                            ),
                          ),

                          Container(
                            child: Text("${controllerClient.selectedClientName.value}"),
                          )
                        ],
                      ) : Container()
                  )
                ],
              ): Container()),
              Container(
                margin: EdgeInsets.only(top: 30),
                child: Obx(() => controllerCheckout.paymentItems.length > 0 ? Wrap(
                      alignment: WrapAlignment.spaceBetween,
                      direction: Axis.horizontal,
                      children: getPayments(
                          controllerCheckout.panelControllerCheckout.value),
                    ): Container()),
                padding: EdgeInsets.only(left: 20, right: 20),
              ),




            ],
          ),
        ),
      ),
    );
  }
}
