import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:poshop/categories/controllers/CategoryController.dart';
import 'package:poshop/products/controllers/ProductContoller.dart';
import 'package:poshop/products/detail.dart';
import 'package:poshop/products/model/Product.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:get/get.dart';

class ProductsList extends StatelessWidget {
  ProductContoller controllerHome = Get.put(ProductContoller());

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

    return Scaffold(
      floatingActionButton: Obx(() => Visibility(
          visible: !controllerHome.isOpenCreator.value,
          child: FloatingActionButton(
            // isExtended: true,
            child: Icon(Icons.add),

            backgroundColor: Color(0xff298dcf),
            onPressed: () {
              controllerHome.isOpenCreator.value = true;

              controllerHome.panelController.value.open();
             },
          ))),
      body: SlidingUpPanel(

        onPanelClosed: () {
          controllerHome.resetCreationProduct();
          controllerHome.isOpenCreator.value = false;
        },
        backdropTapClosesPanel: true,
        backdropEnabled: true,
        controller: controllerHome.panelController.value,
        minHeight: 0,


        panel: DetailProduct(),
        body: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(left: 20,right: 20,bottom: 10),
              child: TextField(
                onChanged: (value) {},
                decoration: InputDecoration(
                    labelText: "Buscar producto",
                    hintText: "Buscar producto",
                    prefixIcon: Icon(Icons.search),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(25.0)))),
              ),
            ),
            Expanded(child: Obx(()=>ListView.builder(
              padding: EdgeInsets.only(bottom: 200),
                itemCount: controllerHome.products.length,
                itemBuilder: (BuildContext context,int index){
                  Product product = controllerHome.products[index];

                  print("aquiii el producto ${product}");

                  return GestureDetector(
                    onTap: () {
                      controllerHome.isOpenCreator.value = true;
                      controllerHome.panelController.value.open();
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
                                                "Categoría",
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
            )))
          ],
        ),
      ),
    );
  }
}
