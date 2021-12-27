import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:poshop/categories/controllers/CategoryController.dart';

class ColorsBoxes extends StatelessWidget{
  CategoryContoller controllerCategory = Get.find();

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    var boxWidth=(width/4)-30;

    return Obx(()=>Column(
      children: [
        Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: (){
                  controllerCategory.categoryColor.value="#E0E0E0";
                },
                child: Container(
                  margin: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      color: Color(0xffE0E0E0),
                      border: Border.all(color: controllerCategory.categoryColor.value == "#E0E0E0" ? Colors.blueAccent :  Colors.white,width: controllerCategory.categoryColor.value == "#E0E0E0" ? 4 : 0)
                  ),

                  child: null,
                  width: boxWidth,
                  height: boxWidth,
                ),
              ),
              GestureDetector(
                onTap: (){
                  controllerCategory.categoryColor.value="#F44336";

                },
                child: Container(
                  margin: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      color: Color(0xffF44336),
                      border: Border.all(color: controllerCategory.categoryColor.value == "#F44336" ? Colors.blueAccent :  Colors.white,width: controllerCategory.categoryColor.value == "#F44336" ? 4 : 0)
                  ),
                  child: null,
                  width: boxWidth,
                  height: boxWidth,
                ),
              ),
              GestureDetector(
                onTap: (){
                  controllerCategory.categoryColor.value="#E91E63";

                },
                child: Container(
                  margin: EdgeInsets.all(10),

                  decoration: BoxDecoration(
                      color: Color(0xffE91E63),
                      border: Border.all(color: controllerCategory.categoryColor.value == "#E91E63" ? Colors.blueAccent :  Colors.white,width: controllerCategory.categoryColor.value == "#E91E63" ? 4 : 0)
                  ),
                  child: null,
                  width: boxWidth,
                  height: boxWidth,
                ),
              ),
              GestureDetector(
                onTap: (){
                  controllerCategory.categoryColor.value="#FF9800";

                },
                child: Container(
                  margin: EdgeInsets.all(10),

                  decoration: BoxDecoration(
                      color: Color(0xffFF9800),
                      border: Border.all(color: controllerCategory.categoryColor.value == "#FF9800" ? Colors.blueAccent :  Colors.white,width: controllerCategory.categoryColor.value == "#FF9800" ? 4 : 0)
                  ),
                  child: null,
                  width: boxWidth,
                  height: boxWidth,
                ),
              ),

            ],
          ),
        ),

        Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: (){
                  controllerCategory.categoryColor.value="#CDDC39";
                },
                child: Container(
                  margin: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      color: Color(0xffCDDC39),
                      border: Border.all(color: controllerCategory.categoryColor.value == "#CDDC39" ? Colors.blueAccent :  Colors.white,width: controllerCategory.categoryColor.value == "#CDDC39" ? 4 : 0)

                  ),
                  child: null,
                  width: boxWidth,
                  height: boxWidth,
                ),
              ),
              GestureDetector(
                onTap: (){
                  controllerCategory.categoryColor.value="#4CAF50";

                },
                child: Container(
                  margin: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      color: Color(0xff4CAF50),
                      border: Border.all(color: controllerCategory.categoryColor.value == "#4CAF50" ? Colors.blueAccent :  Colors.white,width: controllerCategory.categoryColor.value == "#4CAF50" ? 4 : 0)

                  ),
                  child: null,
                  width: boxWidth,
                  height: boxWidth,
                ),
              ),
              GestureDetector(
                onTap: (){
                  controllerCategory.categoryColor.value="#2196F3";

                },
                child: Container(
                  margin: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      color: Color(0xff2196F3),
                      border: Border.all(color: controllerCategory.categoryColor.value == "#2196F3" ? Color(0xff9C27B0) :  Colors.white,width: controllerCategory.categoryColor.value == "#2196F3" ? 4 : 0)

                  ),
                  child: null,
                  width: boxWidth,
                  height: boxWidth,
                ),
              ),
              GestureDetector(
                onTap: (){
                  controllerCategory.categoryColor.value="#9C27B0";

                },
                child: Container(
                  margin: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      color: Color(0xff9C27B0),
                      border: Border.all(color: controllerCategory.categoryColor.value == "#9C27B0" ? Colors.blueAccent :  Colors.white,width: controllerCategory.categoryColor.value == "#9C27B0" ? 4 : 0)

                  ),
                  child: null,
                  width: boxWidth,
                  height: boxWidth,
                ),
              ),

            ],
          ),
        ),
      ],
    ));
  }

}