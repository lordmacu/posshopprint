import 'package:flutter/material.dart';
import 'package:poshop/cart/controllers/ProductContoller.dart';
import 'package:poshop/products//detail.dart';
import 'package:get/get.dart';
import 'package:poshop/products/controllers/ProductContoller.dart';

class ProductIndividual extends StatelessWidget{
  ProductsContoller controllerProduct= Get.find();

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text(""),
      ),
      body: DetailProduct(),
    ) ;
  }

}