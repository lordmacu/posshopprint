import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:poshop/clients/controllers/ClientController.dart';
import 'package:poshop/clients/ticketIndividualClient.dart';
import 'package:poshop/printer/model/Ticket.dart' as t;
import 'package:poshop/tickets/controllers/TicketsController.dart';
import 'package:poshop/tickets/model/Ticket.dart';
import 'package:poshop/tickets/ticketIndividual.dart';

class TicketsClient extends StatelessWidget{

  ClientContoller controllerClient = Get.put(ClientContoller());
TicketsContoller controllerTicket= Get.put(TicketsContoller());

  getTotalItem(ticket){
    var items=ticket.items;
    var taxes= ticket.taxes;
    var total= 0;

    for(var i =0  ; i  < items.length ; i++ ){

      print("aquiii cada uno o o asdf asd  ${items[i].ammout}  ${items[i].quantity} ");

      var salePrice=items[i].ammout/items[i].quantity;

      salePrice=salePrice*items[i].quantity;

      var discounts=items[i].discounts;
      if(discounts!=null){
        for(var d =0  ; d  < discounts.length ; d++ ){
          salePrice=salePrice-discounts[d].totalDiscount;
        }
      }
      total=total+(salePrice.toInt());
    }

    var totalDouble= total;

    for(var t =0 ; t <taxes.length; t ++){
      if(taxes[t].type=="INCLUDED"){
        totalDouble=totalDouble-int.parse(taxes[t].total_tax);
      }else{
        totalDouble=totalDouble+int.parse(taxes[t].total_tax);
      }
    }
    return totalDouble;
  }

  formatedNumber(number) {
    var formatCurrency;
    formatCurrency = new NumberFormat.currency(
        customPattern: "\u00A4#,##0.00\u00A0",
        symbol: "",
        decimalDigits: 0,
        locale: "es");

    return formatCurrency.format(number);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Tickets"),
      ),
      body: Column(
        children: [
          Expanded(child: Obx(()=>ListView.builder(
            padding: EdgeInsets.only(bottom: 200),
            itemCount: controllerClient.tickets.length,
            itemBuilder: (context, index) {
              Ticket ticket= controllerClient.tickets[index];








              return GestureDetector(
                onTap: () {
                  controllerClient.indexTicket.value=index;

                  Get.to(() => TicketIndividualClient());
                  //  controllerTicket.panelController.value.open();

                },
                child: Container(
                    padding:
                    EdgeInsets.only(left: 20, right: 20, top: 30, bottom: 10),
                    child: Container(
                      padding: EdgeInsets.all(20),
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
                            offset: Offset(0, 3), // changes position of shadow
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          Container(
                            margin: EdgeInsets.only(bottom: 10),

                            child: Row(
                              children: [
                                Expanded(
                                    child: Container(
                                      child: Column(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            child: ticket.email != "null" ? Text(
                                              "Total",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 20),
                                            ): Text("${(ticket.email)}"),
                                          ),


                                        ],
                                      ),
                                    )),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Container(
                                      margin: EdgeInsets.only(top: 10),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            child: Text(
                                              "\$",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 15,
                                                  color:
                                                  Colors.grey.withOpacity(0.9)),
                                            ),
                                            margin: EdgeInsets.only(right: 3),
                                          ),
                                          Text(
                                            "${formatedNumber(getTotalItem(ticket))}",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 20),
                                          )
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Divider(

                            color: Colors.grey.withOpacity(0.4),
                            height: 1,

                          ),
                          Container(

                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  child: Text(
                                    "#${(ticket.id)}",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 13,
                                        color: Colors.grey.withOpacity(0.6)),
                                  ),
                                ),  Container(


                                  child: Text(
                                    "${(ticket.date)}",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 13,
                                        color: Colors.grey.withOpacity(0.6)),
                                  ),
                                ),
                              ],
                            ),
                            margin: EdgeInsets.only(top: 10),
                          )
                        ],
                      ),
                    )),
              );
            },
          )))
        ],
      ),
    );
  }

}