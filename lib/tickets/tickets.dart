import 'package:flutter/material.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class Tickets extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    PanelController _panelController = PanelController();

    return Scaffold(
      body: SlidingUpPanel(
        backdropTapClosesPanel: true,
        backdropEnabled: true,
        controller: _panelController,
        minHeight: 0,

        panel: Container(
          padding: EdgeInsets.only(top: 20, left: 20, right: 20),
          child: Column(
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
                          "#15312",
                          style: TextStyle(fontSize: 25, color: Colors.grey),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 5),
                          child: Text(
                            "08/09/2021 8:30am",
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
              Container(
                margin: EdgeInsets.only(top: 10),
                child: Column(
                  children: [
                    Text(
                      "\$10.000",
                      style: TextStyle(fontSize: 40),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 5),
                      padding: EdgeInsets.only(
                          left: 10, right: 10, top: 5, bottom: 5),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Color(0xff298dcf).withOpacity(0.7),
                      ),
                      child: Text(
                        "Total",
                        style: TextStyle(fontSize: 20, color: Colors.white),
                      ),
                    )
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 20),
                child: Row(
                  children: [
                    Text(
                      "Cajero:",
                      style: TextStyle(fontSize: 16),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 5),
                      child: Text(
                        "Propietario",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                    )
                  ],
                ),
              ),
              
              Expanded(
                  child: Container(
                child: ListView.builder(
                    itemCount: 50,
                    itemBuilder: (context, index) {
                      return Container(
                        padding: EdgeInsets.only(top: 20,bottom: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              children: [
                                Container(
                                  child: Text("Primer Articulo"),
                                ),
                                Container(
                                  child: Text("1 X 10.000,00"),
                                )
                              ],
                            ),
                            Container(
                              child: Text("10.000,00"),
                            )
                          ],
                        ),
                      );
                    }),
              )),
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
                           Container(
                             margin: EdgeInsets.only(top: 5),
                             child: Text("Efectivo",style: TextStyle(fontSize: 18),),
                           )
                         ],
                       ),
                       Column(
                         mainAxisAlignment: MainAxisAlignment.end,
                         crossAxisAlignment: CrossAxisAlignment.end,
                         children: [
                           Text("10.000,00",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
                           Container(
                             margin: EdgeInsets.only(top: 5),
                             child: Text("10.000,00",style: TextStyle(fontSize: 18),),
                           )
                         ],
                       )
                     ],
                   ),
                 )
               ],
             )
            ],
          ),
        ),
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
            Expanded(child: ListView.builder(
              itemCount: 50,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    _panelController.open();
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
                                                "Producto",
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 20),
                                              ),
                                            ),
                                            Container(
                                              child: Text(
                                                "Categoría",
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 15,
                                                    color: Colors.grey.withOpacity(0.6)),
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
                                              "5.000.000",
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
                                      "#15312",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15,
                                          color: Colors.grey.withOpacity(0.6)),
                                    ),
                                  ),  Container(
                                    child: Text(
                                      "08/09/2021 8:30am",
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
            ))
          ],
        ),
      ),
    );
  }
}
