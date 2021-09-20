import 'package:flutter/material.dart';
import 'package:poshop/home/categories.dart';
import 'package:poshop/home/controllers/HomeController.dart';
import 'package:poshop/home/products.dart';

class Cart extends StatelessWidget{
  @override
  Widget build(BuildContext context) {

    return Column(
      children: [
        Categories(),
        Products()
      ],
    );
  }

}