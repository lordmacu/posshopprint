import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:poshop/cart/controllers/CartController.dart';
import 'package:poshop/checkout/controllers/CheckoutController.dart';

class CashPanel extends StatelessWidget{
  CheckoutContoller controllerCheckout = Get.find();
  CartContoller controllerCart=  Get.find();

  final _formKey = GlobalKey<FormState>();

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

  bool isEmail(String em) {

    String p = r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';

    RegExp regExp = new RegExp(p);

    return regExp.hasMatch(em);
  }

  @override
  Widget build(BuildContext context) {


    return Form(
      key: _formKey,

      child: Column(

        children: [
          Container(
            margin: EdgeInsets.only(top: 20),
            child: Text("Efectivo",style:TextStyle(fontSize: 25,fontWeight: FontWeight.bold),),
          ),
          Container(
            margin: EdgeInsets.only(top: 30),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        child: Text("\$ ${formatedNumber(controllerCheckout.valueCheckout.value)}",style: TextStyle(fontSize: 23,fontWeight: FontWeight.bold),),
                      ),
                      Container(
                        child: Text("Total pagado"),
                      )
                    ],
                  ),
                ),
                Container(//controllerCheckout.totalCheckout.value
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Container(
                        child: Text("\$ ${formatedNumber("${controllerCheckout.totalCheckout.value}")}",style: TextStyle(fontSize: 23,fontWeight: FontWeight.bold),),
                      ),
                      Container(
                        child: Text("Total pagado"),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 20),
            child: Row(
              children: [
                Expanded(child: TextFormField(

                  onChanged: (value){
                    controllerCheckout.email.value=value;

                  },

                  keyboardType: TextInputType.emailAddress,



                  decoration: InputDecoration(
                      prefixIcon: Icon(Icons.email),
                      labelText: "Email",
                      hintText: "Escribe el email"),
                  // The validator receives the text that the user has entered.
                  validator: (value) {
                    if (value == null || !isEmail(value)) {
                      return 'Ingrese un email válido';
                    }
                    return null;
                  },
                ))
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 40),
            child: RaisedButton(
              shape: new RoundedRectangleBorder(
                borderRadius: new BorderRadius.circular(30.0),
              ),
              color:Color(0xff298dcf) ,

              onPressed: (){

                if (_formKey.currentState.validate()) {
                  controllerCart.setTickets();
                  Get.back(result: 'success');
                }
              },
              child:Text("Nueva Venta",style: TextStyle(color: Colors.white)),
            ),
          )

        ],
      ),
    );
  }

}