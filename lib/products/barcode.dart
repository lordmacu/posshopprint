import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:poshop/categories/controllers/CategoryController.dart';
 import 'package:poshop/products/controllers/ProductContoller.dart';
import 'package:poshop/products/detail.dart';
import 'package:poshop/products/model/Product.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:get/get.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

class Barcode extends StatelessWidget {

  ProductContoller controllerProduct= ProductContoller();

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child:  Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              child: Obx(()=>Text("${controllerProduct.barcode.value}")),
            ),
            RaisedButton(
              padding: EdgeInsets.only(top: 15, bottom: 15),
              onPressed: () async {



              },
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30.0),
              ),
              color: Color(0xff298dcf),
              child: Text(
                "Abrir lector de barras",
                style: TextStyle(color: Colors.white, fontSize: 17),
              ),
            )
          ],
        ),
      ),
    );
  }
}
