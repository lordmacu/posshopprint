import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:posshop_app/screens/AppsScreen.dart';
import 'package:posshop_app/screens/ArticleScreen.dart';
import 'package:posshop_app/screens/BackOfficeScreen.dart';
import 'package:posshop_app/screens/CategoryScreen.dart';
import 'package:posshop_app/screens/ConfigurationScreen.dart';
import 'package:posshop_app/screens/DiscountScreen.dart';
import 'package:posshop_app/screens/SalesScreen.dart';
import 'package:posshop_app/widget/MenuDrawerWidget.dart';
import 'package:provider/provider.dart';

import '../AppTheme.dart';
import '../AppThemeNotifier.dart';
import 'HelpScreen.dart';
import 'ReceiptScreen.dart';

class MenuScreen extends StatefulWidget {
  @override
  _MenuScreenState createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey = GlobalKey<ScaffoldMessengerState>();

  int _selectedPage = 0;
  DateTime? currentBackPressTime;

  late ThemeData themeData;

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
    themeData = Theme.of(context);
    return Consumer<AppThemeNotifier>(
      builder: (BuildContext context, AppThemeNotifier value, Widget? child) {
        return MaterialApp(
          scaffoldMessengerKey: scaffoldMessengerKey,
          debugShowCheckedModeBanner: false,
          theme: AppTheme.getThemeFromThemeMode(value.themeMode()),
          home: Scaffold(
            key: _scaffoldKey,
            appBar: AppBar(
              title: Text("Ticket", style: AppTheme.getTextStyle(themeData.textTheme.headline6, fontWeight: 600)),
            ),
            body: WillPopScope(child: _fragmentView[_selectedPage], onWillPop: onWillPop),
            drawer: MenuDrawerWidget(themeData, _scaffoldKey, _selectedPage),
            // Drawer(
            //   child: Container(
            //     child: Column(
            //       crossAxisAlignment: CrossAxisAlignment.stretch,
            //       children: <Widget>[
            //         /*---------- Drawer Header ----------------*/
            //         Expanded(
            //           flex: 2,
            //           child: DrawerHeader(
            //             padding: EdgeInsets.all(0),
            //             margin: EdgeInsets.all(0),
            //             child: Container(
            //               child: Padding(
            //                 padding: const EdgeInsets.only(
            //                     left: 16.0, bottom: 8, right: 16, top: 30),
            //                 child: Column(
            //                   crossAxisAlignment: CrossAxisAlignment.start,
            //                   children: <Widget>[
            //                     Column(
            //                       mainAxisAlignment: MainAxisAlignment.end,
            //                       crossAxisAlignment: CrossAxisAlignment.start,
            //                       children: <Widget>[
            //                         Text("Propietario",
            //                             style: themeData.textTheme.headline5!
            //                                 .merge(TextStyle(
            //                                         color: themeData
            //                                             .colorScheme.onPrimary)
            //                                     .merge(TextStyle(
            //                                         fontWeight:
            //                                             FontWeight.w600)))),
            //                         Text("Ropa",
            //                             style: themeData.textTheme.headline6!
            //                                 .merge(TextStyle(
            //                                         color: themeData
            //                                             .colorScheme.onPrimary)
            //                                     .merge(TextStyle(
            //                                         fontWeight:
            //                                             FontWeight.w600)))),
            //                         Text("Principal",
            //                             style: themeData.textTheme.bodyText2!
            //                                 .merge(TextStyle(
            //                                         color: themeData
            //                                             .colorScheme.onPrimary)
            //                                     .merge(TextStyle(
            //                                         fontWeight:
            //                                             FontWeight.w400))))
            //                       ],
            //                     ),
            //                   ],
            //                 ),
            //               ),
            //             ),
            //             decoration:
            //                 BoxDecoration(color: themeData.primaryColor),
            //           ),
            //         ),
            //
            //         /*------------- Drawer Content -------------*/
            //         Expanded(
            //           flex: 6,
            //           child: Container(
            //             color: themeData.backgroundColor,
            //             child: Padding(
            //               padding: const EdgeInsets.only(bottom: 8.0),
            //               child: ListView(
            //                 padding: EdgeInsets.all(0),
            //                 children: <Widget>[
            //                   singleDrawerItem(MdiIcons.purse, "Ventas", 0),
            //                   singleDrawerItem(
            //                       MdiIcons.emailOutline, "Recibos", 1),
            //                   Container(
            //                     margin: EdgeInsets.only(
            //                         top: 12, left: 16, right: 16, bottom: 12),
            //                     child: Text("MANTENEDORES",
            //                         style: themeData.textTheme.caption!.merge(
            //                             TextStyle(
            //                                 color: themeData
            //                                     .colorScheme.onBackground
            //                                     .withAlpha(240),
            //                                 fontWeight: FontWeight.w700,
            //                                 letterSpacing: 0.35,
            //                                 wordSpacing: 1.2))),
            //                   ),
            //                   singleDrawerItem(
            //                       MdiIcons.formatListBulleted, "Artículos", 2),
            //                   singleDrawerItem(MdiIcons.checkboxMultipleBlank,
            //                       "Categorías", 3),
            //                   singleDrawerItem(MdiIcons.tag, "Descuentos", 4),
            //                   Divider(
            //                     height: 1,
            //                     color: themeData.dividerColor,
            //                     thickness: 1,
            //                   ),
            //                   singleDrawerItem(
            //                       MdiIcons.wrenchOutline, "Configuración", 5),
            //                   singleDrawerItem(
            //                       MdiIcons.chartBar, "Back Office", 6),
            //                   singleDrawerItem(MdiIcons.gift, "Apps", 7),
            //                   singleDrawerItem(
            //                       MdiIcons.helpCircleOutline, "Ayuda", 8),
            //                 ],
            //               ),
            //             ),
            //           ),
            //         )
            //       ],
            //     ),
            //   ),
            // ),
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                ScaffoldMessenger.of(_scaffoldKey.currentContext!).showSnackBar(SnackBar(
                  content: Text('Boton de prueba...'),
                  duration: Duration(seconds: 1),
                ));
              },
              child: Icon(
                MdiIcons.chevronLeft,
                color: themeData.colorScheme.onPrimary,
              ),
            ),
          ),
        );
      },
    );
  }

  Widget singleDrawerItem(IconData iconData, String title, int position) {
    return ListTile(
      dense: true,
      contentPadding: EdgeInsets.only(top: 0.0, left: 16, right: 16, bottom: 0),
      leading: Icon(iconData,
          size: 20,
          color: _selectedPage == position ? themeData.colorScheme.primary : themeData.colorScheme.onBackground.withAlpha(240)),
      title: Text(title,
          style: themeData.textTheme.subtitle2!
              .merge(TextStyle(fontWeight: _selectedPage == position ? FontWeight.w600 : FontWeight.w500, letterSpacing: 0.2))
              .merge(TextStyle(
                  color:
                      _selectedPage == position ? themeData.colorScheme.primary : themeData.colorScheme.onBackground.withAlpha(240)))),
      onTap: () {
        setState(() {
          _selectedPage = position;
        });
        _scaffoldKey.currentState!.openEndDrawer();
      },
    );
  }

  Future<bool> onWillPop() {
    DateTime now = DateTime.now();
    if (currentBackPressTime == null || now.difference(currentBackPressTime!) > Duration(seconds: 2)) {
      currentBackPressTime = now;
      ScaffoldMessenger.of(_scaffoldKey.currentContext!).showSnackBar(
        new SnackBar(
          content: new Text(
            'Presione volver nuevamente para salir',
            style: themeData.textTheme.subtitle2!.merge(TextStyle(color: themeData.colorScheme.onPrimary)),
          ),
          backgroundColor: themeData.colorScheme.primary,
          behavior: SnackBarBehavior.floating,
          duration: Duration(seconds: 2),
        ),
      );
      return Future.value(false);
    }
    return Future.value(true);
  }
}
