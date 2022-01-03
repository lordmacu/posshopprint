import 'package:flutter/material.dart';
 import 'package:intl/intl.dart';
import 'package:poshop/categories/controllers/CategoryController.dart';
import 'package:poshop/helpers/widgetsHelper.dart';
 import 'package:poshop/products/barcode.dart';
import 'package:poshop/products/controllers/ProductContoller.dart';
import 'package:poshop/products/detail.dart';
import 'package:poshop/products/individualProduct.dart';
import 'package:poshop/products/model/Product.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:get/get.dart';

class ProductsList extends StatelessWidget {
  ProductsContoller controllerHome = Get.put(ProductsContoller());
  WidgetsHelper helpers = WidgetsHelper();
  var loadingHud;
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
    loadingHud = helpers.initLoading(context);
    PanelController panelController = PanelController();

    return Scaffold(
      floatingActionButton: Column(
        mainAxisSize: MainAxisSize.min,
        children: [

          FloatingActionButton(
            heroTag: "btn2",

            // isExtended: true,
            child: Icon(Icons.add),

            backgroundColor: Color(0xff298dcf),
            onPressed: () {
              // controllerHome.isOpenCreator.value = true;
              controllerHome.resetCreationProduct();

              Get.to(() => ProductIndividual());


              // controllerHome.panelController.value.open();
            },
          )
        ],
      ),

      body: Obx(()=>ListView.builder(
          padding: EdgeInsets.only(bottom: 200),
          itemCount: controllerHome.products.length,
          itemBuilder: (BuildContext context,int index){
            Product product = controllerHome.products[index];


            return GestureDetector(
              onTap: () {
                //controllerHome.isOpenCreator.value = true;
               // panelController.open();
                Get.to(() => ProductIndividual());

                controllerHome.setProduct(product);

              },
              child: Container(
                  margin: EdgeInsets.only(left: 20, right: 20),
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
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              width: 100,
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
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        child: Text(
                                          "${product.itemNme}",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 20),
                                        ),
                                      ),
                                      Container(
                                        child: Text(
                                          product.category != null ? product.category.name : "Sin Categoría",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 15,
                                              color:
                                              Colors.grey.withOpacity(0.6)),
                                        ),
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.end,
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
                                                            .withOpacity(0.9)),
                                                  ),
                                                  margin:
                                                  EdgeInsets.only(right: 3),
                                                ),
                                                Text(
                                                  "${formatedNumber(product.salesPrice)}",
                                                  style: TextStyle(
                                                      fontWeight:
                                                      FontWeight.bold,
                                                      fontSize: 20),
                                                )
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ))
                          ],
                        ),
                      ],
                    ),
                  )),
            );
          }
      )),
    );
  }
}
