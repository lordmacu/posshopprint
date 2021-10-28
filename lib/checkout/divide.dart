import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:poshop/cart/controllers/CartController.dart';
import 'package:poshop/checkout/controllers/CheckoutController.dart';
import 'package:easy_mask/easy_mask.dart';
import 'package:intl/intl.dart';
import 'package:flutter/services.dart';

class CurrencyPtBrInputFormatter extends TextInputFormatter {


  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    if(newValue.selection.baseOffset == 0){
      return newValue;
    }

    double value = double.parse(newValue.text);
    final formatter = new NumberFormat.currency(
        customPattern: "\u00A4#,##0.00\u00A0",
        symbol: "",
        decimalDigits: 0,
        locale: "es");
    String newText = "\$ " + formatter.format(value/100);

    return newValue.copyWith(
        text: newText,
        selection: new TextSelection.collapsed(offset: newText.length));
  }
}

class Divide extends StatelessWidget {
  CheckoutContoller controllerCheckout = Get.find();
  final formatCurrency = new NumberFormat.simpleCurrency();
  final CurrencyTextInputFormatter _formatter = CurrencyTextInputFormatter(
    locale: 'es',
    decimalDigits: 0,
  );
  formatedNumber(number) {
    number = number.replaceAll(".", "");

    var numberText = int.parse(number);
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
    return Scaffold(
      appBar: AppBar(
        title: Text(
            "Restante \$ ${formatedNumber(controllerCheckout.valueCheckout.value)}"),
      ),
      body: Column(
        children: [
          Container(
            margin: EdgeInsets.only(top: 30,bottom: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                InkWell(
                  onTap: (){
                    if(controllerCheckout.paymentCheckoutsItems.length>1){
                      controllerCheckout.removePayment();

                    }
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.grey,
                        ),
                        borderRadius: BorderRadius.circular(
                            100) // use instead of BorderRadius.all(Radius.circular(20))
                        ),
                    child: Icon(
                      Icons.remove,
                      size: 50,
                    ),
                  ),
                ),
                Container(
                  child: Column(
                    children: [
                      Obx(()=>Text(
                        "${controllerCheckout.paymentCheckoutsItems.length}",
                        style: TextStyle(
                            fontSize: 35, fontWeight: FontWeight.bold),
                      )),
                      Container(
                        child: Text("Pagos"),
                      )
                    ],
                  ),
                ),
                InkWell(
                  onTap: (){
                    controllerCheckout.addPayment();
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.grey,
                        ),
                        borderRadius: BorderRadius.circular(
                            100) // use instead of BorderRadius.all(Radius.circular(20))
                        ),
                    child: Icon(
                      Icons.add,
                      size: 50,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
              child: Obx(()=>ListView.builder(
                  itemCount: controllerCheckout.paymentCheckoutsItems.length, itemBuilder: (context, index) {

                    List<String> itemsLocal=[];
                    for(var i = 0 ; i< controllerCheckout.paymentItems.length ; i++){
                      itemsLocal.add(controllerCheckout.paymentItems[i].name);

                    }
                    print("aquiii esta la cantidad mano  ${itemsLocal}");
                    TextEditingController _controller = TextEditingController(text: "${controllerCheckout.paymentCheckoutsItems[index].price}");



                    return Obx(()=>Card(
                      child: Container(
                        margin: EdgeInsets.only(bottom: 20),
                        padding: EdgeInsets.only(left: 10,right: 10),
                        child: Row(
                          children: [

                            Expanded(child: Container(
                              margin: EdgeInsets.only(left: 15,right: 15),

                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [

                                  Container(

                                    child: DropdownButton<String>(
                                      focusColor:Colors.white,
                                      value: controllerCheckout.paymentCheckoutsItems[index].name,
                                      //elevation: 5,
                                      style: TextStyle(color: Colors.white),
                                      iconEnabledColor:Colors.black,
                                      items: itemsLocal.map((String value) {
                                        return DropdownMenuItem<String>(
                                          value: value,
                                          child: Text(value,style:TextStyle(color:Colors.black),),
                                        );
                                      }).toList(),
                                      hint:Text(
                                        "Seleccione método",
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500),
                                      ),
                                      onChanged: (String value) {


                                        for(var o =0 ; o< controllerCheckout.paymentItems.length ; o ++){
                                          if(controllerCheckout.paymentItems[o].name == value){
                                            controllerCheckout.paymentCheckoutsItems[index].id=controllerCheckout.paymentItems[o].id;
                                            controllerCheckout.paymentCheckoutsItems[index].name=controllerCheckout.paymentItems[o].name;
                                          }
                                        }
                                        controllerCheckout.paymentCheckoutsItems.refresh();

                                      },
                                    ),
                                  ),

                                  Container(
                                     child: TextFormField(
                                      inputFormatters: [
                                        CurrencyTextInputFormatter(
                                          locale: 'es',
                                          decimalDigits: 0,
                                        ),
                                      ],
                                      onChanged: (value){

                                        value= value.replaceAll("\$", "");
                                        value= value.replaceAll(" ", "");
                                        value= value.replaceAll(".", "");

                                        controllerCheckout.paymentCheckoutsItems[index].price=double.parse(value);
                                        controllerCheckout.update();

                                        controllerCheckout.paymentCheckoutsItems.refresh();


                                      },
                                      controller: TextEditingController()..text = formatedNumber('${controllerCheckout.paymentCheckoutsItems[index].price.toInt()}'),

                                      keyboardType: TextInputType.number,
                                      decoration: InputDecoration(
                                          labelText: "Precio",
                                          hintText: "Escribe el precio"),
                                      // The validator receives the text that the user has entered.
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Please enter some text';
                                        }
                                        return null;
                                      },
                                    ),
                                  )
                                ],
                              ),
                            )),
                            controllerCheckout.paymentCheckoutsItems.length>1 ? InkWell(
                              child: Container(
                                child: Icon(Icons.delete,color: Colors.redAccent,),
                              ),
                              onTap: (){
                                controllerCheckout.paymentCheckoutsItems.removeAt(index);
                                controllerCheckout.paymentCheckoutsItems.refresh();
                                controllerCheckout.recalculatePayments();

                              },
                            ): Container(),
                           /* Container(

                              child: RaisedButton(
                                padding: EdgeInsets.only(top: 10, bottom: 10),
                                onPressed: () async {

                                },

                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30.0),
                                ),
                                color: Color(0xff298dcf),
                                child: Text(
                                  "Cobrar",
                                  style: TextStyle(color: Colors.white, fontSize: 17),
                                ),
                              ),
                            )*/

                          ],
                        ),
                      ),
                    ));
              }))
          ),
          Container(
            padding: EdgeInsets.only(left: 20,right: 20,bottom: 10),
            width: double.infinity,
            child: RaisedButton(
              shape: new RoundedRectangleBorder(
                borderRadius: new BorderRadius.circular(30.0),
              ),
              color:Color(0xff298dcf) ,

              onPressed: (){

                Get.back(result: 'success');


              },
              child:Text("Cobrar",style: TextStyle(color: Colors.white)),
            ),
          )
        ],
      ),
    );
  }
}
