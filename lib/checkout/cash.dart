import 'package:flutter/material.dart';

class CashPanel extends StatelessWidget{
  @override
  Widget build(BuildContext context) {


    return Column(

      children: [
        Container(
          margin: EdgeInsets.only(top: 20),
          child: Text("Efectivo",style:TextStyle(fontSize: 25,fontWeight: FontWeight.bold),),
        ),
        Container(
          margin: EdgeInsets.only(top: 30),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Container(
                      child: Text("10.000",style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),),
                    ),
                    Container(
                      child: Text("Total pagado"),
                    )
                  ],
                ),
              ),
              Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Container(
                      child: Text("0,00",style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),),
                    ),
                    Container(
                      child: Text("Total pagado"),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
        Container(
          margin: EdgeInsets.only(top: 20),
          child: Row(
            children: [
              Expanded(child: TextFormField(

                onChanged: (value){


                },

                keyboardType: TextInputType.emailAddress,



                decoration: InputDecoration(
                    prefixIcon: Icon(Icons.email),
                    labelText: "Efectivo recibido",
                    hintText: "Escribe el valor a cobrar"),
                // The validator receives the text that the user has entered.
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter some text';
                  }
                  return null;
                },
              ))
            ],
          ),
        ),

      ],
    );
  }

}