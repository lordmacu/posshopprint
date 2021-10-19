import 'package:flutter/material.dart';
import 'package:poshop/categories/controllers/CategoryController.dart';
import 'package:poshop/products/controllers/ProductContoller.dart';
import 'package:sliding_switch/sliding_switch.dart';
import 'package:pop_bottom_menu/pop_bottom_menu.dart';
import 'package:easy_mask/easy_mask.dart';
import 'package:o_color_picker/o_color_picker.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:poshop/helpers/widgetsHelper.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';


class DetailProduct extends StatelessWidget {



   ProductContoller controllerHome = Get.find();
  CategoryContoller controllerCategory = Get.find();
  WidgetsHelper helpers = WidgetsHelper();
   var loadingHud;

  void getImage(context) async{


    selectImage(context);
  }

   void selectImage(context) {
     final ImagePicker _picker = ImagePicker();
     showModalBottomSheet(
       backgroundColor: Colors.transparent,
       context: context,
       builder: (context) {

         return PopBottomMenu(
           title: TitlePopBottomMenu(
             label: "Categorías",
           ),
           items: [
             ItemPopBottomMenu(
               onPressed: () async{

                 var image = await _picker.getImage(source: ImageSource.gallery);
                 controllerHome.image.value=image.path;
                 loadingHud.show();

                  var imageFinal = await controllerHome.uploadImage();
                 controllerHome.imageUpload.value=imageFinal;



                 loadingHud.dismiss();

                 Navigator.of(context).pop();


               },
               label: "Gallería",
               icon: Icon(
                 Icons.image_outlined,
                 color: Colors.black,
               ),
             ),
             ItemPopBottomMenu(
               onPressed: () async {

                 var image = await _picker.getImage(source: ImageSource.camera);

                  controllerHome.image.value=image.path;
                 loadingHud.show();

                var imageFinal = await controllerHome.uploadImage();
                 controllerHome.imageUpload.value=imageFinal;


                 loadingHud.dismiss();


                 Navigator.of(context).pop();

               },
               label: "Cámara",
               icon: Icon(
                 Icons.camera,
                 color: Colors.black,
               ),
             )
           ],
         );
       },
     );
   }

  void _showMenuForm(context) {
    showModalBottomSheet(
      backgroundColor: Colors.transparent,
      context: context,
      builder: (context) {
        return ClipRRect(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(16.0),
            topRight: Radius.circular(16.0),
          ),
          child: Container(
            color: Colors.white,
            child: Wrap(
              alignment: WrapAlignment.center,
              children: [
                Column(
                  children: [
                    Container(
                      child: Column(
                        children: [
                          Container(
                            height: 10,
                          ),
                          ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: Container(
                              height: 5,
                              width: 40,
                              color: Color(0x80808080),
                            ),
                          ),
                          GestureDetector(
                            child: Container(
                              padding: EdgeInsets.only(top: 15, bottom: 15),
                              child: Text(
                                "Seleccione una forma",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                          Container(
                            height: 1,
                            color: Color(0x1A1A1A1A),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(
                          top: 20, bottom: 20, left: 20, right: 20),
                      child: Row(
                        children: [
                          Expanded(
                              child: GestureDetector(
                            onTap: () {
                              controllerHome.selectedForm.value = "square.png";
                              controllerHome.isFormSelected.value = true;
                              controllerHome.shape.value = "SQUARE";

                              Navigator.of(context).pop();
                            },
                            child: Container(
                              padding: EdgeInsets.only(left: 10, right: 10),
                              child: Image.asset("assets/square.png"),
                            ),
                          )),
                          Expanded(
                              child: GestureDetector(
                            onTap: () {
                              controllerHome.selectedForm.value = "circle.png";
                              controllerHome.isFormSelected.value = true;
                              controllerHome.shape.value = "CIRCLE";

                              Navigator.of(context).pop();
                            },
                            child: Container(
                              padding: EdgeInsets.only(left: 10, right: 10),
                              child: Image.asset("assets/circle.png"),
                            ),
                          )),
                          Expanded(
                              child: GestureDetector(
                            onTap: () {
                              controllerHome.selectedForm.value = "star.png";
                              controllerHome.isFormSelected.value = true;
                              controllerHome.shape.value = "SUN";

                              Navigator.of(context).pop();
                            },
                            child: Container(
                              padding: EdgeInsets.only(left: 10, right: 10),
                              child: Image.asset("assets/star.png"),
                            ),
                          )),
                          Expanded(
                              child: GestureDetector(
                            onTap: () {
                              controllerHome.selectedForm.value =
                                  "pentagon.png";
                              controllerHome.isFormSelected.value = true;
                              controllerHome.shape.value = "HEXAGON";

                              Navigator.of(context).pop();
                            },
                            child: Container(
                              padding: EdgeInsets.only(left: 10, right: 10),
                              child: Image.asset("assets/pentagon.png"),
                            ),
                          )),
                          Expanded(
                              child: GestureDetector(
                                onTap: () {
                                  controllerHome.selectedForm.value =
                                  "pentagon.png";
                                  controllerHome.isFormSelected.value = false;
                                  controllerHome.shape.value = "";

                                  Navigator.of(context).pop();
                                },
                                child: Container(
                                  padding: EdgeInsets.only(left: 10, right: 10),
                                  child: Text("Sin forma",textAlign: TextAlign.center,),
                                ),
                              ))
                        ],
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _showMenu(context) {




    showModalBottomSheet(
      backgroundColor: Colors.transparent,
      context: context,
      builder: (context) {

        List<ItemPopBottomMenu> items= [];

        for(var i =0 ; i < controllerCategory.items.length ; i++ ){

          var color = "0xff${controllerCategory.items[i].color.replaceAll("#", "")}";

          items.add(ItemPopBottomMenu(
            onPressed: () {

              controllerHome.selectedCategory.value=controllerCategory.items[i].id;
              controllerHome.selectedCategoryName.value=controllerCategory.items[i].name;

              Navigator.of(context).pop();

            },
            label: controllerCategory.items[i].name,
            icon: Icon(
              Icons.circle,
              color: controllerHome.selectedCategory == controllerCategory.items[i].id ? Color(int.parse(color)) : Colors.grey.withOpacity(0.5),
            ),
          ));
        }

        return PopBottomMenu(
          title: TitlePopBottomMenu(
            label: "Categorías",
          ),
          items: items,
        );
      },
    );
  }
  @override
  Widget build(BuildContext context) {
    loadingHud = helpers.initLoading(context);
    FocusScopeNode currentFocus = FocusScope.of(context);

    // TODO: implement build
    return Scaffold(
      bottomNavigationBar: Container(
        padding: EdgeInsets.only(left: 20,right: 20,bottom: 10),
         width: double.infinity,
        child: RaisedButton(
          padding: EdgeInsets.only(top: 15, bottom: 15),
          onPressed: () async {

            if (controllerHome.formKey.value.currentState.validate()) {
              var canSubmit=true;

              if(controllerHome.isImagen.value){
                if(!controllerHome.isFormSelected.value){
                  helpers.defaultAlert(context, "warning", "Error en creación", "Por favor seleccione una forma");
                  canSubmit=false;
                }
                if(!controllerHome.isSelectedColor.value){
                  helpers.defaultAlert(context, "warning", "Error en creación", "Por favor seleccione el color");
                  canSubmit=false;
                }
              }

            if(controllerHome.selectedCategory.value==0){
              helpers.defaultAlert(context, "warning", "Error en creación", "Por favor seleccione la categoría");
              canSubmit=false;
            }
              if(canSubmit){
                if(controllerHome.item_id.value!=0){
                  await controllerHome.createProduct();
                }else{
                  await controllerHome.updateProduct();
                }
                controllerHome.resetCreationProduct();
                controllerHome.panelController.value.close();

              }

            }
          },

          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.0),
          ),
          color: Color(0xff298dcf),
          child: Text(
            "Crear producto",
            style: TextStyle(color: Colors.white, fontSize: 17),
          ),
        ),
      )
      ,
      body: Container(

        padding: EdgeInsets.only(top: 20, left: 20, right: 20),
        child: Column(

          children: [

            Expanded(child: SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.only(bottom: 20),
                child: Form(
                  key: controllerHome.formKey.value,
                  child:Container(

                    child: Obx(()=>Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        controllerHome.step.value==0 ? Column(
                          mainAxisSize: MainAxisSize.min,

                          children: [
                            TextFormField(
                              onChanged: (value){
                                controllerHome.item_name.value=value;
                              },
                              decoration: InputDecoration(
                                  labelText: "Nombre",
                                  hintText: "Escribe el nombre del producto"),
                              // The validator receives the text that the user has entered.
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter some text';
                                }
                                return null;
                              },
                            ),
                            Container(
                              margin: EdgeInsets.only(top: 20),
                              child: Row(
                                children: [
                                  Expanded(
                                      child: Container(
                                        margin: EdgeInsets.only(right: 10),
                                        child: RaisedButton(
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(30.0),
                                          ),
                                          color: Colors.white,
                                          onPressed: () {
                                            _showMenu(context);
                                          },
                                          child: Row(
                                            children: [
                                              Expanded(
                                                  child: Text(
                                                    controllerHome.selectedCategory.value == 0 ?  "Categoría" :controllerHome.selectedCategoryName.value  ,
                                                    style: TextStyle(color: Color(0xff298dcf)),
                                                  )),
                                              Icon(
                                                Icons.keyboard_arrow_down_rounded,
                                                color: Color(0xff298dcf),
                                              )
                                            ],
                                          ),
                                        ),
                                      )),
                                  Expanded(
                                      child: Container(
                                        child: FlutterSwitch(

                                          value: controllerHome.divisible.value,
                                          activeText: "Unidad",
                                          inactiveText: "Peso",
                                          width: 100,
                                          borderRadius: 30.0,
                                          padding: 8.0,
                                          showOnOff: true,
                                          onToggle: (val) {

                                            controllerHome.divisible.value=val;

                                          },
                                        ),
                                      ))
                                ],
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(top: 10),
                              child: Row(
                                children: [
                                  Expanded(
                                      child: Container(
                                        padding: EdgeInsets.only(right: 5),
                                        child: TextFormField(
                                          keyboardType: TextInputType.number,

                                          validator: (value) {
                                            if (value == null || value.isEmpty) {
                                              return 'Please enter some text';
                                            }
                                            return null;
                                          },
                                          onChanged: (value){
                                            value= value.replaceAll("\$", "");
                                            value= value.replaceAll(" ", "");
                                            value= value.replaceAll(".", "");

                                            controllerHome.salePrice.value="${value}";

                                          },
                                          decoration: InputDecoration(
                                              labelText: "Precio",
                                              hintText:
                                              "Escribe el precio del producto"),
                                          inputFormatters: [
                                            TextInputMask(
                                                mask: '\$! !9+.99',
                                                placeholder: '0',
                                                maxPlaceHolders: 3,
                                                reverse: true)
                                          ],
                                        ),
                                      )),
                                  Expanded(
                                      child: Container(
                                        padding: EdgeInsets.only(left: 5),
                                        child: TextFormField(
                                          keyboardType: TextInputType.number,

                                          onChanged: (value){
                                            value= value.replaceAll("\$", "");
                                            value= value.replaceAll(" ", "");
                                            value= value.replaceAll(".", "");

                                            controllerHome.primeCost.value="${value}";
                                          },
                                          validator: (value) {
                                            if (value == null || value.isEmpty) {
                                              return 'Please enter some text';
                                            }
                                            return null;
                                          },
                                          decoration: InputDecoration(
                                              labelText: "Coste",
                                              hintText:
                                              "Escribe el coste del producto"),
                                          inputFormatters: [
                                            TextInputMask(
                                                mask: '\$! !9+.999',
                                                placeholder: '0',
                                                maxPlaceHolders: 3,
                                                reverse: true)
                                          ],
                                        ),
                                      ))
                                ],
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(top: 10),
                              child: Row(
                                children: [
                                  Expanded(
                                      child: Container(
                                        margin: EdgeInsets.only(right: 5),
                                        child: TextFormField(
                                          onChanged: (value){
                                            controllerHome.reference.value="${value}";

                                          },
                                          decoration: InputDecoration(
                                              labelText: "Referencia",
                                              hintText:
                                              "Escribe la referencia del producto"),
                                          // The validator receives the text that the user has entered.
                                          validator: (value) {
                                            if (value == null || value.isEmpty) {
                                              return 'Please enter some text';
                                            }
                                            return null;
                                          },
                                        ),
                                      )),
                                  Expanded(
                                      child: Container(
                                        margin: EdgeInsets.only(left: 5),
                                        child: TextFormField(
                                          onChanged: (value){
                                            controllerHome.barcode.value="${value}";
                                          },
                                          decoration: InputDecoration(
                                              labelText: "Código de barras",
                                              hintText:
                                              "Escribe el Código de barras del producto"),
                                          // The validator receives the text that the user has entered.
                                          validator: (value) {
                                            if (value == null || value.isEmpty) {
                                              return 'Please enter some text';
                                            }
                                            return null;
                                          },
                                        ),
                                      ))
                                ],
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(top: 20),
                              child:  Obx(()=>FlutterSwitch(

                                value: controllerHome.isImagen.value,
                                activeText: "Color y forma",
                                inactiveText: "Imágen",
                                width: controllerHome.isImagen.value ? 150 : 110,
                                borderRadius: 30.0,
                                padding: 8.0,
                                showOnOff: true,
                                onToggle: (val) {
                                  if(val){
                                    controllerHome.imageUpload.value="";
                                  }

                                  controllerHome.isImagen.value= val;
                                },
                              )),
                            ),
                            controllerHome.isImagen.value ? Container(
                              margin: EdgeInsets.only(top: 20),
                              child: Row(
                                children: [
                                  Expanded(
                                      child: Container(
                                        margin: EdgeInsets.only(right: 5),
                                        child: Obx(() => RaisedButton(
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(30.0),
                                          ),
                                          onPressed: () {
                                            currentFocus.unfocus();

                                            showDialog<void>(
                                              context: context,
                                              builder: (_) => Material(
                                                child: Column(
                                                  mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                                  children: <Widget>[
                                                    OColorPicker(
                                                      selectedColor: Color(
                                                          controllerHome
                                                              .selectedColor.value),
                                                      colors: primaryColorsPalette,
                                                      onColorChange: (color) {
                                                        controllerHome.selectedColor
                                                            .value = color.value;

                                                        controllerHome.isSelectedColor
                                                            .value = true;

                                                        controllerHome.color.value= "#${color.value.toRadixString(16)}";
                                                        Navigator.of(context).pop();
                                                      },
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            );
                                          },
                                          color: Color(
                                              controllerHome.selectedColor.value),
                                          child: Row(
                                            children: [
                                              Expanded(
                                                  child: Text(
                                                    "Color",
                                                    style: TextStyle(color: !controllerHome.isSelectedColor
                                                        .value ? Color(0xff298dcf) : Colors.white),
                                                    textAlign: TextAlign.center,
                                                  )),
                                              Icon(
                                                Icons.keyboard_arrow_down_rounded,
                                                color: !controllerHome.isSelectedColor
                                                    .value ? Color(0xff298dcf) : Colors.white,
                                              )
                                            ],
                                          ),
                                        )),
                                      )),
                                  Expanded(
                                      child: Container(
                                        margin: EdgeInsets.only(left: 5),
                                        child: Obx(() => RaisedButton(
                                          color: Colors.white,
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(30.0),
                                          ),
                                          onPressed: () {
                                            currentFocus.unfocus();

                                            _showMenuForm(context);
                                          },
                                          child: !controllerHome.isFormSelected.value
                                              ? Row(
                                            children: [
                                              Expanded(
                                                  child: Text(
                                                    "Seleccionar forma",
                                                    textAlign: TextAlign.center,
                                                  )),
                                              Icon(
                                                Icons
                                                    .keyboard_arrow_down_rounded,
                                              )
                                            ],
                                          )
                                              : Container(
                                            child: Row(
                                              mainAxisAlignment:
                                              MainAxisAlignment
                                                  .spaceBetween,
                                              children: [
                                                Container(
                                                  width: 50,
                                                  padding: EdgeInsets.only(
                                                      left: 10,
                                                      right: 10,
                                                      top: 5,
                                                      bottom: 5),
                                                  child: Image.asset(
                                                    "assets/${controllerHome.selectedForm.value}",
                                                    width: 50,
                                                  ),
                                                ),
                                                Icon(
                                                  Icons
                                                      .keyboard_arrow_down_rounded,
                                                )
                                              ],
                                            ),
                                          ),
                                        )),
                                      )),
                                ],
                              ),
                            ):
                            Container(
                              margin: EdgeInsets.only(top: 20),
                              child: RaisedButton(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30.0),
                                  ),
                                  color: Colors.white,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [

                                      Obx(()=>Expanded(child: Text(
                                        controllerHome.imageUpload.value == "" ?  "Seleccionar imágen" : controllerHome.imageUpload.value,
                                      ))),
                                      Container(
                                        margin: EdgeInsets.only(left: 10),
                                        child: Icon(
                                          Icons.camera_alt,
                                          size: 25,
                                        ),
                                      ),

                                    ],
                                  ),
                                  onPressed: () {
                                    getImage(context);
                                  }) ,
                            )

                          ],
                        ):
                        Container(),

                      ],
                    )),
                  ),
                ),
              ),
            ))
          ],
        ),
      ),
    );
  }
}
