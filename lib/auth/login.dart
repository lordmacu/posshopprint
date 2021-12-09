import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:loading_hud/loading_hud.dart';
import 'package:loading_hud/loading_indicator.dart';
import 'package:pop_bottom_menu/pop_bottom_menu.dart';
import 'package:poshop/auth/controllers/AuthController.dart';
import 'package:get/get.dart';
import 'package:poshop/categories/controllers/CategoryController.dart';
import 'package:poshop/helpers/widgetsHelper.dart';
import 'package:poshop/home/home.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:validators/validators.dart';

class Login extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  AuthContoller controllerAuth = Get.put(AuthContoller());
  CategoryContoller controllerCategory = Get.put(CategoryContoller());

  WidgetsHelper helpers = WidgetsHelper();
  var loadingHud;

  loginUser(context) async {
    loadingHud.show();

    var isLoggedApi = await controllerAuth.login();

    loadingHud.dismiss();

    if (isLoggedApi["token"]==null) {
      helpers.defaultAlert(context, "error", "${isLoggedApi["message"]}",
          "${isLoggedApi["data"]}");
    } else {
     var  prefs = await SharedPreferences.getInstance();

      prefs.setString("token", isLoggedApi["token"]);
      prefs.setInt("idOrg", isLoggedApi["idOrg"]);
     prefs.setString("user", jsonEncode(isLoggedApi["user"]));


      print("este es el array del login  ${isLoggedApi["user"]["outlets"]}");
      _showMenu(context,isLoggedApi["user"]["outlets"]);

    }
  }

  void _showMenu(context,outlets) {


    List<ItemPopBottomMenu> items=[];

    for(var i =0; i < outlets.length; i ++){

      for(var c =0; c < outlets[i]["cash_registers"].length; c++){
        items.add(ItemPopBottomMenu(
          onPressed: () async{
            SharedPreferences prefs;

            prefs = await SharedPreferences.getInstance();

            prefs.setString("outlet", jsonEncode(outlets[i]));
            prefs.setInt("outletId", outlets[i]["id"]);


            prefs.setString("cashier", jsonEncode(outlets[i]["cash_registers"][c]));
            prefs.setInt("cashierId", outlets[i]["cash_registers"][c]["id"]);
            prefs.setBool("isLogged", true);

            await controllerAuth.cashRegister();

           await controllerCategory.getCategories();


            Get.to(() => Home());


          },
          label: "${outlets[i]["name"]} ${outlets[i]["cash_registers"][c]["name"]} ",
          icon: Icon(
            Icons.circle,
            color: Colors.grey,
          ),
        ));
      }

    }

    showModalBottomSheet(
      backgroundColor: Colors.transparent,
      context: context,
      builder: (context) {
        return PopBottomMenu(
          title: TitlePopBottomMenu(
            label: "Seleccionar outlets",
          ),
          items: items,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    loadingHud = helpers.initLoading(context);
    // TODO: implement build

    return Container(
      padding: EdgeInsets.only(left: 20, right: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                children: [
                  Container(
                    margin: EdgeInsets.only(bottom: 15),
                    child: Text(
                      "Bienvenido a Posshop",
                      style:
                          TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Container(
                    child: Text("Subtitilo del saludo"),
                  )
                ],
              )
            ],
          ),
          Container(
            margin: EdgeInsets.only(top: 50),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                        color: Color(0xfff0ecf1),
                        borderRadius: BorderRadius.circular(10)),
                    margin: EdgeInsets.only(bottom: 15),
                    padding: EdgeInsets.only(
                        top: 10, bottom: 0, left: 20, right: 20),
                    child: TextFormField(
                      keyboardType: TextInputType.emailAddress,

                      decoration: InputDecoration(
                        hintText: 'Ingresa el email',
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.transparent),
                        ),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.transparent),
                        ),
                        labelText: "Email",
                      ),
                      onChanged: (text){

                        controllerAuth.email.value=text;
                      },
                      // The validator receives the text that the user has entered.
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Por favor ingrese el email';
                        }
                        if (!isEmail(value)) {
                          return 'Ingresa un email válido';
                        }
                        return null;
                      },
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(bottom: 20),
                    decoration: BoxDecoration(
                        color: Color(0xfff0ecf1),
                        borderRadius: BorderRadius.circular(10)),
                    padding: EdgeInsets.only(
                        top: 10, bottom: 0, left: 20, right: 20),
                    child: TextFormField(
                      decoration: InputDecoration(
                        hintText: 'Ingresa la contraseña',
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.transparent),
                        ),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.transparent),
                        ),
                        labelText: "Contraseña",
                      ),
                      onChanged: (text){

                        controllerAuth.password.value=text;
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Por favor ingrese la contraseña';
                        }
                        return null;
                      },
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(bottom: 10),
                    width: double.infinity,
                    child: RaisedButton(
                      padding: EdgeInsets.only(top: 15, bottom: 15),
                      onPressed: () async {
                        if (_formKey.currentState.validate()) {
                          await loginUser(context);
                        }
                      },
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                      color: Color(0xff298dcf),
                      child: Text(
                        "Ingresar",
                        style: TextStyle(color: Colors.white, fontSize: 17),
                      ),
                    ),
                  ),
                  Container(
                    child: Text(
                      "¿Olvidaste contraseña?",
                      style: TextStyle(color: Color(0xff298dcf)),
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
