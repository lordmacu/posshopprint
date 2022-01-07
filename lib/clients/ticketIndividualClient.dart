import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:poshop/checkout/models/ItemSimple.dart';
import 'package:poshop/clients/controllers/ClientController.dart';
import 'package:poshop/tickets/controllers/TicketsController.dart';
import 'package:poshop/tickets/model/Ticket.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class TicketIndividualClient extends StatelessWidget{
  ClientContoller controllerClient= Get.put(ClientContoller());

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
    Ticket ticket= controllerClient.tickets[controllerClient.indexTicket.value];
    var totalFinal=0;

    var subtototal=0;

    return Scaffold(
      appBar: AppBar(

      ),
      body: Container(
        padding: EdgeInsets.only(top: 20, left: 20, right: 20,bottom: 20),
        child: controllerClient.indexTicket.value != null ? Column(
          children: [
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "#${ticket.id}",
                        style: TextStyle(fontSize: 25, color: Colors.grey),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 5),
                        child: Text(
                          "${ticket.date}",
                          style: TextStyle(fontSize: 12, color: Colors.grey),
                        ),
                      )
                    ],
                  ),
                  Row(
                    children: [
                      RaisedButton(
                        onPressed: () {},
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                        color: Color(0xff298dcf),
                        child: Text(
                          "Reembolsar",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 5),
                        width: 60,
                        child: RaisedButton(

                          onPressed: () {},
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                          color: Colors.white,
                          child: Icon(Icons.email,color:  Color(0xff298dcf),),
                        ),
                      )
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



            Expanded(
                flex: 3,
                child: Container(
                  margin: EdgeInsets.only(top: 20),
                  child: ListView.builder(
                      shrinkWrap: false,

                      itemCount: ticket.items.length,
                      itemBuilder: (context, index) {
                        ItemSimple itemSimple = ticket.items[index];




                        var total=0;
                        var salePrice=itemSimple.ammout/itemSimple.quantity;

                        salePrice=salePrice*itemSimple.quantity;

                        var discounts=itemSimple.discounts;
                        if(discounts!=null){
                          for(var d =0  ; d  < discounts.length ; d++ ){
                            salePrice=salePrice-discounts[d].totalDiscount;
                          }
                        }
                        total=total+(salePrice.toInt());
                        subtototal=subtototal+total;
                        
                        List<Widget> discountsWidget= [];

                        for(var d =0;  d < itemSimple.discounts.length ; d ++){
                          discountsWidget.add(
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("${itemSimple.discounts[d].name} ${itemSimple.discounts[d].calculationType != "PERCENT" ? "\$" : ""}${itemSimple.discounts[d].discount}${itemSimple.discounts[d].calculationType == "PERCENT" ? "%" : ""}"),
                                Text("\$${itemSimple.discounts[d].totalDiscount}")
                              ],
                            )
                          );
                        }

                        return Container(
                          padding: EdgeInsets.only(top: 5,bottom: 5),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(child: Container(

                                child: Column(

                                  children: [
                                   Row(

                                     children: [
                                       Container(
                                         child: Text("${itemSimple.name}",style: TextStyle(fontWeight: FontWeight.bold),),
                                       ),
                                       Container(

                                         child: Text("\$${formatedNumber(total)}"),

                                       )
                                     ],
                                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                   ),
                                    Container(

                                      child: Text("${itemSimple.divisible != 0 ? itemSimple.quantity.toInt() : itemSimple.quantity } X \$${formatedNumber(itemSimple.ammout/itemSimple.quantity)}"),
                                      margin: EdgeInsets.only(top: 5),
                                    ),

                                    Column(
                                      mainAxisSize: MainAxisSize.max,
                                      children:discountsWidget,
                                    )

                                  ],
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                ),
                                
                                decoration: BoxDecoration(
                                  color: Colors.grey.withOpacity(0.2),
                                  borderRadius: BorderRadius.circular(10)

                                ),
                                padding: EdgeInsets.all(10),
                              )),

                            ],
                          ),
                        );
                      }),
                )),
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Subtotal",style: TextStyle(fontWeight: FontWeight.bold),),
                  Text("\$${formatedNumber(getTotalSubtotalItem(ticket))}",style: TextStyle(fontWeight: FontWeight.bold))
                ],
              ),
            ),


            ticket.taxes.length > 0 ? Expanded(
                flex: 2,
                child: Container(
                  child: Column(
                    children: [
                      Container(
                        margin: EdgeInsets.only(bottom: 10, top: 10),
                        height: 1,
                        child: null,
                        color:  Color(0xff298dcf),
                      ),
                      Container(
                        margin: EdgeInsets.only(bottom: 10),
                        child: Text("Impuestos",style: TextStyle(fontWeight: FontWeight.bold),),
                      ),
                      Expanded(child: ListView.builder(
                          itemCount: ticket.taxes.length,
                          itemBuilder: (context, index) {
                            return Container(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("${ticket.taxes[index].name} ${ticket.taxes[index].rate}%",style: TextStyle(fontWeight: FontWeight.bold),),
                                  Text("${ticket.taxes[index].type=="INCLUDED" ? "-" : ""} \$${formatedNumber(int.parse(ticket.taxes[index].total_tax))}",style: TextStyle(fontWeight: FontWeight.bold))
                                ],
                              ),
                            );
                          }))
                    ],
                  ),
                )): Container(),
            Column(
              children: [
                Container(
                  margin: EdgeInsets.only(bottom: 10, top: 10),
                  height: 1,
                  child: null,
                  color:  Color(0xff298dcf),
                ),
                Container(
                  padding: EdgeInsets.only(bottom: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Total",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
                          /*  Container(
                                  margin: EdgeInsets.only(top: 5),
                                  child: Text("Efectivo",style: TextStyle(fontSize: 18),),
                                )*/
                        ],
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text("\$${formatedNumber(getTotalItem(ticket))}",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
                          /*Container(
                                  margin: EdgeInsets.only(top: 5),
                                  child: Text("10.000,00",style: TextStyle(fontSize: 18),),
                                )*/
                        ],
                      )
                    ],
                  ),
                )
              ],
            )
          ],
        ): Container(),
      ),
    );
  }

}