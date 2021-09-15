import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:masonry_grid/masonry_grid.dart';
import 'package:poshop/categories/colors.dart';
import 'package:poshop/categories/controllers/CategoryController.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:get/get.dart';

class Categories extends StatelessWidget {
  CategoryContoller controllerHome = Get.put(CategoryContoller());
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    PanelController _panelController= PanelController();

    var boxWidth=(width/4)-30;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        iconTheme: IconThemeData(color: Color(0xff298dcf)),
        backgroundColor: Colors.white,
        title: Text(
          "Categorías",
          style: TextStyle(color: Color(0xff298dcf)),
        ),
      ),
      body: Obx(()=>SlidingUpPanel(
        backdropTapClosesPanel: true,
        backdropEnabled: true,
        controller: _panelController,
        maxHeight:controllerHome.isPanelOpen.value ? 500 : 0 ,
        minHeight: 0,
        panel: Container(
          padding: EdgeInsets.all(10),
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.only(top: 30,left: 10,bottom: 10),
                child: Row(
                  children: [
                    Text("Nombre de categoría",style: TextStyle(color:  Color(0xff298dcf),fontSize: 18),)
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only( left: 10 ,right: 10),

                child:
                TextFormField(
                  decoration: InputDecoration(
                       hintText: 'Escribe el nombre de la categoría'
                  ),
                  // The validator receives the text that the user has entered.
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter some text';
                    }
                    return null;
                  },
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 30,left: 10,bottom: 10),
                child: Row(
                  children: [
                    Text("Color de categorías",style: TextStyle(color:  Color(0xff298dcf),fontSize: 18),)
                  ],
                ),
              ),
              ColorsBoxes(),

              Container(
                margin: EdgeInsets.only(top: 20),
                width: double.infinity,

                child: OutlineButton(
                  borderSide: BorderSide(
                    color: Color(0xff298dcf) , //Color of the border
                    style: BorderStyle.solid, //Style of the border
                    width: 1, //width of the border
                  ),

                  shape: new RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(30.0),

                  ),
                   onPressed: (){

                  },
                  child: Text("Asignar artículos",style: TextStyle(color: Color(0xff298dcf)),),
                ),
              ),
              Container(
                width: double.infinity,
                child: RaisedButton(
                  shape: new RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(30.0),
                  ),
                  color:Color(0xff298dcf) ,

                  onPressed: (){

                  },
                  child: Text("Crear artículos",style: TextStyle(color: Colors.white)),
                ),
              )
            ],
          ),
        ),
        body: Column(
          children: [
            Expanded(
                child: Container(
                  padding: EdgeInsets.only(left: 20, right: 20, top: 15),
                  child: CustomScrollView(
                    slivers: [
                      SliverToBoxAdapter(
                          child: Column(
                            children: [
                              MasonryGrid(
                                  column: 2,
                                  children: List.generate(
                                    40,
                                        (i) {
                                      if (i == 0) {

                                        bool ispressed=false;
                                        return GestureDetector(
                                          onTap: (){

                                            print("asdfasd");
                                            controllerHome.isPanelOpen.value=true;
                                            _panelController.open();
                                          },
                                          child: Container(
                                              padding: EdgeInsets.only(
                                                  left: 10, right: 10, top: 10, bottom: 10),
                                              width: 100,
                                              height: 160,
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
                                                      offset: Offset(0,
                                                          3), // changes position of shadow
                                                    ),
                                                  ],
                                                ),
                                                height: 80,
                                                child: Center(
                                                  child: Container(
                                                    height: 80,
                                                    child: Icon(Icons.add,color: Color(0xff298dcf),size: 45,),
                                                  ),
                                                ),
                                              )),
                                        );
                                      } else {
                                        return Container(
                                            padding: EdgeInsets.only(
                                                left: 10, right: 10, top: 10, bottom: 10),
                                            width: 100,
                                            height: 160,
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
                                                    offset: Offset(0,
                                                        3), // changes position of shadow
                                                  ),
                                                ],
                                              ),
                                              height: 80,
                                              child: Column(
                                                children: [
                                                  Row(
                                                    mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                    children: [
                                                      Container(
                                                        height: 80,
                                                        child: Image.network(
                                                          "https://m.media-amazon.com/images/I/61ccMD0XMBL._AC_UY625_.jpg",
                                                          fit: BoxFit.cover,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  Container(
                                                    margin: EdgeInsets.only(top: 10),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                      children: [
                                                        Text(
                                                          "Categoría",
                                                          style: TextStyle(fontSize: 17),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ));
                                      }
                                    },
                                  ))
                            ],
                          ))
                    ],
                  ),
                ))
          ],
        ),
      )),
    );
  }
}
