import 'package:checkbox_grouped/checkbox_grouped.dart';
import 'package:easy_mask/easy_mask.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:masonry_grid/masonry_grid.dart';
import 'package:poshop/cart/controllers/CartController.dart';
import 'package:poshop/cart/model/Cart.dart';
import 'package:poshop/checkout/checkout.dart';
import 'package:poshop/checkout/controllers/CheckoutController.dart';
import 'package:poshop/discounts/controllers/DiscountContoller.dart';

import 'package:poshop/home/controllers/HomeController.dart';
import 'package:poshop/home/singleCart.dart';
import 'package:poshop/products/controllers/ProductContoller.dart';
import 'package:poshop/products/model/Product.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

class Products extends StatelessWidget {
  HomeContoller controllerHome = Get.find();
  ProductsContoller controllerProduct = Get.find();
  CartContoller controlelrCart =Get.find();
  CheckoutContoller controllerCheckout = Get.find();


  Cart checkItemCart(Product product) {
    Cart isInCart = null;
    var items = controlelrCart.items;
    for (var i = 0; i < items.length; i++) {
      if (items[i].product.id == product.id) {
        isInCart = items[i];
      }
    }

    return isInCart;
  }

  Cart addEmptyCart(product) {
    Cart cartItem = Cart();
    cartItem.product =
        product;
    cartItem.numberItem = 0;
    controlelrCart.items
        .add(cartItem);
    return cartItem;
  }

  int checkItemCartIndex(Product product) {
    int isInCart = 0;
    var items = controlelrCart.items;
    for (var i = 0; i < items.length; i++) {
      if (items[i].product.id == product.id) {
        isInCart = i;
      }
    }

    return isInCart;
  }

  showCart(context,index) async{
    controlelrCart.indexSingleCart.value=index;
    var data = await Get.to(SingleCart(index));


  }

  formatedNumber(number) {
    var formatCurrency;
    formatCurrency = new NumberFormat.currency(
        customPattern: "\u00A4#,##0.00\u00A0",
        symbol: "",
        decimalDigits: 0,
        locale: "es");

    return formatCurrency.format(number);
  }


  getShape(shape){
    if(shape=="SUN"){
        return "star";
    }
    if(shape=="SQUARE"){
      return "square";
    }
    if(shape=="CIRCLE"){
      return "circle";
    }
    if(shape=="HEXAGON"){
      return "pentagon";
    }
  }

  @override
  Widget build(BuildContext context) {



    return Expanded(
        child: Stack(
      children: [



        Container(

            padding: EdgeInsets.only(left: 20, right: 20, top: 15),
            child: Obx(() => controllerHome.itemScrollController.value!=null ? ListView.builder(


              padding: EdgeInsets.only(bottom: 100),
                  itemCount: controllerProduct.products.length,
                  itemBuilder: (context, index) {
                    Product product = controllerProduct.products[index];

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
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Container(
                                    height: 80,
                                    child: product.image!= null ? Image.network(
                                      product.image,
                                      fit: BoxFit.cover,
                                    ): Container(
                                      width: 70,
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Image.asset("assets/${getShape(product.shape)}.png"),
                                          Container(
                                            margin: EdgeInsets.only(top: 5),
                                            child: null,
                                            height: 5,
                                            width: 70,
                                            color: Color(int.parse("0xff${product.color.replaceAll("#", "")}")),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                      child: Container(
                                        padding: EdgeInsets.only(left: 20),
                                        child: Column(
                                          mainAxisSize: MainAxisSize.max,
                                          mainAxisAlignment:
                                          MainAxisAlignment.start,
                                          crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                              child: Text(
                                                "${product.itemNme}",
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 17),
                                              ),
                                            ),
                                            Container(
                                              child: Text(
                                                product.category != null ? product.category.name : "Sin Categoría",
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 14,
                                                    color: Colors.grey
                                                        .withOpacity(0.6)),
                                              ),
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                              MainAxisAlignment.start,
                                              mainAxisSize: MainAxisSize.max,
                                              children: [
                                                Container(
                                                  margin: EdgeInsets.only(top: 10),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                    crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                    children: [
                                                      Container(
                                                        child: Text(
                                                          "\$",
                                                          style: TextStyle(
                                                              fontWeight:
                                                              FontWeight.bold,
                                                              fontSize: 15,
                                                              color: Colors.grey
                                                                  .withOpacity(
                                                                  0.9)),
                                                        ),
                                                        margin: EdgeInsets.only(
                                                            right: 3),
                                                      ),
                                                      Text(
                                                        "${formatedNumber(product.salesPrice)}",
                                                        style: TextStyle(
                                                            fontWeight:
                                                            FontWeight.bold,
                                                            fontSize: 17),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                            product.divisible != 0  ?  Row(
                                              mainAxisAlignment:
                                              MainAxisAlignment.end,
                                              children: [
                                                Container(
                                                  padding: EdgeInsets.only(
                                                      left: 4,
                                                      right: 4,
                                                      top: 2,
                                                      bottom: 2),
                                                  margin: EdgeInsets.only(top: 5),
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(30)),
                                                      color: Colors.grey
                                                          .withOpacity(0.2)),
                                                  width: 90,
                                                  child: Row(
                                                    mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                    children: [
                                                      InkWell(
                                                        child: Container(
                                                          child: Icon(
                                                            Icons.remove,
                                                            color: Colors.white,
                                                            size: 20,
                                                          ),
                                                          decoration: BoxDecoration(
                                                              color: Color(
                                                                  0xff298dcf)
                                                                  .withOpacity(0.8),
                                                              borderRadius:
                                                              BorderRadius.all(
                                                                  Radius
                                                                      .circular(
                                                                      50))),
                                                        ),
                                                        onTap: () {
                                                          Cart isInCart =
                                                          checkItemCart(
                                                              product);

                                                          if (isInCart == null) {

                                                            isInCart = addEmptyCart(product);
                                                          }
                                                          if (isInCart.numberItem >
                                                              0) {
                                                            isInCart.numberItem =
                                                                isInCart.numberItem -
                                                                    1;

                                                            int cartIndex =
                                                            checkItemCartIndex(
                                                                product);

                                                            controlelrCart.items[
                                                            cartIndex] = isInCart;


                                                          }

                                                          if (isInCart.numberItem == 0) {

                                                            int cartIndex =
                                                            checkItemCartIndex(
                                                                product);
                                                            controlelrCart.items.removeAt(cartIndex);
                                                          }


                                                        },
                                                      ),
                                                      Container(child: Obx(() {
                                                        Cart isInCart =
                                                        checkItemCart(product);

                                                        if (isInCart == null) {
                                                          return Text(
                                                            "0",
                                                            style: TextStyle(
                                                                fontSize: 20),
                                                          );
                                                        } else {
                                                          int cartIndex =
                                                          checkItemCartIndex(
                                                              product);

                                                          return Text(
                                                            "${controlelrCart.items[cartIndex].numberItem.toInt()}",
                                                            style: TextStyle(
                                                                fontSize: 20),
                                                          );
                                                        }
                                                      })),
                                                      InkWell(
                                                        onTap: () {
                                                          controlelrCart.addItemCart(product);
                                                        },
                                                        child: Container(
                                                          child: Icon(
                                                            Icons.add,
                                                            color: Colors.white,
                                                            size: 20,
                                                          ),
                                                          decoration: BoxDecoration(
                                                              color: Color(
                                                                  0xff298dcf)
                                                                  .withOpacity(0.8),
                                                              borderRadius:
                                                              BorderRadius.all(
                                                                  Radius
                                                                      .circular(
                                                                      50))),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                )
                                              ],
                                            ) : Row(
                                              mainAxisAlignment:
                                              MainAxisAlignment.end,
                                              children: [
                                                Container(
                                                  child: RaisedButton(

                                                    shape: RoundedRectangleBorder(
                                                      borderRadius: BorderRadius.circular(30.0),
                                                    ),
                                                    color: Color(0xff298dcf),
                                                    child: Text("Agregar",style: TextStyle(color: Colors.white),),
                                                    onPressed: (){

                                                      TextEditingController controllerPrice= TextEditingController();

                                                      Alert(
                                                          context: context,
                                                          title: "Peso",
                                                          content: Column(
                                                            children: <Widget>[
                                                              TextFormField(


                                                                keyboardType: TextInputType.numberWithOptions(decimal: true),

                                                                inputFormatters: [
                                                                  FilteringTextInputFormatter.allow(RegExp(r"[0-9.]")),
                                                                  TextInputFormatter.withFunction((oldValue, newValue) {
                                                                    try {
                                                                      final text = newValue.text;
                                                                      if (text.isNotEmpty) double.parse(text);
                                                                      return newValue;
                                                                    } catch (e) {}
                                                                    return oldValue;
                                                                  }),
                                                                ],
                                                                controller: controllerPrice,

                                                              )
                                                            ],
                                                          ),
                                                          buttons: [
                                                            DialogButton(
                                                              onPressed: () {
                                                                print("este es el product  ${controllerPrice.text}");

                                                                if(controllerPrice.text.length>0){
                                                                  var value=double.parse(controllerPrice.text);

                                                                  if(value>0){

                                                                    Cart cartItem = Cart();
                                                                    cartItem.product =
                                                                        product;
                                                                    cartItem.numberItem = value;
                                                                    controlelrCart.items
                                                                        .add(cartItem);

                                                                    int cartIndex =
                                                                    checkItemCartIndex(
                                                                        product);

                                                                    controlelrCart.items[
                                                                    cartIndex] = cartItem;
                                                                  }
                                                                }


                                                                Navigator.pop(context);



                                                              },
                                                              child: Text(
                                                                "Agregar",
                                                                style: TextStyle(color: Colors.white, fontSize: 20),
                                                              ),
                                                            )
                                                          ]).show();

                                                    },
                                                  ),
                                                )
                                              ],
                                            )
                                          ],
                                        ),
                                      ))
                                ],
                              ),
                            ],
                          ),
                        ));
                  },
                ): Container())),
        Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            margin: EdgeInsets.only(left: 20, right: 20, bottom: 10),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Obx(() => controllerHome.isShowPayment.value
                    ? Container(
                  child: Obx(()=> controlelrCart.items.length > 0 ? Container(
                    child: Obx((){

                      var items=controlelrCart.items;
                      var total= 0;
                      List<Widget> itemsBuy=[];
                      for(var i =0  ; i  < items.length ; i++ ){
                        
                        
                        var salePrice=items[i].product.salesPrice.toDouble();

                        salePrice = salePrice*items[i].numberItem;

                        var discounts=items[i].discount;
                        if(discounts!=null){
                          for(var d =0  ; d  < discounts.length ; d++ ){
                            salePrice=salePrice-int.parse(discounts[d].total_discount);
                          }

                        }


                        itemsBuy.add(InkWell(
                          onTap: (){
                            showCart(context,i);
                          },
                          child: Container(

                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              color: Colors.grey.withOpacity(0.1),

                            ),
                            child: Row(
                              mainAxisAlignment:
                              MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Expanded(
                                    child: Container(

                                      margin: EdgeInsets.only(right: 10),
                                      child: Text(
                                        "${items[i].product.itemNme}  x ${items[i].product.divisible == 0 ? items[i].numberItem: items[i].numberItem.toInt() }",
                                        style: TextStyle(fontSize: 15),
                                      ),
                                    )),
                                Container(
                                  child: Text(
                                    "\$${(formatedNumber(salePrice<0 ? 0 : salePrice))}",
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold),
                                  ),
                                )
                              ],
                            ),
                            padding: EdgeInsets.only(
                                left: 10, right: 10, bottom: 8,top: 8),
                            margin: EdgeInsets.only(bottom: 8),
                          ),
                        ));
                      }

                      return Column(
                        mainAxisSize: MainAxisSize.min,
                        children: itemsBuy,
                      );
                    }),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(10),
                            topRight: Radius.circular(10)),
                        border:
                        Border.all(color: Color(0xff298dcf), width: 1),
                        color: Colors.white),
                    padding: EdgeInsets.only(
                        left: 10, right: 10, top: 10, bottom: 10),
                  ): Container()),
                )
                    : Container()),
                Obx(()=>  Stack(
                  children: [
                    GestureDetector(
                      onTap: () async {



                        if (!controllerHome.isShowPayment.value) {
                          if(controlelrCart.items.length>0) {
                            controllerHome.isShowPayment.value = true;
                          }else{
                            controllerHome.isShowPayment.value = false;
                          }
                        } else {
                          if(controlelrCart.items.length>0){
                            controllerCheckout.setPayments();

                            var data = await Get.to(Checkout());
                          }

                        }
                      },
                      child: Container(
                        padding: EdgeInsets.only(top: 10, bottom: 10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                              bottomRight: Radius.circular(10),
                              bottomLeft: Radius.circular(10),
                              topRight: Radius.circular(
                                  controllerHome.isShowPayment.value
                                      ? 0
                                      : 10),
                              topLeft: Radius.circular(
                                  controllerHome.isShowPayment.value
                                      ? 0
                                      : 10)),
                          color: Color(0xff298dcf),
                        ),
                        width: double.infinity,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            !controllerHome.isShowPayment.value
                                ? Text(
                              "Cobrar",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold),
                              textAlign: TextAlign.center,
                            )
                                : Text(
                              "Pagar",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold),
                              textAlign: TextAlign.center,
                            ),
                            Container(
                              margin: EdgeInsets.only(top: 3),
                              child: Obx((){
                                if(controlelrCart.items.length>0){
                                  var items=controlelrCart.items;
                                  var total= 0.0;




                                  for(var i =0  ; i  < items.length ; i++ ){


                                    var salePrice=items[i].product.salesPrice.toDouble();

                                    salePrice=salePrice*items[i].numberItem;


                                    var discounts=items[i].discount;
                                    if(discounts!=null){
                                      for(var d =0  ; d  < discounts.length ; d++ ){
                                        salePrice=salePrice-int.parse(discounts[d].total_discount);
                                      }
                                    }

                                    total=total+(salePrice);
                                  }




                                  controllerCheckout.valueCheckout.value="${total}";



                                  return Text(
                                    "\$${formatedNumber(total<0 ? 0 : total)}",
                                    style: TextStyle(color: Colors.white),
                                    textAlign: TextAlign.center,
                                  );
                                }else{
                                  return Text(
                                    "\$ 0",
                                    style: TextStyle(color: Colors.white),
                                    textAlign: TextAlign.center,
                                  );
                                }


                              }),
                            )
                          ],
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                          if(controlelrCart.items.length>0) {
                            controllerHome.isShowPayment.value =
                            !controllerHome.isShowPayment.value;
                          }else{
                            controllerHome.isShowPayment.value=false;
                          }

                      },
                      child: Obx(() => Container(
                        color: Colors.transparent,
                        child: Icon(
                          controllerHome.isShowPayment.value
                              ? Icons.remove
                              : Icons.add,
                          color: Colors.white,
                        ),
                        height: 65,
                        width: 65,
                      )),
                    ),
                  ],
                ))
              ],
            ),
          ),
        )
      ],
    ));
  }
}


