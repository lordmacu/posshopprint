import 'package:flutter/material.dart';
import 'package:poshop/categories/controllers/CategoryController.dart';
import 'package:poshop/categories/models/Category.dart';
import 'package:poshop/controllers/MenuController.dart';
import 'package:get/get.dart';
import 'package:poshop/home/controllers/HomeController.dart';

class Categories extends StatelessWidget{

  HomeContoller controller = Get.find();
  CategoryContoller controllerCategory = Get.find();

  @override
  Widget build(BuildContext context) {

    return Container(
      margin: EdgeInsets.only(top: 10,bottom: 0,left: 10,right: 0),
      height: 50,
      child: Obx(()=>ListView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemCount: controllerCategory.items.length,
        itemBuilder: (BuildContext context, int index) {

          Category cat= controllerCategory.items[index];
          return Obx(()=>GestureDetector(
            onTap: (){
              controller.categorySelect.value=cat.id;

              print("esta es la seleccion ${cat.id}");
            },
            child: Card(

              shape: RoundedRectangleBorder(

                borderRadius: BorderRadius.circular(30.0),
              ),
              child: Container(

                decoration: BoxDecoration(
                    color: cat.id==controller.categorySelect.value ?  Color(0xff298dcf)  : Colors.white ,
                    borderRadius: BorderRadius.circular(30.0),

                    border: Border.all(color: Color(0xff298dcf))

                ),
                padding: EdgeInsets.only(left: 20,right: 20),
                child: Center(child: Text("${cat.name}",style: TextStyle(color: cat.id==controller.categorySelect.value ?  Colors.white : Color(0xff298dcf) ),),),
              ),
            ),
          ));
        },
      )),
    );
  }

}