import 'package:flutter/material.dart';
import 'package:masonry_grid/masonry_grid.dart';
import 'package:bubble_bottom_bar/bubble_bottom_bar.dart';
import 'package:poshop/controllers/MenuController.dart';
import 'package:poshop/categories/categories.dart';
import 'package:get/get.dart';
import 'package:pop_bottom_menu/pop_bottom_menu.dart';

class BottomMenu extends StatelessWidget {
  MenuContoller controller = Get.find();

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
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Categories()),
                );
              },
              label: "Categorias",
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
          onTap: (value) {
            print("asdfa   sd as  ${value} ");
            if (value < 3) {
              controller.positionMenu.value = value;
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
