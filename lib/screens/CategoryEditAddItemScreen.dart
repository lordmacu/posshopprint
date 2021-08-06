import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:posshop_app/model/entity/ItemEntity.dart';
import 'package:posshop_app/model/entity/CategoryEntity.dart';
import 'package:posshop_app/screens/CategoryEditScreen.dart';
import 'package:posshop_app/service/CategoryService.dart';
import 'package:posshop_app/service/ItemService.dart';
import 'package:posshop_app/service/PosService.dart';
import 'package:posshop_app/utils/SelectedObject.dart';
import 'package:posshop_app/utils/SizeConfig.dart';
import 'package:posshop_app/widget/MenuDrawerWidget.dart';
import 'package:provider/provider.dart';

import '../AppTheme.dart';
import '../AppThemeNotifier.dart';

class CategoryEditAddItemScreen extends StatefulWidget {
  const CategoryEditAddItemScreen({Key? key}) : super(key: key);

  @override
  _CategoryEditAddItemScreenState createState() =>
      _CategoryEditAddItemScreenState();
}

class _CategoryEditAddItemScreenState
    extends State<CategoryEditAddItemScreen> {
  GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey =
      GlobalKey<ScaffoldMessengerState>();

  late ThemeData themeData;
  TextEditingController _searchQuery = new TextEditingController();
  ItemService itemService = ItemService();
  late Future<List<ItemEntity>> items = itemService.getAll();

  @override
  Widget build(BuildContext context) {
    //You will need to initialize MySize class for responsive spaces.
    MySize().init(context);
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
            title: Container(
              child: Row(
                children: <Widget>[
                  IconButton(
                    icon: Icon(Icons.close),
                    onPressed: () {
                      goBack();
                    },
                  ),
                  Expanded(
                    child: Text("Asignar artículos a la categoría",
                        style: AppTheme.getTextStyle(
                            themeData.textTheme.headline6,
                            fontWeight: 600)),
                  )
                ],
              ),
            ),
            actions: <Widget>[
              IconButton(
                icon: Icon(Icons.save),
                onPressed: () {
                  save();
                },
              ),
            ],
          ),
          body: Container(
            child: Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Expanded(
                      child: TextField(
                        autofocus: true,
                        controller: _searchQuery,
                        decoration: InputDecoration(
                          hintText: "Buscar artículo",
                          border: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          disabledBorder: InputBorder.none,
                          errorBorder: InputBorder.none,
                          focusedErrorBorder: InputBorder.none,
                          isDense: true,
                          contentPadding: EdgeInsets.only(top: MySize.size14!),
                          prefixIcon: Icon(
                            MdiIcons.magnify,
                            size: MySize.size22,
                            color: themeData.colorScheme.onBackground,
                          ),
                        ),
                      ),
                    ),
                    IconButton(
                      icon: Icon(
                        Icons.close,
                        size: MySize.size22,
                        color: themeData.colorScheme.onBackground,
                      ),
                      onPressed: () {
                        _searchQuery.text = "";
                      },
                    ),
                  ],
                ),
                Container(
                  color: themeData.backgroundColor,
                  child: FutureBuilder<List<ItemEntity>>(
                    future: items,
                    builder: (BuildContext context, AsyncSnapshot snapshot) {
                      if (snapshot.hasError)
                        return Text(snapshot.error.toString());

                      if (snapshot.hasData) {
                        return Container();
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
              ],
            ),
          ),
        ),
      );
    });
  }

  goBack() {
    Navigator.of(context).pop();
  }

  save() {}
}
