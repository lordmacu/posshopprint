import 'package:bubble_bottom_bar/bubble_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pop_bottom_menu/pop_bottom_menu.dart';
import 'package:poshop/auth/controllers/AuthController.dart';
import 'package:poshop/cart/controllers/ProductContoller.dart';
import 'package:poshop/categories/categories.dart';
import 'package:poshop/categories/controllers/CategoryController.dart';
import 'package:poshop/checkout/controllers/CheckoutController.dart';
import 'package:poshop/clients/controllers/ClientController.dart';
import 'package:poshop/controllers/MenuController.dart';
import 'package:poshop/discounts/controllers/DiscountContoller.dart';
import 'package:poshop/discounts/discounts.dart';
import 'package:poshop/helpers/RestartWidget.dart';
import 'package:poshop/home/controllers/HomeController.dart';
import 'package:poshop/home/controllers/LoadingController.dart';
import 'package:poshop/products/controllers/ProductContoller.dart' as p;
import 'package:poshop/redirector.dart';
import 'package:poshop/tickets/controllers/TicketsController.dart';

class BottomMenu extends StatelessWidget {
  MenuContoller controller = Get.find();
  AuthContoller controllerAuth = Get.find();
  HomeContoller controllerHome = Get.find();
  TicketsContoller controllerTicket = Get.put(TicketsContoller());
  LoadingController controllerLoading = Get.find();
  ProductContoller controllerProduct = Get.put(ProductContoller());
  CategoryContoller controllerCategory = Get.find();
  CheckoutContoller controllerCheckout = Get.find();

  DiscountContoller controllerDiscount = Get.find();
  ClientContoller controllerClient = Get.find();
  p.ProductsContoller controllerProducts = Get.put(p.ProductsContoller());

  void _showMenu(context) {
    showModalBottomSheet(
      backgroundColor: Colors.transparent,
      context: context,
      builder: (context) {
        return PopBottomMenu(
          title: TitlePopBottomMenu(
            label: "Posshop",
          ),
          items: [
            ItemPopBottomMenu(
              onPressed: () => print("notifications"),
              label: "Configuración",
              icon: Icon(
                Icons.settings,
                color: Colors.grey,
              ),
            ),
            ItemPopBottomMenu(
              onPressed: () => print("mute"),
              label: "Backoffice",
              icon: Icon(
                Icons.launch,
                color: Colors.grey,
              ),
            ),
            ItemPopBottomMenu(
              onPressed: () => print("unfollow"),
              label: "Soporte",
              icon: Icon(
                Icons.comment,
                color: Colors.grey,
              ),
            ),
            ItemPopBottomMenu(
              onPressed: () async {
                await controllerCategory.getCategories();

                Get.to(() => Categories());
              },
              label: "Categorias",
              icon: Icon(
                Icons.comment,
                color: Colors.grey,
              ),
            ),
            ItemPopBottomMenu(
              onPressed: () async {
                DiscountContoller controllerDiscounts = Get.find();
                controllerDiscounts.discounts.clear();
                controllerDiscounts.discounts.refresh();
                await controllerDiscount.getDiscounts();

                Get.to(() => Discounts());
              },
              label: "Descuentos",
              icon: Icon(
                Icons.comment,
                color: Colors.grey,
              ),
            ),
            ItemPopBottomMenu(
              onPressed: () {
                controllerAuth.logout();
                controllerCategory.items.clear();
                controllerCategory.items.refresh();

                controllerProduct.products.clear();
                controllerProduct.products.refresh();

                controllerDiscount.discounts.clear();
                controllerDiscount.discounts.refresh();

                controllerCheckout.paymentItems.clear();
                controllerCheckout.paymentItems.refresh();

                controllerClient.items.clear();
                controllerClient.items.refresh();

                controllerClient.itemsTemp.clear();
                controllerClient.itemsTemp.refresh();

                Get.put(DiscountContoller());

                Get.reset();
                RestartWidget.restartApp(context);

                Get.to(() => Redirector());
              },
              label: "Salir",
              icon: Icon(
                Icons.comment,
                color: Colors.grey,
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() => BubbleBottomBar(
          opacity: .2,
          currentIndex: controller.positionMenu.value,
          onTap: (value) async {
            if (value < 3) {
              controllerLoading.isLoading.value = true;

              controller.positionMenu.value = value;
              controllerHome.controller.animateTo(value,
                  duration: Duration(seconds: 2), curve: Curves.bounceIn);
              controllerLoading.isLoading.value = true;

              if (value == 1) {
                await controllerTicket.getTickets();
              }
              if (value == 2) {
                controllerProducts.search.value = "";

                await controllerProduct.getProducts();
                await controllerCategory.getCategories();
              }
              if (value == 0) {
                await controllerProduct.getProducts();
                await controllerCategory.getCategories();
              }
              controllerLoading.isLoading.value = false;
            } else {
              _showMenu(context);
            }
          },
          borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
          elevation: 8,
          hasNotch: true,
          //new
          hasInk: true,
          //new, gives a cute ink effect
          inkColor: Colors.black12,
          //optional, uses theme color if not specified
          items: <BubbleBottomBarItem>[
            BubbleBottomBarItem(
                backgroundColor: Color(0xff298dcf),
                icon: Icon(
                  Icons.dashboard,
                  color: Colors.black,
                ),
                activeIcon: Icon(
                  Icons.dashboard,
                  color: Color(0xff298dcf),
                ),
                title: Text("Ventas")),
            BubbleBottomBarItem(
                backgroundColor: Color(0xff298dcf),
                icon: Icon(
                  Icons.access_time,
                  color: Colors.black,
                ),
                activeIcon: Icon(
                  Icons.access_time,
                  color: Colors.deepPurple,
                ),
                title: Text("Recibos")),
            BubbleBottomBarItem(
                backgroundColor: Colors.indigo,
                icon: Icon(
                  Icons.folder_open,
                  color: Colors.black,
                ),
                activeIcon: Icon(
                  Icons.folder_open,
                  color: Colors.indigo,
                ),
                title: Text("Artículos")),
            BubbleBottomBarItem(
                backgroundColor: Colors.green,
                icon: Icon(
                  Icons.menu,
                  color: Colors.black,
                ),
                activeIcon: Icon(
                  Icons.menu,
                  color: Colors.green,
                ),
                title: Text("Menu"))
          ],
        ));
  }
}
