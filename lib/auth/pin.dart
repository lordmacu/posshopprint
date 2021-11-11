import 'package:flutter/material.dart';
import 'package:loading_hud/loading_hud.dart';
import 'package:loading_hud/loading_indicator.dart';
import 'package:poshop/auth/controllers/AuthController.dart';
import 'package:get/get.dart';
import 'package:poshop/helpers/widgetsHelper.dart';
import 'package:poshop/home/home.dart';
import 'package:validators/validators.dart';
import 'package:pinput/pin_put/pin_put.dart';

class Pin extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  AuthContoller controllerAuth = Get.put(AuthContoller());

  WidgetsHelper helpers = WidgetsHelper();
  var loadingHud;
  final TextEditingController _pinPutController = TextEditingController();
  final FocusNode _pinPutFocusNode = FocusNode();


  BoxDecoration get _pinPutDecoration {
    return BoxDecoration(
      border: Border.all(color:  Color(0xff298dcf)),
      borderRadius: BorderRadius.circular(15.0),
    );
  }

  loginUserPin(context) async {
    loadingHud.show();

    var isLoggedApi = await controllerAuth.loginPin();
    loadingHud.dismiss();

    if (!isLoggedApi) {
      helpers.defaultAlert(context, "error", "Error al ingresar",
          "Por favor verifique la contraseña o el email.");
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

    return Scaffold(
      body: Container(
        padding: EdgeInsets.only(left: 40, right: 40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [

            Container(
              margin: EdgeInsets.only(bottom: 40),

              child: Text("Ingresa con el pin",style: TextStyle(fontSize: 25),),
            ),
            PinPut(
              fieldsCount: 4,
              onSubmit: (String pin) {

              },
              onChanged: (value){

                controllerAuth.pin.value=value;

              },
              focusNode: _pinPutFocusNode,
              controller: _pinPutController,
              submittedFieldDecoration: _pinPutDecoration.copyWith(
                borderRadius: BorderRadius.circular(20.0),
              ),
              selectedFieldDecoration: _pinPutDecoration,
              followingFieldDecoration: _pinPutDecoration.copyWith(
                borderRadius: BorderRadius.circular(5.0),
                border: Border.all(
                  color: Color(0xff298dcf).withOpacity(.5),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 40),
              width: double.infinity,
              child: RaisedButton(
                padding: EdgeInsets.only(top: 15, bottom: 15),
                onPressed: () async {
                  loginUserPin(context);
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
            )
          ],
        ),
      ),
    );
  }
}
