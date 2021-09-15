import 'package:flutter/material.dart';
import 'package:poshop/controllers/MenuController.dart';
import 'package:get/get.dart';
import 'package:poshop/home/controllers/HomeController.dart';

class Categories extends StatelessWidget{

  HomeContoller controller = Get.find();

  @override
  Widget build(BuildContext context) {

    return Container(
      margin: EdgeInsets.only(top: 10,bottom: 0,left: 10,right: 0),
      height: 50,
      child: ListView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemCount: 15,
        itemBuilder: (BuildContext context, int index) => Obx(()=>GestureDetector(
          onTap: (){
            controller.categorySelect.value=index;
          },
          child: Card(

            shape: RoundedRectangleBorder(

              borderRadius: BorderRadius.circular(30.0),
            ),
            child: Container(

              decoration: BoxDecoration(
                  color: index==controller.categorySelect.value ?  Color(0xff298dcf)  : Colors.white ,
                  borderRadius: BorderRadius.circular(30.0),

                  border: Border.all(color: Color(0xff298dcf))

              ),
              padding: EdgeInsets.only(left: 20,right: 20),
              child: Center(child: Text(index==controller.categorySelect.value ? "Categoría":"Categoría",style: TextStyle(color: index==controller.categorySelect.value ?  Colors.white : Color(0xff298dcf) ),),),
            ),
          ),
        )),
      ),
    );
  }

}