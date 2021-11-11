import 'package:flutter/material.dart';
import 'package:masonry_grid/masonry_grid.dart';

class Menu extends StatelessWidget{
  @override
  Widget build(BuildContext context) {

    return  AppBar(
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
                    Icons.shopping_cart,
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
    );
  }

}