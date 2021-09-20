import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:bubble_bottom_bar/bubble_bottom_bar.dart';
import 'package:get/get.dart';
import 'package:poshop/controllers/MenuController.dart';
import 'package:pop_bottom_menu/pop_bottom_menu.dart';
import 'package:masonry_grid/masonry_grid.dart';
import 'package:poshop/general/bottonMenu.dart';
import 'package:poshop/home/cart.dart';
import 'package:poshop/home/categories.dart';
import 'package:poshop/home/controllers/HomeController.dart';
import 'package:poshop/home/products.dart';
import 'package:poshop/products/products.dart';
import 'package:poshop/tickets/tickets.dart';

class Home extends StatelessWidget {
  MenuContoller controller = Get.put(MenuContoller());
  HomeContoller controllerHome = Get.put(HomeContoller());


  Widget getScreen(){
    if( controller.positionMenu.value==0){
      return Cart();
    }
    if( controller.positionMenu.value==1){
      return Tickets();
    }
    if( controller.positionMenu.value==2){
      return ProductsList();
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          iconTheme: IconThemeData(color: Color(0xff298dcf)),
          backgroundColor: Colors.white,
          elevation: 0,
          title: Text(
            "Posshop",
            style: TextStyle(color: Colors.black87),
          ),
          actions: [
            InkWell(
              onTap: () {},
              child: Container(
                margin: EdgeInsets.only(right: 15),
                child: Container(
                  child: Row(
                    children: [
                      Icon(
                        Icons.shopping_cart_outlined,
                        color: Color(0xff298dcf),
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 5),
                        child: Text(
                          "0",
                          style: TextStyle(color: Colors.grey, fontSize: 20),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
            InkWell(
              onTap: () {},
              child: Container(
                child: Icon(
                  Icons.person_add,
                  color: Color(0xff298dcf),
                ),
              ),
            ),
            PopupMenuButton<String>(
              onSelected: (value) {},
              itemBuilder: (BuildContext context) {
                return {'Logout', 'Settings'}.map((String choice) {
                  return PopupMenuItem<String>(
                    value: choice,
                    child: Text(choice),
                  );
                }).toList();
              },
            )
          ],
        ),
        body: Obx(()=>getScreen()),
        bottomNavigationBar: BottomMenu() );
  }
}
