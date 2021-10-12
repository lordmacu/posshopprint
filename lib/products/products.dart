import 'package:flutter/material.dart';
import 'package:poshop/products/controllers/ProductContoller.dart';
import 'package:poshop/products/detail.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:get/get.dart';

class ProductsList extends StatelessWidget {
  ProductContoller controllerHome = Get.put(ProductContoller());

  @override
  Widget build(BuildContext context) {
    PanelController _panelController = PanelController();

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        // isExtended: true,
        child: Icon(Icons.add),
        backgroundColor: Color(0xff298dcf),
        onPressed: () {

          _panelController.open();
        },
      ),
      body: SlidingUpPanel(
        backdropTapClosesPanel: true,
        backdropEnabled: true,
        controller: _panelController,
        minHeight: 0,

        panel: DetailProduct(),

        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                onChanged: (value) {

                },
                 decoration: InputDecoration(
                    labelText: "Buscar producto",
                    hintText: "Buscar producto",
                    prefixIcon: Icon(Icons.search),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(25.0)))),
              ),
            ),
            Expanded(child: ListView.builder(
              itemCount: 50,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    _panelController.open();
                  },
                  child: Container(
                    margin: EdgeInsets.only(left: 20,right: 20),

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
                              offset: Offset(
                                  0, 3), // changes position of shadow
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
                                    "https://m.media-amazon.com/images/I/61ccMD0XMBL._AC_UY625_.jpg",
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
                                              "Producto",
                                              style: TextStyle(
                                                  fontWeight:
                                                  FontWeight.bold,
                                                  fontSize: 20),
                                            ),
                                          ),
                                          Container(
                                            child: Text(
                                              "Categoría",
                                              style: TextStyle(
                                                  fontWeight:
                                                  FontWeight.bold,
                                                  fontSize: 15,
                                                  color: Colors.grey
                                                      .withOpacity(0.6)),
                                            ),
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment.end,
                                            mainAxisSize:
                                            MainAxisSize.max,
                                            children: [
                                              Container(
                                                margin: EdgeInsets.only(
                                                    top: 10),
                                                child: Row(
                                                  mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .start,
                                                  crossAxisAlignment:
                                                  CrossAxisAlignment
                                                      .start,
                                                  children: [
                                                    Container(
                                                      child: Text(
                                                        "\$",
                                                        style: TextStyle(
                                                            fontWeight:
                                                            FontWeight
                                                                .bold,
                                                            fontSize: 15,
                                                            color: Colors
                                                                .grey
                                                                .withOpacity(
                                                                0.9)),
                                                      ),
                                                      margin:
                                                      EdgeInsets.only(
                                                          right: 3),
                                                    ),
                                                    Text(
                                                      "5.000.000",
                                                      style: TextStyle(
                                                          fontWeight:
                                                          FontWeight
                                                              .bold,
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
              },
            ))
          ],
        ),
      ),
    );
  }
}
