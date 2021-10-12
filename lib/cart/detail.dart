import 'package:flutter/material.dart';
import 'package:poshop/products/controllers/ProductContoller.dart';
import 'package:sliding_switch/sliding_switch.dart';
import 'package:pop_bottom_menu/pop_bottom_menu.dart';
import 'package:easy_mask/easy_mask.dart';
import 'package:o_color_picker/o_color_picker.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class DetailProduct extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  ProductContoller controllerHome = Get.find();

  void getImage() async{
    final ImagePicker _picker = ImagePicker();
   var image = await _picker.getImage(source: ImageSource.gallery);

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
                              Navigator.of(context).pop();
                            },
                            child: Container(
                              padding: EdgeInsets.only(left: 10, right: 10),
                              child: Image.asset("assets/pentagon.png"),
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
        return PopBottomMenu(
          title: TitlePopBottomMenu(
            label: "Categorías",
          ),
          items: [
            ItemPopBottomMenu(
              onPressed: () => print("notifications"),
              label: "Categorias",
              icon: Icon(
                Icons.circle,
                color: Colors.grey,
              ),
            ),
            ItemPopBottomMenu(
              onPressed: () => print("notifications"),
              label: "Categorias",
              icon: Icon(
                Icons.circle,
                color: Colors.grey,
              ),
            ),
            ItemPopBottomMenu(
              onPressed: () => print("notifications"),
              label: "Categorias",
              icon: Icon(
                Icons.circle,
                color: Colors.grey,
              ),
            ),
            ItemPopBottomMenu(
              onPressed: () => print("notifications"),
              label: "Categorias",
              icon: Icon(
                Icons.circle,
                color: Colors.grey,
              ),
            ),
            ItemPopBottomMenu(
              onPressed: () => print("notifications"),
              label: "Categorias",
              icon: Icon(
                Icons.circle,
                color: Colors.grey,
              ),
            ),
            ItemPopBottomMenu(
              onPressed: () => print("notifications"),
              label: "Categorias",
              icon: Icon(
                Icons.circle,
                color: Colors.grey,
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      padding: EdgeInsets.only(top: 20, left: 20, right: 20),
      child: Column(
        children: [
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                    child: Container(
                  margin: EdgeInsets.only(top: 5),
                  child: Text(
                    "Nombre del producto",
                    style: TextStyle(fontSize: 18, color: Colors.grey),
                  ),
                )),
                Row(
                  children: [
                    RaisedButton(
                      onPressed: () {
                        if (_formKey.currentState.validate()) {}
                      },
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                      color: Color(0xff298dcf),
                      child: Text(
                        "Guardar",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(bottom: 10, top: 10),
            height: 1,
            child: null,
            color: Colors.grey.withOpacity(0.3),
          ),
          Container(
            child: Form(
              key: _formKey,
              child: SingleChildScrollView(
                child: Container(
                  child: Obx(()=>Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      controllerHome.step.value==0 ? Column(
                        children: [
                          TextFormField(
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
                                        color: Color(0xff298dcf),
                                        onPressed: () {
                                          _showMenu(context);
                                        },
                                        child: Row(
                                          children: [
                                            Expanded(
                                                child: Text(
                                                  "Categoría",
                                                  style: TextStyle(color: Colors.white),
                                                )),
                                            Icon(
                                              Icons.keyboard_arrow_down_rounded,
                                              color: Colors.white,
                                            )
                                          ],
                                        ),
                                      ),
                                    )),
                                Expanded(
                                    child: Container(
                                      child: SlidingSwitch(
                                        value: false,
                                        width: 160,
                                        onChanged: (bool value) {
                                          print(value);
                                        },
                                        height: 40,
                                        animationDuration:
                                        const Duration(milliseconds: 100),
                                        onTap: () {},
                                        onDoubleTap: () {},
                                        onSwipe: () {},
                                        textOff: "Unidad",
                                        textOn: "Peso",
                                        colorOn: const Color(0xff298dcf),
                                        colorOff: const Color(0xff298dcf),
                                        background: const Color(0xffe4e5eb),
                                        buttonColor: const Color(0xfff7f5f7),
                                        inactiveColor: const Color(0xff636f7b),
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
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return 'Please enter some text';
                                          }
                                          return null;
                                        },
                                        decoration: InputDecoration(
                                            labelText: "Precio",
                                            hintText:
                                            "Escribe el precio del producto"),
                                        inputFormatters: [
                                          TextInputMask(
                                              mask: '\$! !9+,999.99',
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
                                              mask: '\$! !9+,999.99',
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
                            margin: EdgeInsets.only(top: 30),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                RaisedButton(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(30.0),
                                    ),
                                    color:Colors.white,
                                    child: Row(
                                      children: [
                                        Text(
                                          "Imágen y Color",
                                          style: TextStyle(color:Color(0xff298dcf)),
                                        ),
                                        Container(
                                          margin: EdgeInsets.only(left: 10),
                                          child: Icon(
                                            Icons.arrow_forward_ios,
                                            color: Color(0xff298dcf),
                                            size: 15,
                                          ),
                                        )
                                      ],
                                    ),
                                    onPressed: () {
                                      controllerHome.step.value=1;
                                    })
                              ],
                            ),
                          )
                        ],
                      ):
                      Column(
                        children: [
                          Container(
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
                                                            .categorySelect.value),
                                                    colors: primaryColorsPalette,
                                                    onColorChange: (color) {
                                                      controllerHome.categorySelect
                                                          .value = color.value;
                                                      print(
                                                          "este es el color ${color.value}");
                                                      Navigator.of(context).pop();
                                                    },
                                                  ),
                                                ],
                                              ),
                                            ),
                                          );
                                        },
                                        color: Color(
                                            controllerHome.categorySelect.value),
                                        child: Row(
                                          children: [
                                            Expanded(
                                                child: Text(
                                                  "Seleccionar Color",
                                                  style: TextStyle(color: Colors.white),
                                                  textAlign: TextAlign.center,
                                                )),
                                            Icon(
                                              Icons.keyboard_arrow_down_rounded,
                                              color: Colors.white,
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
                                                width: 80,
                                                padding: EdgeInsets.only(
                                                    left: 10,
                                                    right: 10,
                                                    top: 10,
                                                    bottom: 10),
                                                child: Image.asset(
                                                  "assets/${controllerHome.selectedForm.value}",
                                                  width: 60,
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
                          ),
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

                                    Text(
                                      "Seleccionar imágen",
                                     ),
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
                                  getImage();
                                }) ,
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 30),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                RaisedButton(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(30.0),
                                    ),
                                    color: Colors.white,
                                    child: Row(
                                      children: [
                                        Container(
                                          margin: EdgeInsets.only(right: 10),
                                          child: Icon(
                                            Icons.arrow_back_ios,
                                            color: Color(0xff298dcf),
                                            size: 15,
                                          ),
                                        ),
                                        Text(
                                          "Imágen y Color",
                                          style: TextStyle(color: Color(0xff298dcf)),
                                        ),

                                      ],
                                    ),
                                    onPressed: () {
                                      controllerHome.step.value=0;
                                    })
                              ],
                            ),
                          )
                        ],
                      ),
                    ],
                  )),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
