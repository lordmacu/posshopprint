import 'package:esc_pos_bluetooth/esc_pos_bluetooth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:poshop/printer/controllers/PrinterController.dart';

import 'package:poshop/tickets/model/Ticket.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:esc_pos_utils/esc_pos_utils.dart' as T;
import 'package:esc_pos_bluetooth/esc_pos_bluetooth.dart';
import 'package:flutter/services.dart';


import 'dart:typed_data';
import 'package:flutter/services.dart';
import 'package:image/image.dart';
import 'package:esc_pos_utils/esc_pos_utils.dart';
import 'package:esc_pos_bluetooth/esc_pos_bluetooth.dart';
import 'package:flutter/material.dart' hide Image;


class Printer extends StatelessWidget {

  PrinterContoller controllerPrinter= Get.put(PrinterContoller());




  @override
  Widget build(BuildContext context) {
    PanelController _panelController = PanelController();

    return Scaffold(
      appBar: AppBar(
        title: Text("Impresoras v2"),
      ),
      body: Container(
        child:Column(
          children: [
            Obx(()=>Container(
              child:Text(" comenzo a verificar  ${controllerPrinter.isPrintScaned.value}") ,
            )),
           Obx(()=> Container(
             child:Text(" impresoras detectadas  ${controllerPrinter.devices.length} ${controllerPrinter.devices}") ,
           )),
            Container(
              child: RaisedButton(
                onPressed: (){
                  controllerPrinter.startSscan();
                },
                child: Text("detectar scaner"),
              ),
            ),

            Expanded(child:  Obx(()=>ListView.builder(
                itemCount: controllerPrinter.devices.length,
                itemBuilder: (BuildContext context, int index) {
                  return InkWell(
                    onTap: () => controllerPrinter.testPrint(controllerPrinter.devices[index]),
                    child: Column(
                      children: <Widget>[
                        Container(
                          height: 60,
                          padding: EdgeInsets.only(left: 10),
                          alignment: Alignment.centerLeft,
                          child: Row(
                            children: <Widget>[
                              Icon(Icons.print),
                              SizedBox(width: 10),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Text(controllerPrinter.devices[index].name ?? ''),
                                    Text(controllerPrinter.devices[index].address),
                                    Text(
                                      'Click para imprimir',
                                      style: TextStyle(color: Colors.grey[700]),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                        Divider(),
                      ],
                    ),
                  );
                }))),
            Expanded(child:  Obx(()=>ListView.builder(
                itemCount: controllerPrinter.devicesBluethot.length,
                itemBuilder: (BuildContext context, int index) {
                  return Text("impresora  bluetooth ${controllerPrinter.devicesBluethot[index]["name"]}  ${controllerPrinter.devicesBluethot[index]["rssi"]}");
                })))
          ],
        ),
      ),
    );
  }
}
