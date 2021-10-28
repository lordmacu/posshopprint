import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:poshop/cart/controllers/CartController.dart';
import 'package:poshop/checkout/card.dart';
import 'package:poshop/checkout/cash.dart';
import 'package:poshop/checkout/controllers/CheckoutController.dart';
import 'package:poshop/checkout/divide.dart';
import 'package:poshop/checkout/models/Payment.dart';
import 'package:poshop/helpers/MoneyTextInputFormatted.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';


class Checkout extends StatelessWidget{
  CheckoutContoller controllerCheckout = Get.find();
  CartContoller controllerCart = Get.find();

  final CurrencyTextInputFormatter _formatter = CurrencyTextInputFormatter();

  formatedNumber(number) {

    number = number.replaceAll(".", "");


    var numberText= int.parse(number);
    var formatCurrency;
    formatCurrency = new NumberFormat.currency(
        customPattern: "\u00A4#,##0.00\u00A0",
        symbol: "",
        decimalDigits: 0,
        locale: "es");

    return formatCurrency.format(numberText);
  }

  List<Widget> getPayments(_panelController){

    List<Widget> paymentsLocal=[];
        for( var i =0  ; i< controllerCheckout.paymentItems.length ; i ++){
          paymentsLocal.add(Container(
            padding: EdgeInsets.only(left: 5,right: 5),
            child: RaisedButton(
              shape: new RoundedRectangleBorder(
                borderRadius: new BorderRadius.circular(30.0),
              ),
              color:Color(0xff298dcf) ,

              onPressed: (){

                controllerCheckout.typePayment.value=2;
                controllerCheckout.paymentCheckoutsItems.clear();
                controllerCheckout.paymentCheckoutsItems.add(Payment(controllerCheckout.paymentItems[i].id, controllerCheckout.paymentItems[i].name, double.parse(controllerCheckout.valueCheckout.value)));

                _panelController.open();
              },
              child: Text(" ${controllerCheckout.paymentItems[i].name}",style: TextStyle(color: Colors.white)),
            ),
          ));
        }
    return paymentsLocal;
  }

  @override
  Widget build(BuildContext context) {
    PanelController _panelController = PanelController();

    return Scaffold(
      appBar: AppBar(
        title: Text("Cobrar"),
        actions: [
          Padding(
              padding: EdgeInsets.only(right: 20.0,top: 20,bottom: 20),
              child: GestureDetector(
                onTap: () async {
                  controllerCheckout.setPayments();
                  var data = await Get.to(Divide());
                  _panelController.open();

                },
                child: Text("Dividir"),
              )
          ),
        ],
      ),

      body: SlidingUpPanel(
        backdropTapClosesPanel: true,
        backdropEnabled: true,
        controller: _panelController,
         minHeight: 0,
        panel: Container(
          padding: EdgeInsets.only(left: 20,right: 20),
          child:  CashPanel(),
        ),
        body: Container(

          padding: EdgeInsets.only(left: 20,right: 20,top: 20),
          child:Column(


            children: [
              Obx(()=>Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    padding: EdgeInsets.only(left: 20,right: 20,bottom: 10,top: 10),
                    margin: EdgeInsets.only(bottom: 30),
                    decoration: BoxDecoration(
                        color: Color(
                            0xff298dcf).withOpacity(0.9),
                        borderRadius: BorderRadius.circular(20)
                    ),
                    child: Text("\$ ${formatedNumber(controllerCheckout.valueCheckout.value)}",style: TextStyle(color: Colors.white,fontSize: 25),),
                  ),
                ],
              )),
              Row(
                children: [
                  Expanded(child: TextFormField(
                    onChanged: (value){

                      controllerCheckout.totalCheckout.value=int.parse("${value}");
                    },
                    keyboardType: TextInputType.number,
                    inputFormatters: [

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

                child: Obx(()=>Wrap(
                  alignment: WrapAlignment.spaceBetween,
                  direction: Axis.horizontal,


                  children:getPayments(_panelController),
                )),
                padding: EdgeInsets.only(left: 20,right: 20),
              )
            ],
          ),
        ),
      ),
    );
  }

}