import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:poshop/checkout/card.dart';
import 'package:poshop/checkout/cash.dart';
import 'package:poshop/checkout/controllers/CheckoutController.dart';
import 'package:poshop/helpers/MoneyTextInputFormatted.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';


class Checkout extends StatelessWidget{
  CheckoutContoller controllerCheckout = Get.find();

  final CurrencyTextInputFormatter _formatter = CurrencyTextInputFormatter();

  formatedNumber(number) {
    var numberText= int.parse(number);
    var formatCurrency;
    formatCurrency = new NumberFormat.currency(
        customPattern: "\u00A4#,##0.00\u00A0",
        symbol: "",
        decimalDigits: 0,
        locale: "es");

    return formatCurrency.format(numberText);
  }

  @override
  Widget build(BuildContext context) {
    PanelController _panelController = PanelController();

    return Scaffold(
      appBar: AppBar(
        title: Text("Cobrar"),
      ),

      body: SlidingUpPanel(
        backdropTapClosesPanel: true,
        backdropEnabled: true,
        controller: _panelController,
         minHeight: 0,
        panel: Container(
          padding: EdgeInsets.only(left: 20,right: 20),
          child:  Obx(()=>Column(
            children: [
              controllerCheckout.typePayment.value == 1 ? CashPanel() : CardPanel(),
              Container(
                margin: EdgeInsets.only(top: 40),
                child: RaisedButton(
                  shape: new RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(30.0),
                  ),
                  color:Color(0xff298dcf) ,

                  onPressed: (){

                    Get.back(result: 'success');

                  },
                  child:Text("Nueva Venta",style: TextStyle(color: Colors.white)),
                ),
              )
            ],
          )),
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

                      controllerCheckout.valueCheckout.value="${value}";
                    },
                    keyboardType: TextInputType.number,

                    inputFormatters: [
                      CurrencyTextInputFormatter()
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

                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    RaisedButton(
                      shape: new RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(30.0),
                      ),
                      color:Color(0xff298dcf) ,

                      onPressed: (){

                        controllerCheckout.typePayment.value=1;
                        _panelController.open();
                      },
                      child: Row(
                        children: [
                          Container(

                            child: Icon(Icons.money,color: Colors.white,),
                            margin: EdgeInsets.only(right: 10),
                          ),
                          Text("Efectivo",style: TextStyle(color: Colors.white))
                        ],
                      ),
                    ),
                    RaisedButton(
                      shape: new RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(30.0),
                      ),
                      color:Color(0xff298dcf) ,

                      onPressed: (){
                        controllerCheckout.typePayment.value=2;

                        _panelController.open();

                      },
                      child: Row(
                        children: [
                          Container(

                            child: Icon(Icons.credit_card,color: Colors.white,),
                            margin: EdgeInsets.only(right: 10),
                          ),
                          Text("Tarjeta",style: TextStyle(color: Colors.white))
                        ],
                      ),
                    )
                  ],
                ),
                padding: EdgeInsets.only(left: 20,right: 20),
              )


            ],
          ),
        ),
      ),
    );
  }

}