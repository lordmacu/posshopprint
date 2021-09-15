import 'package:flutter/material.dart';

class ColorsBoxes extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    var boxWidth=(width/4)-30;

    return Column(
      children: [
        Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(

                margin: EdgeInsets.all(10),
                color: Color(0xffe74c3c),

                child: null,
                width: boxWidth,
                height: boxWidth,
              ),
              Container(

                margin: EdgeInsets.all(10),
                color: Color(0xff2ecc71),

                child: null,
                width: boxWidth,
                height: boxWidth,
              ),
              Container(

                margin: EdgeInsets.all(10),
                color: Color(0xff3498db),

                child: null,
                width: boxWidth,
                height: boxWidth,
              ),
              Container(

                margin: EdgeInsets.all(10),
                color: Color(0xff9b59b6),

                child: null,
                width: boxWidth,
                height: boxWidth,
              ),

            ],
          ),
        ),

        Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(

                margin: EdgeInsets.all(10),
                color: Color(0xffe67e22),

                child: null,
                width: boxWidth,
                height: boxWidth,
              ),
              Container(

                margin: EdgeInsets.all(10),
                color: Color(0xffd35400),

                child: null,
                width: boxWidth,
                height: boxWidth,
              ),
              Container(

                margin: EdgeInsets.all(10),
                color: Color(0xffc0392b),

                child: null,
                width: boxWidth,
                height: boxWidth,
              ),
              Container(

                margin: EdgeInsets.all(10),
                color: Color(0xff34495e),

                child: null,
                width: boxWidth,
                height: boxWidth,
              ),

            ],
          ),
        ),
      ],
    );
  }

}