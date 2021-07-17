import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:posshop_app/model/entity/DiscountEntity.dart';
import 'package:posshop_app/service/DiscountService.dart';
import 'package:posshop_app/widget/MenuDrawerWidget.dart';
import 'package:provider/provider.dart';

import '../AppTheme.dart';
import '../AppThemeNotifier.dart';

class DiscountScreen extends StatefulWidget {
  const DiscountScreen({Key? key}) : super(key: key);

  @override
  _DiscountScreenState createState() => _DiscountScreenState();
}

class _DiscountScreenState extends State<DiscountScreen> {
  GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey = GlobalKey<ScaffoldMessengerState>();

  late ThemeData themeData;
  DiscountService discountService = DiscountService();

  @override
  void initState() {
    DiscountEntity discountEntity = DiscountEntity(name: 'name', calculationType: 'PERCENT', value: 0);
    discountService.insert(discountEntity);
    discountService.updateAll();
    super.initState();
  }

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
              title: Text("Descuentos", style: AppTheme.getTextStyle(themeData.textTheme.headline6, fontWeight: 600)),
              actions: <Widget>[
                IconButton(
                  icon: Icon(Icons.search),
                  onPressed: () {},
                ),
              ],
            ),
            body: Container(
              color: themeData.backgroundColor,
              // child: ListView.builder(
              //   padding: EdgeInsets.all(0),
              //   itemCount: _mailList.length,
              //   itemBuilder: (context, index) {
              //     return Dismissible(
              //       background: Container(
              //         color: themeData.primaryColor,
              //         padding: EdgeInsets.symmetric(horizontal: 20),
              //         alignment: AlignmentDirectional.centerStart,
              //         child: Row(
              //           children: <Widget>[
              //             Icon(
              //               MdiIcons.delete,
              //               color: themeData.colorScheme.onPrimary,
              //             ),
              //             Padding(
              //               padding: const EdgeInsets.only(left: 8.0),
              //               child: Text("Delete",
              //                   style: AppTheme.getTextStyle(
              //                       themeData.textTheme.bodyText2,
              //                       fontWeight: 500,
              //                       color: themeData.colorScheme.onPrimary)),
              //             )
              //           ],
              //         ),
              //       ),
              //       secondaryBackground: Container(
              //         color: themeData.primaryColor,
              //         padding: EdgeInsets.symmetric(horizontal: 20),
              //         alignment: AlignmentDirectional.centerEnd,
              //         child: Row(
              //           mainAxisAlignment: MainAxisAlignment.end,
              //           children: <Widget>[
              //             Text("Archive",
              //                 style: AppTheme.getTextStyle(
              //                     themeData.textTheme.bodyText2,
              //                     fontWeight: 500,
              //                     color: themeData.colorScheme.onPrimary)),
              //             Padding(
              //               padding: const EdgeInsets.only(left: 8.0),
              //               child: Icon(
              //                 MdiIcons.inboxArrowDown,
              //                 color: themeData.colorScheme.onPrimary,
              //               ),
              //             ),
              //           ],
              //         ),
              //       ),
              //       onDismissed: (direction) {
              //         if (direction == DismissDirection.endToStart) {
              //           setState(() {
              //             _mailList.removeAt(index);
              //             showSnackbarWithFloating("Archived");
              //           });
              //         } else {
              //           setState(() {
              //             _mailList.removeAt(index);
              //             showSnackbarWithFloating("Deleted");
              //           });
              //         }
              //       },
              //       key: UniqueKey(),
              //       child: Padding(
              //         padding: EdgeInsets.only(
              //             top: 12, left: 16, right: 16, bottom: 12),
              //         child: Row(
              //           mainAxisAlignment: MainAxisAlignment.start,
              //           crossAxisAlignment: CrossAxisAlignment.start,
              //           children: <Widget>[
              //             CircleAvatar(
              //               child: Text(_mailList[index].name[0]),
              //             ),
              //             Expanded(
              //               flex: 1,
              //               child: Padding(
              //                 padding: const EdgeInsets.only(left: 16.0),
              //                 child: Column(
              //                   children: <Widget>[
              //                     Row(
              //                       children: <Widget>[
              //                         Expanded(
              //                             flex: 1,
              //                             child: Text(_mailList[index].name,
              //                                 style: AppTheme.getTextStyle(
              //                                     themeData.textTheme.subtitle2,
              //                                     fontWeight:
              //                                         _mailList[index].isRead
              //                                             ? 600
              //                                             : 800))),
              //                         Text(_mailList[index].date,
              //                             style: AppTheme.getTextStyle(
              //                                 themeData.textTheme.subtitle2,
              //                                 fontWeight:
              //                                     _mailList[index].isRead
              //                                         ? 600
              //                                         : 800))
              //                       ],
              //                     ),
              //                     Text(_mailList[index].title,
              //                         style: AppTheme.getTextStyle(
              //                             themeData.textTheme.subtitle2,
              //                             fontWeight: _mailList[index].isRead
              //                                 ? 600
              //                                 : 800)),
              //                     Text(_mailList[index].message,
              //                         style: AppTheme.getTextStyle(
              //                             themeData.textTheme.bodyText2,
              //                             fontWeight: 600))
              //                   ],
              //                   crossAxisAlignment: CrossAxisAlignment.start,
              //                 ),
              //               ),
              //             )
              //           ],
              //         ),
              //       ),
              //     );
              //   },
              // ),
            ),
            drawer: MenuDrawerWidget(themeData, _scaffoldKey, 4),
          ),
        );
      },
    );
  }
}
