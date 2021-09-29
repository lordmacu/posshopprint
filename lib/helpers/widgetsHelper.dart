import 'package:flutter/material.dart';
import 'package:loading_hud/loading_hud.dart';
import 'package:loading_hud/loading_indicator.dart';
import 'package:rflutter_alert/rflutter_alert.dart';


class WidgetsHelper{
  initLoading(context){
    return LoadingHud(
      context,
      cancelable: true,                  // Cancelable when pressing Android back key
      canceledOnTouchOutside: true,      // Cancelable when touch outside of the LoadingHud
      dimBackground: true,               // Dimming background when LoadingHud is showing
      hudColor: Color(0x99000000),       // Color of the ProgressHud
      indicator: DefaultLoadingIndicator(
        color: Colors.white,
      ),
      iconSuccess: Icon(                 // Success icon
        Icons.done,
        color: Colors.white,
      ),
      iconError: Icon(                   // Error icon
        Icons.error,
        color: Colors.white,
      ),

    );
  }

  defaultAlert(context,error,title,text){
    AlertType errorTitle;
    if(error=="warning"){
       errorTitle=AlertType.warning;
    }
    if(error=="error"){
      errorTitle=AlertType.error;
    }
    return Alert(
      context: context,
      type: errorTitle,
      title:title,
      desc: text,
      buttons: [
        DialogButton(
          radius: BorderRadius.circular(20),
          child: Text(
            "Entendido",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: () => Navigator.pop(context),
          color:  Color(0xff298dcf),
          
        ),

      ],
    ).show();
  }
}