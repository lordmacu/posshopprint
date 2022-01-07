import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:masonry_grid/masonry_grid.dart';
import 'package:poshop/categories/colors.dart';
import 'package:poshop/categories/controllers/CategoryController.dart';
import 'package:poshop/categories/models/Category.dart';
import 'package:poshop/helpers/widgetsHelper.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:get/get.dart';

class Categories extends StatelessWidget {
  CategoryContoller controllerCategory = Get.put(CategoryContoller());

  WidgetsHelper helpers = WidgetsHelper();
  var loadingHud;
  TextEditingController contorllerName= TextEditingController();

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    loadingHud = helpers.initLoading(context);


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
        controller: controllerCategory.panelController.value,
        maxHeight:controllerCategory.isPanelOpen.value ? 500 : 0 ,
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
                  controller:contorllerName ,
                  onChanged: (value){
                    controllerCategory.categoryName.value=value;
                  },
                  decoration: InputDecoration(
                       hintText: 'Escribe el nombre de la categoría'
                  ),
                  // The validator receives the text that the user has entered.
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor ingrese el nombre de la categoría';
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
                width: double.infinity,
                child: RaisedButton(
                  shape: new RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(30.0),
                  ),
                  color:Color(0xff298dcf) ,
                  onPressed: () async{

                    var categoryName=controllerCategory.categoryName.value;
                    var categoryColor=controllerCategory.categoryColor.value;
                    if(categoryName.length==0){
                      helpers.defaultAlert(context, "error", "Nombre de la categoría",
                          "Ingresa el nombre de la categoría");
                      return false;
                    }


                    if(categoryColor.length==0){
                      helpers.defaultAlert(context, "error", "Color de la categoría",
                          "Ingresa el color de la categoría");
                      return false;

                    }

                    if(controllerCategory.categoryId.value==0){
                    var result= await controllerCategory.createCategories();

                    if(result!="ok"){
                      helpers.defaultAlert(context, "error", "${result["message"]}",
                          "${result["data"]}");
                    }



                    }else{
                      var result= await controllerCategory.updateCategories();
                      if(result!="ok"){
                        helpers.defaultAlert(context, "error", "${result["message"]}",
                            "${result["data"]}");
                      }

                    }
                    controllerCategory.panelController.value.close();



                  },
                  child: Text(controllerCategory.categoryId.value==0 ? "Crear categoría" :"Actualizar categoría"  ,style: TextStyle(color: Colors.white)),
                ),
              ),
              controllerCategory.categoryId.value>0 ? Container(
                width: double.infinity,
                child: RaisedButton(
                  shape: new RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(30.0),
                  ),
                  color:Colors.redAccent ,
                  onPressed: () async{


                   Alert(
                     context: context,
                     type: AlertType.warning,
                     title:"Borrar Categoría",
                     desc: "¿Quieres borrar esta categoría?",
                     buttons: [
                       DialogButton(
                         radius: BorderRadius.circular(20),
                         child: Text(
                           "Si",
                           style: TextStyle(color: Colors.white, fontSize: 20),
                         ),
                         onPressed: () async {
                    await controllerCategory.deleteCategories();

                    controllerCategory.panelController.value.close();
                    Navigator.pop(context);

                    },
                         color:  Colors.redAccent,

                       ),

                       DialogButton(
                         radius: BorderRadius.circular(20),
                         child: Text(
                           "No",
                           style: TextStyle(color: Colors.white, fontSize: 20),
                         ),
                         onPressed: () => Navigator.pop(context),
                         color:  Color(0xff298dcf),

                       ),

                     ],
                   ).show();


                  },
                  child: Text("Borrar Categoría"  ,style: TextStyle(color: Colors.white)),
                ),
              ): Container()
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
                                    controllerCategory.items.length+1,
                                        (i) {
                                      if (i == 0) {

                                        bool ispressed=false;
                                        return GestureDetector(
                                          onTap: (){

                                             controllerCategory.isPanelOpen.value=true;
                                             controllerCategory.categoryId.value=0;
                                             contorllerName.text="";
                                             controllerCategory.categoryColor.value="";
                                             controllerCategory.categoryName.value="";

                                             controllerCategory.panelController.value.open();
                                          },
                                          child: Container(
                                              padding: EdgeInsets.only(
                                                  left: 10, right: 10, top: 10, bottom: 10),
                                              width: 100,
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
                                                height: 60,
                                                child: Center(
                                                  child: Container(
                                                    height: 60,
                                                    child: Icon(Icons.add,color: Color(0xff298dcf),size: 45,),
                                                  ),
                                                ),
                                              )),
                                        );
                                      } else {
                                        return GestureDetector(
                                          onTap: (){
                                            Category cat=controllerCategory.items[i-1];
                                            controllerCategory.categoryName.value=cat.name;
                                            controllerCategory.categoryColor.value=cat.color;
                                            controllerCategory.categoryId.value=cat.id;
                                            contorllerName.text=cat.name;

                                            controllerCategory.isPanelOpen.value=true;
                                            controllerCategory.panelController.value.open();

                                          },
                                          child: Container(
                                              padding: EdgeInsets.only(
                                                  left: 10, right: 10, top: 10, bottom: 10),
                                              width: 100,
                                              child: Container(
                                                padding: EdgeInsets.all(10),
                                                decoration: BoxDecoration(
                                                  color: Color(int.parse("0xff${controllerCategory.items[i-1].color.replaceAll("#", "")}")),
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
                                                child: Column(
                                                  children: [
                                                    Row(
                                                      mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                      children: [
                                                        Container(
                                                          color: Color(int.parse("0xff${controllerCategory.items[i-1].color.replaceAll("#", "")}")),
                                                          child:null,
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
                                                            "${controllerCategory.items[i-1].name}",
                                                            style: TextStyle(fontSize: 17),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              )),
                                        );
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
