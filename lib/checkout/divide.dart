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
import 'package:poshop/helpers/widgetsHelper.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

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
  WidgetsHelper helpers = WidgetsHelper();

  CheckoutContoller controllerCheckout = Get.find();
  final formatCurrency = new NumberFormat.simpleCurrency();
  TextEditingController controllerTemp= TextEditingController();
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
        actions: [
          Padding(
              padding: EdgeInsets.only(right: 20.0,top: 20,bottom: 20),
              child: GestureDetector(
                onTap: () async {

                  if(controllerCheckout.balanceCheckout.value.toInt() == 0){
                    Get.back(result: 'success');
                  }else{
                    helpers.defaultAlert(context, "error", "Error al cobrar",
                        "Por favor seleccione los items a cobrar");

                  }

                },
                child: Text("Cobrar",style: TextStyle(fontWeight: FontWeight.bold),),
              )
          ),
        ],
        title: Obx(()=>Text(
            "Restante \$ ${formatedNumber("${controllerCheckout.balanceCheckout.value.toInt()}")}",style: TextStyle(fontSize: 17),),),
      ),
      body: SlidingUpPanel(
        backdropTapClosesPanel: true,
        backdropEnabled: true,
        controller: controllerCheckout.panelControllerDivide.value,
        minHeight: 0,
        panel: Container(
          padding: EdgeInsets.only(left: 20,right: 20,top: 20),
          child: Column(
            children: [
              Container(
                  child:Obx(()=>Text("${controllerCheckout.tempNamePayment.value}",style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),))
              ),
             Container(
               margin: EdgeInsets.only(bottom: 10,top: 25),
               child:  Column(
                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
                 children: [
                   Column(
                     children: [
                       Obx(()=>Text("\$ ${formatedNumber("${controllerCheckout.tempValue.value.toInt()}")}",style: TextStyle(fontSize: 30),)),
                       Text("Importe",style: TextStyle(fontSize: 17),)
                     ],
                   ),

                 ],
               ),
             ),
              Obx(()=>controllerCheckout.tempType.value == "CASH" ? Column(
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 15),
                    child: Column(
                      children: [
                        Obx(()=>Text("\$ ${formatedNumber("${controllerCheckout.tempTotal.value.toInt()}")}",style: TextStyle(fontSize: 30,color: controllerCheckout.tempTotal.value <0 ? Colors.redAccent : Colors.black87),)),
                        Obx(()=>Text("Cambio",style: TextStyle(fontSize: 17,color: controllerCheckout.tempTotal.value <0 ? Colors.redAccent : Colors.black87),))
                      ],
                    ),
                  ),
                  TextFormField(
                    controller: controllerTemp,

                    onChanged: (value){
                      value= value.replaceAll("\$", "");
                      value= value.replaceAll(" ", "");
                      value= value.replaceAll(".", "");


                      if(double.parse(value)>controllerCheckout.tempValue.value){
                        controllerCheckout.tempTotal.value=double.parse(value)-controllerCheckout.tempValue.value;
                      }else{
                        controllerCheckout.tempTotal.value=0;
                      }
                       controllerCheckout.tempBalance.value=double.parse(value);

                      print("este es el value del saldo  ${value}  ${controllerCheckout.tempBalance.value}");

                    },
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      CurrencyTextInputFormatter(
                        locale: 'es',
                        decimalDigits: 0,
                      ),
                    ],
                    decoration: InputDecoration(
                        labelText: "Efectivo recibido",
                        hintText: "Escribe el valor a cobrar"),
                    // The validator receives the text that the user has entered.
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Por favor ingrese un valor';
                      }
                      return null;
                    },
                  ),

                  Obx(()=> Container(

                    margin: EdgeInsets.only(top: 15),
                    child: RaisedButton(
                      padding: EdgeInsets.only(top: 10, bottom: 10),
                      onPressed: controllerCheckout.tempTotal.value>=0 ? () async {


                        controllerCheckout.paymentCheckoutsItems[controllerCheckout.tempId.value].balance=controllerCheckout.tempValue.value;

                        if(controllerCheckout.tempBalance.value==0){
                          controllerCheckout.paymentCheckoutsItems[controllerCheckout.tempId.value].totalPaid=double.parse(controllerTemp.text);

                        }else{
                          controllerCheckout.paymentCheckoutsItems[controllerCheckout.tempId.value].totalPaid=controllerCheckout.tempBalance.value;

                        }

                        print("saquiii esta lo que pago  ${controllerCheckout.tempTotal.value} ${controllerCheckout.tempTotal.value}");


                        controllerCheckout.paymentCheckoutsItems.refresh();
                        controllerCheckout.recalculateBalance();

                        controllerCheckout.panelControllerDivide.value.close();

                      }: null,

                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                      color: Color(0xff298dcf),
                      child: Text(
                        "Cobrar",
                        style: TextStyle(color: Colors.white, fontSize: 17),
                      ),
                    ),
                  ))
                ],
              ) : Container(
                child:Container(

                  margin: EdgeInsets.only(top: 15),
                  child: RaisedButton(
                    padding: EdgeInsets.only(top: 10, bottom: 10),
                    onPressed: controllerCheckout.tempTotal.value>0 ? () async {
                      controllerCheckout.paymentCheckoutsItems[controllerCheckout.tempId.value].balance=controllerCheckout.tempTotal.value;
                      controllerCheckout.paymentCheckoutsItems[controllerCheckout.tempId.value].totalPaid=controllerCheckout.tempTotal.value;

                      controllerCheckout.paymentCheckoutsItems.refresh();
                      controllerCheckout.recalculateBalance();

                      controllerCheckout.panelControllerDivide.value.close();

                    }: null,

                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                    color: Color(0xff298dcf),
                    child: Text(
                      "Cobrar",
                      style: TextStyle(color: Colors.white, fontSize: 17),
                    ),
                  ),
                ),
              ))
            ],
          ),
        ),
        body:  Column(
          children: [
            Container(
              margin: EdgeInsets.only(top: 30,bottom: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Obx(()=>controllerCheckout.balanceCheckout.value.toInt() > 0 ? InkWell(
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
                  ) : Container()),
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
                  Obx(()=>controllerCheckout.balanceCheckout.value.toInt() > 0  ? InkWell(
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
                  ) : Container()),
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
                          controllerCheckout.paymentCheckoutsItems.length>1 ? InkWell(
                            child: Container(
                              child: Icon(Icons.delete,color: Colors.redAccent,),
                            ),
                            onTap: (){
                              controllerCheckout.paymentCheckoutsItems.removeAt(index);
                              controllerCheckout.paymentCheckoutsItems.refresh();
                              controllerCheckout.recalculatePayments();
                              controllerCheckout.recalculateBalance();

                            },
                          ): Container(),

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
                                          controllerCheckout.paymentCheckoutsItems[index].type=controllerCheckout.paymentItems[o].type;
                                          controllerCheckout.tempType.value=controllerCheckout.paymentItems[o].type;

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

                                     //controllerCheckout.paymentCheckoutsItems.refresh();


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

                          Obx(()=>controllerCheckout.paymentCheckoutsItems[index].balance == 0 ? Container(

                            child: RaisedButton(
                              padding: EdgeInsets.only(top: 10, bottom: 10),
                              onPressed: () async {

                                controllerCheckout.tempBalance.value=0;
                                controllerCheckout.tempValue.value=controllerCheckout.paymentCheckoutsItems[index].price;
                                controllerCheckout.tempTotal.value=0;

                                controllerCheckout.tempType.value=controllerCheckout.paymentCheckoutsItems[index].type;
                                controllerCheckout.tempNamePayment.value=controllerCheckout.paymentCheckoutsItems[index].name;


                                controllerCheckout.tempId.value=index;

                                if(controllerCheckout.tempType.value!="CASH"){
                                  controllerCheckout.tempTotal.value=controllerCheckout.tempValue.value;
                                }

                                controllerTemp.text=formatedNumber('${controllerCheckout.tempValue.value.toInt()}');
                                print("este es el type ${controllerCheckout.tempType.value}");

                                controllerCheckout.panelControllerDivide.value.open();

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
                          ) : Container()
                          )

                        ],
                      ),
                    ),
                  ));
                }))
            ),

          ],
        ) ,
      ),
    );
  }
}
