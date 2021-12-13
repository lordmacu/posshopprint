import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:poshop/cart/controllers/CartController.dart';
import 'package:poshop/categories/controllers/CategoryController.dart';
import 'package:poshop/checkout/card.dart';
import 'package:poshop/checkout/cash.dart';
import 'package:poshop/checkout/controllers/CheckoutController.dart';
import 'package:poshop/checkout/divide.dart';
import 'package:poshop/checkout/models/Payment.dart';
import 'package:poshop/helpers/MoneyTextInputFormatted.dart';
import 'package:poshop/home/model/TaxCart.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:checkbox_grouped/checkbox_grouped.dart';

class Checkout extends StatelessWidget {
  CheckoutContoller controllerCheckout = Get.find();
  CartContoller controllerCart = Get.find();
  TextEditingController textContoller= TextEditingController();

  final CurrencyTextInputFormatter _formatter = CurrencyTextInputFormatter();
  CategoryContoller controllerCategory = Get.find();

  formatedNumber(number) {

    try{
    number = number.replaceAll(".", "");

    var numberText = int.parse(number);
    var formatCurrency;
    formatCurrency = new NumberFormat.currency(
        customPattern: "\u00A4#,##0.00\u00A0",
        symbol: "",
        decimalDigits: 0,
        locale: "es");

    return formatCurrency.format(numberText);
    }catch(e){
      print("aquiiifallo el numero  ${number}");
    }
  }

  canPressPayment(){




    if(controllerCheckout.valueCheckout.value!=""){
      return controllerCheckout.totalCheckout.value>= double.parse (controllerCheckout.valueCheckout.value);
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



  @override
  Widget build(BuildContext context) {

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
          Padding(
              padding: EdgeInsets.only(right: 20.0, top: 20, bottom: 20),
              child: GestureDetector(
                onTap: () async {
                  controllerCheckout.setPayments();
                  var data = await Get.to(Divide());

                  print("este es el data ${data}");

                  if (data != null) {
                    controllerCheckout.panelControllerCheckout.value.open();
                  }
                },
                child: Text("Dividir"),
              )),
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
                  textContoller.text=formatedNumber(controllerCheckout.valueCheckout.value);
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
                        "\$ ${formatedNumber(controllerCheckout.valueCheckout.value)}",
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
                      print("aquii los items  ${itesm} ");



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
                      value= value.replaceAll(",", "");

                      print("este es el valor arreglado ${value}");
                      controllerCheckout.totalCheckout.value =
                          double.parse("${value}");
                    },
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      /*CurrencyTextInputFormatter(

                        decimalDigits: 0,
                          locale: 'en_US', name: '\$'
                      ),*/
                    ],
                    decoration: InputDecoration(
                        labelText: "Efectivo recibido",
                        hintText: "Escribe el valor a cobrar"),
                    // The validator receives the text that the user has entered.
                    validator: (value) {

                      if (value == null || value.isEmpty) {
                        return 'Please enter some text';
                      }
                      return null;
                    },
                  ))
                ],
              ),
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
