import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:masonry_grid/masonry_grid.dart';
import 'package:poshop/checkout/checkout.dart';
import 'package:poshop/home/controllers/HomeController.dart';
import 'package:poshop/products/controllers/ProductContoller.dart';

class Products extends StatelessWidget{
  HomeContoller controllerHome = Get.find();
  ProductContoller controllerProduct = Get.put(ProductContoller());

  @override
  Widget build(BuildContext context) {

    return Expanded(
        child: Stack(
          children: [

            Container(
                padding: EdgeInsets.only(left: 20, right: 20,top: 15),
                child:   ListView.builder(
                  itemCount: 50,
                  itemBuilder: (context, index) {
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
                                offset: Offset(
                                    0, 3), // changes position of shadow
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
                                              MainAxisAlignment.start,
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
                                                  margin: EdgeInsets.only(
                                                      top: 5),
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                      BorderRadius.all(
                                                          Radius
                                                              .circular(
                                                              30)),
                                                      color: Colors.grey
                                                          .withOpacity(
                                                          0.2)),
                                                  width: 90,
                                                  child: Row(
                                                    mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                    children: [
                                                      Container(
                                                        child: Icon(
                                                          Icons.remove,
                                                          color:
                                                          Colors.white,
                                                          size: 20,
                                                        ),
                                                        decoration: BoxDecoration(
                                                            color: Color(
                                                                0xff298dcf).withOpacity(0.8),
                                                            borderRadius: BorderRadius
                                                                .all(Radius
                                                                .circular(
                                                                50))),
                                                      ),
                                                      Container(
                                                        child: Text(
                                                          "0",
                                                          style: TextStyle(
                                                              fontSize: 20),
                                                        ),
                                                      ),
                                                      InkWell(
                                                        onTap: () {},
                                                        child: Container(
                                                          child: Icon(
                                                            Icons.add,
                                                            color: Colors
                                                                .white,
                                                            size: 20,
                                                          ),
                                                          decoration: BoxDecoration(
                                                              color: Color(
                                                                  0xff298dcf).withOpacity(0.8),
                                                              borderRadius:
                                                              BorderRadius.all(
                                                                  Radius.circular(
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
                )
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                margin: EdgeInsets.only(left: 20,right: 20,bottom: 10),

                child: Column(
                  mainAxisSize: MainAxisSize.min,

                  children: [
                    Obx(()=> controllerHome.isShowPayment.value ? Container(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(

                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(child: Container(
                                  margin: EdgeInsets.only(right: 10),
                                  child: Text("Procuto 1  x 1",style: TextStyle(fontSize: 15),),
                                )),
                                Container(
                                  child: Text("\$5.000",style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),),
                                )
                              ],
                            ),
                            margin: EdgeInsets.only(left: 10,right: 10,bottom: 10),
                          ),
                          Container(

                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(child: Container(
                                  margin: EdgeInsets.only(right: 10),
                                  child: Text("Procuto 1  x 1",style: TextStyle(fontSize: 15),),
                                )),
                                Container(
                                  child: Text("\$5.000",style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),),
                                )
                              ],
                            ),
                            margin: EdgeInsets.only(left: 10,right: 10,bottom: 10),
                          )
                        ],
                      ),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(topLeft: Radius.circular(10),topRight: Radius.circular(10)),
                          border: Border.all(
                              color: Color(
                                  0xff298dcf),
                              width: 1
                          ),
                          color: Colors.white
                      ),
                      padding: EdgeInsets.only(left: 10,right: 10,top: 10,bottom: 10),
                    ) : Container()),
                    Stack(
                      children: [

                        Obx(()=>GestureDetector(
                          onTap: () async{
                            if(!controllerHome.isShowPayment.value){
                              controllerHome.isShowPayment.value=true;
                            }else{
                              var data = await Get.to(Checkout());
                            }
                          },
                          child: Container(

                            padding: EdgeInsets.only(top: 10,bottom: 10),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(bottomRight: Radius.circular(10),bottomLeft: Radius.circular(10),topRight: Radius.circular(controllerHome.isShowPayment.value ? 0 : 10),topLeft: Radius.circular(controllerHome.isShowPayment.value ? 0 : 10)),
                              color: Color(
                                  0xff298dcf),
                            ),
                            width: double.infinity,

                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                !controllerHome.isShowPayment.value ? Text("Cobrar",style: TextStyle(color: Colors.white,fontSize: 22,fontWeight: FontWeight.bold),textAlign: TextAlign.center,) : Text("Pagar",style: TextStyle(color: Colors.white,fontSize: 22,fontWeight: FontWeight.bold),textAlign: TextAlign.center,),
                                Container(
                                  margin: EdgeInsets.only(top: 3),
                                  child: Text("\$1000.000",style: TextStyle(color: Colors.white),textAlign: TextAlign.center,),
                                )
                              ],
                            ),
                          ),
                        )),
                        GestureDetector(
                          onTap: (){
                            controllerHome.isShowPayment.value= !controllerHome.isShowPayment.value;
                          },
                          child: Obx(()=>Container(
                            color: Colors.transparent,
                            child: Icon(controllerHome.isShowPayment.value ? Icons.remove : Icons.add,color: Colors.white,),
                            height: 65,
                            width: 65,
                          )),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            )
          ],
        )
    );
  }

}