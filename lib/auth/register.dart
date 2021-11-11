import 'package:flutter/material.dart';
import 'package:poshop/auth/controllers/AuthController.dart';
 import 'package:poshop/helpers/countries/csc_picker.dart';
import 'package:poshop/home/home.dart';
import 'package:get/get.dart';
import 'package:poshop/helpers/widgetsHelper.dart';

class Register extends StatelessWidget{
  final _formKey = GlobalKey<FormState>();
  AuthContoller controllerAuth = Get.put(AuthContoller());
  var loadingHud;
  WidgetsHelper helpers = WidgetsHelper();

  registerUser(context) async {
    loadingHud.show();

    var isLoggedApi = await controllerAuth.register();
    loadingHud.dismiss();

    if (isLoggedApi!="ok") {
      helpers.defaultAlert(context, "error", "${isLoggedApi["message"]}",
          "${isLoggedApi["data"]}");
    } else {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => Home()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    loadingHud = helpers.initLoading(context);

    // TODO: implement build

    return Container(
      padding: EdgeInsets.only(left: 20,right: 20),
      child: SingleChildScrollView(
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
                      child: Text("Registrate a Posshop",style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),),
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
                          borderRadius: BorderRadius.circular(10)
                      ),
                      margin: EdgeInsets.only(bottom: 15),
                      padding: EdgeInsets.only(top: 10,bottom: 0,left: 20,right: 20),
                      child: TextFormField(
                        onChanged: (value){
                          controllerAuth.email.value=value;

                        },
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
                      margin: EdgeInsets.only(bottom: 20),
                      decoration: BoxDecoration(
                          color: Color(0xfff0ecf1),
                          borderRadius: BorderRadius.circular(10)
                      ),
                      padding: EdgeInsets.only(top: 10,bottom: 0,left: 20,right: 20),
                      child: TextFormField(
                        onChanged: (value){
                          controllerAuth.password.value=value;

                        },
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
                        // The validator receives the text that the user has entered.
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Por favor ingrese la contraseña';
                          }
                          return null;
                        },
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(bottom: 20),
                      decoration: BoxDecoration(
                          color: Color(0xfff0ecf1),
                          borderRadius: BorderRadius.circular(10)
                      ),
                      padding: EdgeInsets.only(top: 10,bottom: 0,left: 20,right: 20),
                      child: TextFormField(
                        onChanged: (value){
                          controllerAuth.business.value=value;

                        },
                        decoration: InputDecoration(

                          hintText: 'Ingresa el nombre de negocio',

                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.transparent),

                          ),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.transparent),

                          ),
                          labelText: "Nombre de negocio",
                        ),
                        // The validator receives the text that the user has entered.
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Por favor ingrese el nombre del negocio';
                          }
                          return null;
                        },
                      ),
                    ),

                    Container(
                      margin: EdgeInsets.only(bottom: 10,top: 20),

                      width: double.infinity,
                      child:  RaisedButton(
                        padding: EdgeInsets.only(top: 15,bottom: 15),
                        onPressed: () async {

                          if (_formKey.currentState.validate()) {
                            await registerUser(context);
                          }

                        },
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                        color: Color(0xff298dcf),
                        child: Text(
                          "Registrarme",
                          style: TextStyle(color: Colors.white,fontSize: 17),
                        ),
                      ),
                    ),
                    Container(
                      child: Text("¿Olvidaste contraseña?", style: TextStyle(color: Color(0xff298dcf)),),
                    )
                  ],
                ),
              ),
            )

          ],
        ),
      ),
    );
  }

}