import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:poshop/cart/controllers/CartController.dart';
import 'package:poshop/checkout/controllers/CheckoutController.dart';
import 'package:poshop/home/controllers/HomeController.dart';

class CashPanel extends StatelessWidget{
  CheckoutContoller controllerCheckout = Get.find();
  CartContoller controllerCart=  Get.find();
  HomeContoller controllerHome = Get.find();

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

  totalPaid(){

  }

  List<Widget> getPayments(){

    List<Widget> widgets=[];
    for( var i =0  ; i< controllerCheckout.paymentCheckoutsItems.length ; i ++){

      var balancePaid=controllerCheckout.paymentCheckoutsItems[i].totalPaid.toInt()-controllerCheckout.paymentCheckoutsItems[i].price.toInt();
         widgets.add(Card(
           child: Container(
             padding: EdgeInsets.only(left: 10,right: 10,top: 10,bottom: 10),
             child: Column(
               children: [
                 Container(
                   margin: EdgeInsets.only(bottom: 10),

                   child: Text("${controllerCheckout.paymentCheckoutsItems[i].name}",style: TextStyle(fontSize: 19,fontWeight: FontWeight.bold),),
                 ),
                 Container(
                   child: Row(
                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                     children: [

                       Container(//controllerCheckout.totalCheckout.value
                         child: Column(

                           mainAxisAlignment: MainAxisAlignment.start,
                           crossAxisAlignment: CrossAxisAlignment.start,
                           children: [
                             Container(
                               child: Text("\$ ${formatedNumber("${controllerCheckout.paymentCheckoutsItems[i].price.toInt()}")}",style: TextStyle(fontSize: 19,fontWeight: FontWeight.bold),),
                             ),
                             Container(
                               child: Text("Pagado"),
                             )
                           ],
                         ),
                       ),
                       controllerCheckout.paymentCheckoutsItems[i].type == "CASH" ? Container(
                         child: Column(
                           mainAxisAlignment: MainAxisAlignment.end,
                           crossAxisAlignment: CrossAxisAlignment.end,
                           children: [

                             balancePaid>0 ? Container(
                               child: Text("\$ ${formatedNumber("${balancePaid}")}",style: TextStyle(fontSize: 19,fontWeight: FontWeight.bold),),
                             ) : Container(
                               child: Text("\$ ${formatedNumber("0")}",style: TextStyle(fontSize: 19,fontWeight: FontWeight.bold),),
                             ),
                             Container(
                               child: Text("Cambio"),
                             )

                           ],
                         ),
                       ): Container(),
                     ],
                   ),
                 )],
             ),
           ),
         ));
    }
    return widgets;
  }

  @override
  Widget build(BuildContext context) {


    return Form(
      key: _formKey,

      child: Column(

        children: [
          Obx(()=>Container(
            margin: EdgeInsets.only(top: 10),
            child: Column(
              children: getPayments(),
            ),
          )),
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
                  controllerCheckout.paymentCheckoutsItems.clear();
                  controllerCheckout.valueCheckout.value="";
                  controllerCart.items.clear();
                  controllerHome.isShowPayment.value=false;
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