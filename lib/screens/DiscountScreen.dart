import 'package:intl/intl.dart';

import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:posshop_app/model/entity/DiscountEntity.dart';
import 'package:posshop_app/screens/DiscountEditScreen.dart';
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

  bool _isSelectable = false;
  List<bool> _selected = List.empty();

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
              child: FutureBuilder<List<DiscountEntity>>(
                future: discountService.getAll(),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.hasError) return Text(snapshot.error.toString());

                  if (snapshot.hasData) {
                    if (_selected.isEmpty) {
                      _selected = List.generate(snapshot.data.length, (index) => false);
                    }

                    return ListView.builder(
                      padding: EdgeInsets.all(0),
                      itemCount: snapshot.data.length,
                      itemBuilder: (context, index) {
                        return Ink(
                          color: _selected[index] ? themeData.colorScheme.primary : themeData.backgroundColor,
                          child: Dismissible(
                            background: Container(
                              color: themeData.primaryColor,
                              padding: EdgeInsets.symmetric(horizontal: 20),
                              alignment: AlignmentDirectional.centerStart,
                              child: Row(
                                children: <Widget>[
                                  Icon(
                                    MdiIcons.delete,
                                    color: themeData.colorScheme.onPrimary,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 8.0),
                                    child: Text("Delete",
                                        style: AppTheme.getTextStyle(themeData.textTheme.bodyText2,
                                            fontWeight: 500, color: themeData.colorScheme.onPrimary)),
                                  )
                                ],
                              ),
                            ),
                            secondaryBackground: Container(
                              color: themeData.primaryColor,
                              padding: EdgeInsets.symmetric(horizontal: 20),
                              alignment: AlignmentDirectional.centerEnd,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: <Widget>[
                                  Text("Archive",
                                      style: AppTheme.getTextStyle(themeData.textTheme.bodyText2,
                                          fontWeight: 500, color: themeData.colorScheme.onPrimary)),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 8.0),
                                    child: Icon(
                                      MdiIcons.inboxArrowDown,
                                      color: themeData.colorScheme.onPrimary,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            onDismissed: (direction) {
                              if (direction == DismissDirection.endToStart) {
                                setState(() {
                                  snapshot.data.removeAt(index);
                                  showSnackBarWithFloating("Archived");
                                });
                              } else {
                                setState(() {
                                  snapshot.data.removeAt(index);
                                  showSnackBarWithFloating("Deleted");
                                });
                              }
                            },
                            key: UniqueKey(),
                            child: Container(
                              color: _selected[index] ? themeData.colorScheme.primary : themeData.backgroundColor,
                              child: Padding(
                                padding: EdgeInsets.only(top: 12, left: 16, right: 16, bottom: 12),
                                child: GestureDetector(
                                  onTap: () {
                                    if (_isSelectable) {
                                      setState(() => _selected[index] = !_selected[index]);
                                      debugPrint('onTap index $index selected = ${_selected[index]}');
                                    }
                                    if (_selected.indexOf(true) == -1) {
                                      debugPrint('Select mode Disabled');
                                      setState(() => _isSelectable = false);
                                    }

                                    showSnackBarWithFloating("On Tap");
                                  },
                                  onLongPress: () {
                                    if (_isSelectable) {
                                      setState(() => _selected[index] = !_selected[index]);
                                      debugPrint('onLongPress index $index selected = ${_selected[index]}');
                                    } else {
                                      debugPrint('Select mode Enabled');
                                      setState(() {
                                        _isSelectable = true;
                                        _selected[index] = !_selected[index];
                                      });
                                      debugPrint('onLongPress index $index selected = ${_selected[index]}');
                                    }
                                  },
                                  child: Container(
                                    color: _selected[index] ? themeData.colorScheme.primary : themeData.backgroundColor,
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: <Widget>[
                                        CircleAvatar(
                                          backgroundColor: _selected[index]
                                              ? themeData.colorScheme.primary
                                              : themeData.colorScheme.primary.withAlpha(240),
                                          child: _selected[index]
                                              ? Icon(
                                                  Icons.done,
                                                  color: themeData.colorScheme.onSecondary,
                                                )
                                              : Icon(
                                                  MdiIcons.tag,
                                                  color: themeData.colorScheme.onPrimary,
                                                ),
                                        ),
                                        Expanded(
                                          flex: 1,
                                          child: Padding(
                                            padding: const EdgeInsets.only(left: 16.0),
                                            child: /*Column(
                                          children: <Widget>[*/
                                                Row(
                                              children: <Widget>[
                                                Expanded(
                                                    flex: 1,
                                                    child: Text(snapshot.data[index].name,
                                                        style: AppTheme.getTextStyle(
                                                          themeData.textTheme.subtitle2,
                                                          color: _selected[index]
                                                              ? themeData.colorScheme.onPrimary
                                                              : themeData.colorScheme.onBackground,
                                                          /*fontWeight: snapshot.data[index].isRead ? 600 : 800*/
                                                        ))),
                                                discountValue(snapshot.data[index], index)
                                              ],
                                              crossAxisAlignment: CrossAxisAlignment.center,
                                            ),
                                            // Text(snapshot.data[index].value.toString(),
                                            //     style: AppTheme.getTextStyle(
                                            //       themeData.textTheme.subtitle2,
                                            //       fontWeight: snapshot.data[index].isRead ? 600 : 800
                                            //     )),
                                            // Text(snapshot.data[index].message,
                                            //     style: AppTheme.getTextStyle(themeData.textTheme.bodyText2, fontWeight: 600))
                                            /*],
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                        ),*/
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  } else {
                    return Container(
                      child: Center(
                        child: Text('Cargando...'),
                      ),
                    );
                  }
                },
              ),
            ),
            drawer: MenuDrawerWidget(themeData, _scaffoldKey, 4),
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => DiscountEditScreen()));
              },
              child: Icon(
                MdiIcons.plus,
                color: themeData.colorScheme.onPrimary,
              ),
            ),
          ),
        );
      },
    );
  }

  Widget discountValue(DiscountEntity discountEntity, int index) {
    var pesosInCLFormat = NumberFormat.currency(locale: "es_CL", symbol: "\$", decimalDigits: 0);
    var percentFormat = NumberFormat.currency(locale: 'es_CL', symbol: '%');

    return Text(
        ("PERCENT" == discountEntity.calculationType)
            ? percentFormat.format(discountEntity.value) /*'${discountEntity.value.toStringAsFixed(0)} %'*/
            : pesosInCLFormat.format(discountEntity.value),
        style: AppTheme.getTextStyle(
          themeData.textTheme.subtitle2,
          color: _selected[index] ? themeData.colorScheme.onPrimary : themeData.colorScheme.onBackground,
        ));
  }

  void showSnackBarWithFloating(String message) {
    scaffoldMessengerKey.currentState!.showSnackBar(
      new SnackBar(
        content: new Text(
          message,
          style: themeData.textTheme.subtitle2!.merge(TextStyle(color: themeData.colorScheme.onPrimary)),
        ),
        backgroundColor: themeData.colorScheme.primary,
        behavior: SnackBarBehavior.floating,
        duration: Duration(seconds: 1),
      ),
    );
  }
}
