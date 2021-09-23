import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:poshop/auth/login.dart';
import 'package:poshop/auth/register.dart';
import 'package:poshop/helpers/animationBackground.dart';
import 'package:poshop/auth/controllers/AuthController.dart';
import 'package:get/get.dart';

class Auth extends StatelessWidget{
  final _formKey = GlobalKey<FormState>();
  AuthContoller controllerAuth = Get.put(AuthContoller());

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          AnimationBackground(),

          Obx(()=>Center(
            child: Container(
              child:controllerAuth.isLogin.value ? Login() : Register() ,
            ),
          )),


          Obx(()=>Align(
            alignment: Alignment.bottomCenter,
            child: Container(
               child: controllerAuth.isLogin.value ? GestureDetector(
                onTap: (){
                  controllerAuth.isLogin.value=false;
                },
                child: Container(
                  padding: EdgeInsets.only(top: 20,bottom: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        child: Text("¿Aún no tienes una cuenta?"),
                      ),

                      Container(
                        margin: EdgeInsets.only(left: 5),
                        child: Text("Registrate!",style: TextStyle(color: Color(0xff298dcf),fontWeight: FontWeight.bold),),
                      )
                    ],
                  ),
                ),
              ): GestureDetector(
                onTap: (){
                  controllerAuth.isLogin.value=true;

                },
                child: Container(
                  padding: EdgeInsets.only(top: 20,bottom: 20),

                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        child: Text("¿Ya una cuenta?"),
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 5),
                        child: Text("Ingresar!",style: TextStyle(color: Color(0xff298dcf),fontWeight: FontWeight.bold),),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ))
        ],
      ),
    );
  }

}