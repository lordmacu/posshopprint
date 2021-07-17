import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:posshop_app/screens/AppsScreen.dart';
import 'package:posshop_app/screens/ArticleScreen.dart';
import 'package:posshop_app/screens/BackOfficeScreen.dart';
import 'package:posshop_app/screens/CategoryScreen.dart';
import 'package:posshop_app/screens/ConfigurationScreen.dart';
import 'package:posshop_app/screens/DiscountScreen.dart';
import 'package:posshop_app/screens/HelpScreen.dart';
import 'package:posshop_app/screens/ReceiptScreen.dart';
import 'package:posshop_app/screens/SalesScreen.dart';

class MenuDrawerWidget extends StatelessWidget {
  final int selectedPage;
  final GlobalKey<ScaffoldState> scaffoldKey;
  final ThemeData themeData;

  MenuDrawerWidget(this.themeData, this.scaffoldKey, this.selectedPage);

  final List<Widget> _fragmentView = [
    SalesScreen(),
    ReceiptScreen(),
    ArticleScreen(),
    CategoryScreen(),
    DiscountScreen(),
    ConfigurationScreen(),
    BackOfficeScreen(),
    AppsScreen(),
    HelpScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            /*---------- Drawer Header ----------------*/
            Expanded(
              flex: 2,
              child: DrawerHeader(
                padding: EdgeInsets.all(0),
                margin: EdgeInsets.all(0),
                child: Container(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 16.0, bottom: 8, right: 16, top: 30),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text("Propietario",
                                style: themeData.textTheme.headline5!.merge(
                                    TextStyle(color: themeData.colorScheme.onPrimary).merge(TextStyle(fontWeight: FontWeight.w600)))),
                            Text("Ropa",
                                style: themeData.textTheme.headline6!.merge(
                                    TextStyle(color: themeData.colorScheme.onPrimary).merge(TextStyle(fontWeight: FontWeight.w600)))),
                            Text("Principal",
                                style: themeData.textTheme.bodyText2!.merge(
                                    TextStyle(color: themeData.colorScheme.onPrimary).merge(TextStyle(fontWeight: FontWeight.w400))))
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                decoration: BoxDecoration(color: themeData.primaryColor),
              ),
            ),

            /*------------- Drawer Content -------------*/
            Expanded(
              flex: 6,
              child: Container(
                color: themeData.backgroundColor,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: ListView(
                    padding: EdgeInsets.all(0),
                    children: <Widget>[
                      singleDrawerItem(MdiIcons.purse, "Ventas", 0, context),
                      singleDrawerItem(MdiIcons.emailOutline, "Recibos", 1, context),
                      Container(
                        margin: EdgeInsets.only(top: 12, left: 16, right: 16, bottom: 12),
                        child: Text("MANTENEDORES",
                            style: themeData.textTheme.caption!.merge(TextStyle(
                                color: themeData.colorScheme.onBackground.withAlpha(240),
                                fontWeight: FontWeight.w700,
                                letterSpacing: 0.35,
                                wordSpacing: 1.2))),
                      ),
                      singleDrawerItem(MdiIcons.formatListBulleted, "Artículos", 2, context),
                      singleDrawerItem(MdiIcons.checkboxMultipleBlank, "Categorías", 3, context),
                      singleDrawerItem(MdiIcons.tag, "Descuentos", 4, context),
                      Divider(
                        height: 1,
                        color: themeData.dividerColor,
                        thickness: 1,
                      ),
                      singleDrawerItem(MdiIcons.wrenchOutline, "Configuración", 5, context),
                      singleDrawerItem(MdiIcons.chartBar, "Back Office", 6, context),
                      singleDrawerItem(MdiIcons.gift, "Apps", 7, context),
                      singleDrawerItem(MdiIcons.helpCircleOutline, "Ayuda", 8, context),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget singleDrawerItem(IconData iconData, String title, int position, BuildContext context) {
    return ListTile(
      dense: true,
      contentPadding: EdgeInsets.only(top: 0.0, left: 16, right: 16, bottom: 0),
      leading: Icon(iconData,
          size: 20,
          color: selectedPage == position ? themeData.colorScheme.primary : themeData.colorScheme.onBackground.withAlpha(240)),
      title: Text(title,
          style: themeData.textTheme.subtitle2!
              .merge(TextStyle(fontWeight: selectedPage == position ? FontWeight.w600 : FontWeight.w500, letterSpacing: 0.2))
              .merge(TextStyle(
                  color:
                      selectedPage == position ? themeData.colorScheme.primary : themeData.colorScheme.onBackground.withAlpha(240)))),
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => _fragmentView[position]));
        // scaffoldKey.currentState!.openEndDrawer();
      },
    );
  }
}
