import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:bubble_bottom_bar/bubble_bottom_bar.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
 import 'package:get/get.dart';
import 'package:poshop/cart/controllers/CartController.dart';
import 'package:poshop/checkout/controllers/CheckoutController.dart';
import 'package:poshop/clients/clientsUser.dart';
import 'package:poshop/clients/controllers/ClientController.dart';
import 'package:poshop/discounts/controllers/DiscountContoller.dart';
import 'package:poshop/home/controllers/LoadingController.dart';
import 'package:poshop/products/controllers/ProductContoller.dart';
import 'package:poshop/categories/controllers/CategoryController.dart';
import 'package:poshop/controllers/MenuController.dart';
import 'package:pop_bottom_menu/pop_bottom_menu.dart';
import 'package:masonry_grid/masonry_grid.dart';
import 'package:poshop/general/bottonMenu.dart';
import 'package:poshop/helpers/widgetsHelper.dart';
import 'package:poshop/home/cart.dart';
import 'package:poshop/home/categories.dart';
import 'package:poshop/home/controllers/HomeController.dart';
import 'package:poshop/home/products.dart';
import 'package:poshop/products/model/Product.dart';
import 'package:poshop/products/products.dart';
import 'package:poshop/tickets/tickets.dart';
//import 'package:barras/barras.dart';

class Home extends StatelessWidget   {



  MenuContoller controller = Get.put(MenuContoller());
  HomeContoller  controllerHome = Get.put(HomeContoller());
  CategoryContoller controllerCategory = Get.put(CategoryContoller());
  CartContoller controlelrCart = Get.put(CartContoller());
  ProductsContoller controllerProduct = Get.put(ProductsContoller());
  ClientContoller controllerClient = Get.put(ClientContoller());
  LoadingController controllerLoading = Get.put(LoadingController());

   CheckoutContoller controllerCheckout = Get.put(CheckoutContoller());
  DiscountContoller controllerDiscount= Get.put(DiscountContoller());

  var loadingHud;

  WidgetsHelper helpers = WidgetsHelper();

  Widget getScreen(){
    if( controller.positionMenu.value==0){
      return Cart();
    }
    if( controller.positionMenu.value==1){
      return Tickets();
    }
    if( controller.positionMenu.value==2){
      return ProductsList();
    }
  }


  @override
  Widget build(BuildContext context) {

    loadingHud = helpers.initLoading(context);

    return WillPopScope(child: Scaffold(


        backgroundColor: Colors.white,

        appBar: AppBar(
          automaticallyImplyLeading: false,

          iconTheme: IconThemeData(color: Color(0xff298dcf)),
          backgroundColor: Colors.white,
          elevation: 0,
          title: Text(
            "PosShop",
            style: TextStyle(color: Colors.black87),
          ),
          actions: [
            InkWell(
              onTap: () {

                controllerHome.isShowPayment.value=!controllerHome.isShowPayment.value;
              },
              child: Container(
                margin: EdgeInsets.only(right: 15),
                child: Container(
                  child: Row(
                    children: [
                      Icon(
                        Icons.shopping_cart,
                        color: Color(0xff298dcf),
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 5),
                        child: Text(
                          "0",
                          style: TextStyle(color: Colors.grey, fontSize: 20),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
            InkWell(
              onTap: ()  async{
                 Get.to(() => ClientUser());
                 loadingHud.show();

                 await controllerClient.getClients();
                 loadingHud.dismiss();


              },
              child: Container(
                padding: EdgeInsets.only(left: 5,right: 5),
                child: Icon(
                  Icons.person_add,
                  color: Color(0xff298dcf),
                ),
              ),
            ),
            InkWell(
              onTap: () async {
               var data = await FlutterBarcodeScanner.scanBarcode(
                    '#ff6666', 'Cancel', true, ScanMode.QR);



                loadingHud.show();

                var indexProduct= await controllerHome.findProductIndex(data);
                loadingHud.dismiss();



                if(indexProduct["product"]!=null){
                  controlelrCart.addItemCart(indexProduct["product"]);

                  controllerHome.jumpToIndex(indexProduct["index"]);
                }else{
                  helpers.defaultAlert(context, "error", "Error al encontrar producto",
                      "Por favor verificar si el producto existe o si el c??digo de barras es el indicado");
                }


              },
              child: Container(
                margin: EdgeInsets.only(left: 15),
                child: Container(
                  child: Row(
                    children: [
                      Icon(
                        Icons.qr_code,
                        color: Color(0xff298dcf),
                      ),

                    ],
                  ),
                ),
              ),
            ),
            PopupMenuButton<String>(
              onSelected: (value) {},
              itemBuilder: (BuildContext context) {
                return {'Logout', 'Settings'}.map((String choice) {
                  return PopupMenuItem<String>(
                    value: choice,
                    child: Text(choice),
                  );
                }).toList();
              },
            )
          ],
        ),
        body: Stack(
          children: [

            Obx(()=>DefaultTabController(length: 3,

                initialIndex: controller.positionMenu.value,

                child: TabBarView(
                  controller: controllerHome.controller,
                  children: [
                    Cart(),
                    Tickets(),
                    ProductsList()
                  ],
                )
            )),
           Obx(()=> controllerLoading.isLoading.value ? Container(
             width: double.infinity,
             height: double.infinity,
             color: Colors.black45,
             child: Column(
               mainAxisAlignment: MainAxisAlignment.center,
               crossAxisAlignment: CrossAxisAlignment.center,
               children: [
                 CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Colors.white)),
                 Container(
                   margin: EdgeInsets.only(top: 10),
                   child: Text("Cargando...",style: TextStyle(color: Colors.white),),
                 )
               ],
             ),
           ): Container()),
          ],
        ),
        bottomNavigationBar: BottomMenu() ), onWillPop:  () async => false);
  }
}
