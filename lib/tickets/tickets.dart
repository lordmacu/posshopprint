import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:poshop/checkout/models/ItemSimple.dart';
import 'package:poshop/tickets/controllers/TicketsController.dart';
import 'package:poshop/tickets/model/Ticket.dart';
import 'package:poshop/tickets/ticketIndividual.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class Tickets extends StatelessWidget {

  TicketsContoller controllerTicket= Get.put(TicketsContoller());

  formatedNumber(number) {
    var formatCurrency;
    formatCurrency = new NumberFormat.currency(
        customPattern: "\u00A4#,##0.00\u00A0",
        symbol: "",
        decimalDigits: 0,
        locale: "es");

    return formatCurrency.format(number);
  }

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
  getTotalSubtotalItem(ticket){
    var items=ticket.items;
    var taxes= ticket.taxes;
    var total= 0;

    for(var i =0  ; i  < items.length ; i++ ){


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


    return totalDouble;
  }


  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Column(
        children: [
         /* Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              onChanged: (value) {

              },
              decoration: InputDecoration(
                  labelText: "Buscar recibo",
                  hintText: "Buscar recibo",
                  prefixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(25.0)))),
            ),

          )*/
          Expanded(child: Obx(()=>ListView.builder(
            padding: EdgeInsets.only(bottom: 200),
            itemCount: controllerTicket.tickets.length,
            itemBuilder: (context, index) {
              Ticket ticket= controllerTicket.tickets[index];








              return GestureDetector(
                onTap: () {
                  controllerTicket.indexTicket.value=index;

                  Get.to(() => TicketIndividual());
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
                                            child: ticket.email != null ? Text(
                                              "Total",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 20),
                                            ): Text("${(ticket.code)}"),
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
