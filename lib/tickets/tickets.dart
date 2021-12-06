import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:poshop/checkout/models/ItemSimple.dart';
import 'package:poshop/tickets/controllers/TicketsController.dart';
import 'package:poshop/tickets/model/Ticket.dart';
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


      var salePrice=items[i].ammout/items[i].quantity;

      salePrice=salePrice*items[i].quantity;

      var discounts=items[i].discounts;
      if(discounts!=null){
        for(var d =0  ; d  < discounts.length ; d++ ){
          salePrice=salePrice-discounts[d].totalDiscount;
        }
      }
      total=total+(salePrice);
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
      total=total+(salePrice);
    }

    var totalDouble= total;


    return totalDouble;
  }


  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SlidingUpPanel(
        backdropTapClosesPanel: true,
        backdropEnabled: true,
        controller: controllerTicket.panelController.value,
        minHeight: 0,
        maxHeight:(height*75)/100 ,

        panel: Obx((){

          if(controllerTicket.indexTicket.value!=null){
            Ticket ticket= controllerTicket.tickets[controllerTicket.indexTicket.value];

            print("asdfasdf a ${ticket}");

            var totalFinal=0;

            var subtototal=0;
            return Container(
              padding: EdgeInsets.only(top: 20, left: 20, right: 20),
              child: controllerTicket.indexTicket.value != null ? Column(
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




                              var total=0.0;
                                var salePrice=itemSimple.ammout/itemSimple.quantity;

                                salePrice=salePrice*itemSimple.quantity;

                                var discounts=itemSimple.discounts;
                                if(discounts!=null){
                                  for(var d =0  ; d  < discounts.length ; d++ ){
                                    salePrice=salePrice-discounts[d].totalDiscount;
                                  }
                                }
                                total=total+(salePrice);
                              subtototal=(subtototal.toDouble()+total).toInt();


                              return Container(
                                padding: EdgeInsets.only(top: 5,bottom: 5),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(

                                      children: [
                                        Container(
                                          child: Text("${itemSimple.name}"),
                                        ),
                                        Container(
                                          child: Text("${itemSimple.quantity} X \$${formatedNumber(itemSimple.ammout/itemSimple.quantity)}"),
                                        ),

                                      ],
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                    ),
                                    Container(
                                      child: Text("\$${formatedNumber(total)}"),
                                    )
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
            );
          }else{
            return Container();
          }

        }),
        body: Column(
          children: [
            Padding(
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

            ),
            Expanded(child: Obx(()=>ListView.builder(
              padding: EdgeInsets.only(bottom: 200),
              itemCount: controllerTicket.tickets.length,
              itemBuilder: (context, index) {
                Ticket ticket= controllerTicket.tickets[index];








                return GestureDetector(
                  onTap: () {
                    controllerTicket.indexTicket.value=index;


                    controllerTicket.panelController.value.open();

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
                                              child: Text(
                                                "${(ticket.email)}",
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 20),
                                              ),
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
      ),
    );
  }
}
