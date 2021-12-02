import 'package:checkbox_grouped/checkbox_grouped.dart';
import 'package:easy_mask/easy_mask.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:masonry_grid/masonry_grid.dart';
import 'package:poshop/cart/controllers/CartController.dart';
import 'package:poshop/cart/model/Cart.dart';
import 'package:poshop/checkout/checkout.dart';
import 'package:poshop/checkout/controllers/CheckoutController.dart';
import 'package:poshop/discounts/controllers/DiscountContoller.dart';
import 'package:poshop/home/controllers/DiscountHomeController.dart';

import 'package:poshop/home/controllers/HomeController.dart';
import 'package:poshop/home/model/DiscountCart.dart';
import 'package:poshop/products/controllers/ProductContoller.dart';
import 'package:poshop/products/model/Product.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

class SingleCart extends StatelessWidget {
  int indexItem;
  SingleCart(this.indexItem);
  CartContoller controlelrCart =Get.find();

  TextEditingController priceController=TextEditingController();
  GroupController controller;
  DiscountContoller controllerDiscount = Get.find();
  DiscountHomeController controllerDiscountHome = Get.put(DiscountHomeController());


  formatedNumber(number) {
    var formatCurrency;
    formatCurrency = new NumberFormat.currency(
        customPattern: "\u00A4#,##0\u00A0",
        symbol: "",
        decimalDigits: 0,
        locale: "es");

    return formatCurrency.format(number);
  }

  @override
  Widget build(BuildContext context) {

    var item=controlelrCart.items[indexItem];

    controllerDiscountHome.getItemsDiscounts();

    priceController.text="\$ ${formatedNumber(item.product.salesPrice)}";

    List<String> itemsText=[];
    List<int> itemsTextValues=[];

    for(var i = 0; i <controllerDiscount.discounts.length; i ++){
      itemsText.add("${controllerDiscount.discounts[i].name}  ${controllerDiscount.discounts[i].value} ${controllerDiscount.discounts[i].calculationType == "PERCENT" ? '%' : ''}");
      itemsTextValues.add(controllerDiscount.discounts[i].id);
    }



    return Scaffold(
      bottomNavigationBar: Container(
        padding: EdgeInsets.all(20),
        child: RaisedButton(
          padding: EdgeInsets.only(top: 15, bottom: 15),
          onPressed: () async {

          //  try{



            if(controllerDiscountHome.controller.selectedItem!=null){
              List<DiscountCart> discountLocal=[];

              for(var i = 0; i <controllerDiscount.discounts.length; i ++){
                for(var s = 0; s <controllerDiscountHome.controller.selectedItem.length; s ++){
                  if(controllerDiscount.discounts[i].id==controllerDiscountHome.controller.selectedItem[s]){


                    if(controllerDiscount.discounts[i].calculationType=="AMOUNT"){
                      discountLocal.add(DiscountCart(controllerDiscount.discounts[i].id, "${double.parse(controllerDiscount.discounts[i].value).toInt()}"));

                    }else{
                      var valueDiscount=(item.product.salesPrice*double.parse(controllerDiscount.discounts[i].value))/100;
                      discountLocal.add(DiscountCart(controllerDiscount.discounts[i].id, "${valueDiscount.toInt()}"));
                    }
                  }
                }
              }
              controlelrCart.items[indexItem].discount=discountLocal;
              controlelrCart.items.refresh();
              print("selected    ${discountLocal}  item${item.product.salesPrice}");

            }
            //}catch(e){
             // print("aquiii la e ${e}");
           // }
            Navigator.pop(context);
            FocusScope.of(context).unfocus();

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
      ),
      appBar: AppBar(
        title: Text("${item.product.itemNme}"),
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        child: Column(
          children: <Widget>[
            TextFormField(
              keyboardType: TextInputType.number,

              controller:priceController ,
              inputFormatters: [
                TextInputMask(
                    mask: '\$! !9+.999',
                    placeholder: '0',
                    maxPlaceHolders: 0,
                    reverse: true)
              ],
              decoration: InputDecoration(
                labelText: 'Precio',
              ),
              onChanged: (value){
                value= value.replaceAll("\$", "");
                value= value.replaceAll(" ", "");
                value= value.replaceAll(".", "");
                value= value.replaceAll(",", "");

                print("este ess el valuee  ${value}");

                controlelrCart.items[indexItem].product.salesPrice=int.parse(value);
                controlelrCart.items.refresh();

              },

            ),
            TextFormField(
              keyboardType: TextInputType.number,

              initialValue: "${item.numberItem}",
              decoration: InputDecoration(
                labelText: 'Cantidad',
              ),
              onChanged: (value){
                controlelrCart.items[indexItem].numberItem=int.parse(value);
                controlelrCart.items.refresh();

                print(controlelrCart.items[indexItem]);

              },
            ),
            TextFormField(
              initialValue: "${item.comment!= null  ? item.comment: ''}",
              onChanged: (value){
                controlelrCart.items[indexItem].comment=value;
              },

              decoration: InputDecoration(
                labelText: 'Comentarios',
              ),
            ),

            itemsTextValues.length> 0 ?  Container(
              margin: EdgeInsets.only(top: 15),
              child: Text("Descuentos"),
            ): Container(),


            Container(
               child: SingleChildScrollView(
                child: SimpleGroupedSwitch<int>(
                  controller: controllerDiscountHome.controller,
                   itemsTitle: itemsText,
                  values: itemsTextValues,


                  onItemSelected: (itesm){
                    print("aquii los items  ${itesm}");
                  },

                ),
              ),
            ),


          ],
        ),
      ),
    );
  }
}


