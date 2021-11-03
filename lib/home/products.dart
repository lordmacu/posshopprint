import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:masonry_grid/masonry_grid.dart';
import 'package:poshop/cart/controllers/CartController.dart';
import 'package:poshop/cart/model/Cart.dart';
import 'package:poshop/checkout/checkout.dart';
import 'package:poshop/checkout/controllers/CheckoutController.dart';

import 'package:poshop/home/controllers/HomeController.dart';
import 'package:poshop/products/controllers/ProductContoller.dart';
import 'package:poshop/products/model/Product.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

class Products extends StatelessWidget {
  HomeContoller controllerHome = Get.find();
  ProductContoller controllerProduct = Get.find();
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

  formatedNumber(number) {
    var formatCurrency;
    formatCurrency = new NumberFormat.currency(
        customPattern: "\u00A4#,##0.00\u00A0",
        symbol: "",
        decimalDigits: 0,
        locale: "es");

    return formatCurrency.format(number);
  }

  @override
  Widget build(BuildContext context) {



    return Expanded(
        child: Stack(
      children: [
        Container(
            padding: EdgeInsets.only(left: 20, right: 20, top: 15),
            child: Obx(() => ScrollablePositionedList.builder(
              addAutomaticKeepAlives: false,

              itemScrollController: controllerHome.itemScrollController.value,
              itemPositionsListener:  controllerHome.itemPositionsListener.value,
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
                                    child: Image.network(
                                      product.image== null ? "https://m.media-amazon.com/images/I/61ccMD0XMBL._AC_UY625_.jpg" :  product.image,
                                      fit: BoxFit.cover,
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
                                                product.category != null ? product.category.name : "Categoría",
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
                                            Row(
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
                                                            print("aquiii esta mayor en cero");

                                                          }

                                                          if (isInCart.numberItem == 0) {
                                                            print("aquiii esta en cero");
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
                                                            "${controlelrCart.items[cartIndex].numberItem}",
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
                ))),
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

                        itemsBuy.add(Container(
                          child: Row(
                            mainAxisAlignment:
                            MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                  child: Container(
                                    margin: EdgeInsets.only(right: 10),
                                    child: Text(
                                      "${items[i].product.itemNme}  x ${items[i].numberItem}",
                                      style: TextStyle(fontSize: 15),
                                    ),
                                  )),
                              Container(
                                child: Text(
                                  "\$${(formatedNumber(items[i].product.salesPrice*items[i].numberItem))}",
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold),
                                ),
                              )
                            ],
                          ),
                          margin: EdgeInsets.only(
                              left: 10, right: 10, bottom: 10),
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
                          controllerHome.isShowPayment.value = true;
                        } else {
                          controllerCheckout.setPayments();

                          var data = await Get.to(Checkout());
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

                                var items=controlelrCart.items;
                                var total= 0;
                                for(var i =0  ; i  < items.length ; i++ ){
                                  total=total+(items[i].product.salesPrice*items[i].numberItem);
                                }

                                controllerCheckout.valueCheckout.value="${total}";

                                return Text(
                                  "\$${formatedNumber(total)}",
                                  style: TextStyle(color: Colors.white),
                                  textAlign: TextAlign.center,
                                );
                              }),
                            )
                          ],
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        controllerHome.isShowPayment.value =
                        !controllerHome.isShowPayment.value;
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


