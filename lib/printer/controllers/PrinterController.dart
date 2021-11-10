import 'package:esc_pos_bluetooth/esc_pos_bluetooth.dart';
import 'package:get/get.dart';
import 'package:poshop/api_client.dart';
import 'package:poshop/checkout/models/DiscountSimple.dart';
import 'package:poshop/checkout/models/ItemSimple.dart';
import 'package:poshop/checkout/models/PaymentSimple.dart';
import 'package:poshop/tickets/model/Ticket.dart';
import 'package:poshop/tickets/ticket_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

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



class PrinterContoller extends GetxController {

  var printerManager = PrinterBluetoothManager();

  RxList<PrinterBluetooth> devices = RxList<PrinterBluetooth>();

  @override
  void onInit() async {
    printerManager.scanResults.listen((devices) async {
      devices = devices;
    });
    printerManager.startScan(Duration(seconds: 4));
  }


  Future<T.Ticket> testTicket() async {
    final T.Ticket ticket = T.Ticket(PaperSize.mm58);

    ticket.text(
        'Regular: aA bB cC dD eE fF gG hH iI jJ kK lL mM nN oO pP qQ rR sS tT uU vV wW xX yY zZ');
    ticket.text('Special 1: àÀ èÈ éÉ ûÛ üÜ çÇ ôÔ',
        styles: PosStyles(codeTable: PosCodeTable.westEur));
    ticket.text('Special 2: blåbærgrød',
        styles: PosStyles(codeTable: PosCodeTable.westEur));

    ticket.text('Bold text', styles: PosStyles(bold: true));
    ticket.text('Reverse text', styles: PosStyles(reverse: true));
    ticket.text('Underlined text',
        styles: PosStyles(underline: true), linesAfter: 1);
    ticket.text('Align left', styles: PosStyles(align: PosAlign.left));
    ticket.text('Align center', styles: PosStyles(align: PosAlign.center));
    ticket.text('Align right',
        styles: PosStyles(align: PosAlign.right), linesAfter: 1);

    ticket.row([
      PosColumn(
        text: 'col3',
        width: 3,
        styles: PosStyles(align: PosAlign.center, underline: true),
      ),
      PosColumn(
        text: 'col6',
        width: 6,
        styles: PosStyles(align: PosAlign.center, underline: true),
      ),
      PosColumn(
        text: 'col3',
        width: 3,
        styles: PosStyles(align: PosAlign.center, underline: true),
      ),
    ]);

    ticket.text('Text size 200%',
        styles: PosStyles(
          height: PosTextSize.size2,
          width: PosTextSize.size2,
        ));




    final List<int> barData = [1, 2, 3, 4, 5, 6, 7, 8, 9, 0, 4];
    ticket.barcode(Barcode.upcA(barData));



    ticket.feed(2);
    return ticket;
  }


  allScan(){

  }


  void testPrint(PrinterBluetooth printer) async {
    printerManager.selectPrinter(printer);


    final PosPrintResult res =
    await printerManager.printTicket(await testTicket());
  }


}
