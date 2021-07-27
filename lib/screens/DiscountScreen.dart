import 'package:intl/intl.dart';

import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:posshop_app/model/entity/DiscountEntity.dart';
import 'package:posshop_app/screens/DiscountEditScreen.dart';
import 'package:posshop_app/service/DiscountService.dart';
import 'package:posshop_app/service/PosService.dart';
import 'package:posshop_app/utils/SelectedObject.dart';
import 'package:posshop_app/utils/SizeConfig.dart';
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
  late Future<List<DiscountEntity>> discounts = discountService.getAll();

  bool _isSelectable = false;
  SelectedItem _selected = SelectedItem();

  late Widget appBarTitle;
  late Icon actionIcon;
  TextEditingController _searchQuery = new TextEditingController();
  bool _isSearching = false;
  String _searchText = "";

  _DiscountScreenState() {
    _searchQuery.addListener(() {
      if (_searchQuery.text.isEmpty) {
        setState(() {
          _isSearching = false;
          _searchText = "";
        });
      } else {
        setState(() {
          _isSearching = true;
          _searchText = _searchQuery.text;
        });
      }
    });
  }

  @override
  void initState() {
    actionIcon = Icon(Icons.search);
    appBarTitle = Text("Descuentos");
    super.initState();
  }

  @override
  void dispose() {
    _searchQuery.dispose();
    super.dispose();
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
            appBar: PreferredSize(
              preferredSize: const Size.fromHeight(56),
              child: buildAppBar(context),
            ),
            body: Container(
              color: themeData.backgroundColor,
              child: FutureBuilder<List<DiscountEntity>>(
                future: discounts,
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.hasError) return Text(snapshot.error.toString());

                  if (snapshot.hasData) {
                    _selected.load(snapshot.data);

                    return filteredListView(context, snapshot.data);
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
                Navigator.push(context, MaterialPageRoute(builder: (context) => DiscountEditScreen(updateList: updateList)));
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
        (discountEntity.value == null)
            ? ''
            : ("PERCENT" == discountEntity.calculationType)
                ? percentFormat.format(discountEntity.value) /*'${discountEntity.value.toStringAsFixed(0)} %'*/
                : pesosInCLFormat.format(discountEntity.value),
        style: AppTheme.getTextStyle(
          themeData.textTheme.subtitle2,
          color: _selected.isSelected(discountEntity) ? themeData.colorScheme.onPrimary : themeData.colorScheme.onBackground,
        ));
  }

  void showSnackBarWithFloating(String message, [int duration = 1]) {
    scaffoldMessengerKey.currentState!.showSnackBar(
      new SnackBar(
        content: new Text(
          message,
          style: themeData.textTheme.subtitle2!.merge(TextStyle(color: themeData.colorScheme.onPrimary)),
        ),
        backgroundColor: themeData.colorScheme.primary,
        behavior: SnackBarBehavior.floating,
        duration: Duration(seconds: duration),
      ),
    );
  }

  Widget buildAppBar(BuildContext context) {
    return AppBar(
      title: appBarTitle,
      actions: <Widget>[
        IconButton(
          icon: actionIcon,
          onPressed: () {
            setState(() {
              if (actionIcon.icon == Icons.search) {
                _handleSearchStart();
              } else if (actionIcon.icon == Icons.delete) {
                showAlertDelete().then((value) {
                  if (value) {
                    deleteDiscounts();
                  }
                });
              } else {
                _handleSearchEnd();
              }
            });
          },
        ),
      ],
    );
  }

  void _handleSearchStart() {
    setState(() {
      _isSearching = true;
      actionIcon = Icon(Icons.close);
      appBarTitle = TextField(
        autofocus: true,
        controller: _searchQuery,
        decoration: InputDecoration(
          hintText: "Buscar",
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
      );
    });
  }

  void _handleSearchEnd() {
    setState(() {
      this.actionIcon = Icon(Icons.search);
      this.appBarTitle = Text("Descuentos", style: AppTheme.getTextStyle(themeData.textTheme.headline6, fontWeight: 600));
      _isSearching = false;
      _searchQuery.clear();
    });
  }

  void _handleDeleteStart() {
    setState(() {
      _isSelectable = true;
      actionIcon = Icon(Icons.delete);
      _changeLabelDeleteAppBar();
    });
  }

  void _changeLabelDeleteAppBar() {
    int totalSelected = _selected.totalSelected();
    setState(() {
      appBarTitle = Container(
        child: Row(
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.close),
              onPressed: () {
                _handleDeleteEnd();
              },
            ),
            Expanded(
              flex: 1,
              child: Text(" $totalSelected descuento${totalSelected > 1 ? 's' : ''}",
                  style: AppTheme.getTextStyle(themeData.textTheme.headline6, fontWeight: 600)),
            )
          ],
        ),
      );
    });
  }

  void _handleDeleteChange(DiscountEntity entity) {
    setState(() {
      _selected.changeSelected(entity);
    });
    _changeLabelDeleteAppBar();
  }

  void _handleDeleteEnd() {
    setState(() {
      this.actionIcon = Icon(Icons.search);
      this.appBarTitle = Text("Descuentos", style: AppTheme.getTextStyle(themeData.textTheme.headline6, fontWeight: 600));
      _selected.reset();
      _isSelectable = false;
    });
    if (_isSearching) {
      _handleSearchStart();
    }
  }

  Widget filteredListView(BuildContext context, List<DiscountEntity> discountsEntity) {
    List<DiscountEntity> data;
    if (_isSearching && _searchText.isNotEmpty) {
      data = List.from(discountsEntity.where((discount) => discount.name.toLowerCase().contains(_searchText.toLowerCase())));
    } else {
      data = discountsEntity;
    }

    return ListView.builder(
      padding: EdgeInsets.all(0),
      itemCount: data.length,
      itemBuilder: (context, index) {
        return Ink(
          color: _selected.isSelected(data[index]) ? themeData.colorScheme.primary : themeData.backgroundColor,
          child: Dismissible(
            background: Container(
              color: themeData.primaryColor,
              padding: EdgeInsets.symmetric(horizontal: 20),
              alignment: AlignmentDirectional.centerStart,
              child: Row(
                children: <Widget>[
                  Icon(
                    MdiIcons.inboxArrowDown,
                    color: themeData.colorScheme.onPrimary,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Text("Editar",
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
                  Text("Eliminar",
                      style: AppTheme.getTextStyle(themeData.textTheme.bodyText2,
                          fontWeight: 500, color: themeData.colorScheme.onPrimary)),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Icon(
                      MdiIcons.delete,
                      color: themeData.colorScheme.onPrimary,
                    ),
                  ),
                ],
              ),
            ),
            onDismissed: (direction) {
              if (direction == DismissDirection.startToEnd) {
                setState(() {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => DiscountEditScreen(discountEntity: data[index], updateList: updateList)));
                });
              } else {
                setState(() {
                  deleteDiscount(data[index]);
                });
              }
            },
            key: UniqueKey(),
            child: Container(
              color: _selected.isSelected(data[index]) ? themeData.colorScheme.primary : themeData.backgroundColor,
              child: Padding(
                padding: EdgeInsets.only(top: 12, left: 16, right: 16, bottom: 12),
                child: GestureDetector(
                  onTap: () {
                    if (_isSelectable) {
                      _handleDeleteChange(data[index]);
                    } else {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => DiscountEditScreen(discountEntity: data[index], updateList: updateList)));
                    }
                    if (_selected.totalSelected() < 1) {
                      _handleDeleteEnd();
                    }
                  },
                  onLongPress: () {
                    if (!_isSelectable) {
                      _handleDeleteStart();
                    }
                    _handleDeleteChange(data[index]);
                  },
                  child: Container(
                    color: _selected.isSelected(data[index]) ? themeData.colorScheme.primary : themeData.backgroundColor,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        CircleAvatar(
                          backgroundColor:
                              _selected.isSelected(data[index]) ? themeData.colorScheme.primary : themeData.colorScheme.primary.withAlpha(240),
                          child: _selected.isSelected(data[index])
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
                            child: Row(
                              children: <Widget>[
                                Expanded(flex: 1, child: richTextListView(data[index])),
                                discountValue(data[index], index)
                              ],
                              crossAxisAlignment: CrossAxisAlignment.center,
                            ),
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
  }

  Widget richTextListView(DiscountEntity entity) {
    if (_isSearching && _searchText.isNotEmpty) {
      return RichText(
        text: TextSpan(
          text: entity.name.substring(0, entity.name.toLowerCase().indexOf(_searchText.toLowerCase())),
          style: AppTheme.getTextStyle(
            themeData.textTheme.subtitle2,
            color: _selected.isSelected(entity) ? themeData.colorScheme.onPrimary : themeData.colorScheme.onBackground,
          ),
          children: <TextSpan>[
            TextSpan(
                text: entity.name.substring(entity.name.toLowerCase().indexOf(_searchText.toLowerCase()),
                    entity.name.toLowerCase().indexOf(_searchText.toLowerCase()) + _searchText.length),
                style: AppTheme.getTextStyle(
                  themeData.textTheme.subtitle2,
                  color: _selected.isSelected(entity) ? themeData.colorScheme.onPrimary : themeData.colorScheme.onBackground,
                  fontWeight: 800,
                )),
            TextSpan(
              text: entity.name.substring(entity.name.toLowerCase().indexOf(_searchText.toLowerCase()) + _searchText.length, entity.name.length),
              style: AppTheme.getTextStyle(
                themeData.textTheme.subtitle2,
                color: _selected.isSelected(entity) ? themeData.colorScheme.onPrimary : themeData.colorScheme.onBackground,
              ),
            ),
          ],
        ),
      );
    } else {
      return Text(entity.name,
          style: AppTheme.getTextStyle(
            themeData.textTheme.subtitle2,
            color: _selected.isSelected(entity) ? themeData.colorScheme.onPrimary : themeData.colorScheme.onBackground,
          ));
    }
  }

  Future<bool> showAlertDelete() async {
    return (await showDialog(
          context: context,
          builder: (context) => new AlertDialog(
            title: new Text('Eliminar descuentos'),
            content: new Text('¿Estás seguro de eliminar los descuentos seleccionados?'),
            actions: <Widget>[
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: new Text('CANCELAR'),
              ),
              TextButton(
                onPressed: () => Navigator.of(context).pop(true),
                child: new Text('RETIRAR'),
              ),
            ],
          ),
        )) ??
        false;
  }

  void updateList() {
    //TODO mejorar el uso de la busqueda y marcado de descuentos, para cuando se añade uno nuevo o elimina alguno
    Future.delayed(const Duration(milliseconds: 500), () //TODO despues de los insert no trae la informacion de inmediato
        {
      discountService.getAll().then((value) {
        discounts = Future.value(value);
        setState(() {});
      });
    });
  }

  deleteDiscount(DiscountEntity discountEntity) async {
    if ((await showDialog(
          context: context,
          builder: (context) => new AlertDialog(
            title: new Text('Eliminar descuento'),
            content: new Text('¿Estás seguro de eliminar el descuento?'),
            actions: <Widget>[
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: new Text('CANCELAR'),
              ),
              TextButton(
                onPressed: () => Navigator.of(context).pop(true),
                child: new Text('RETIRAR'),
              ),
            ],
          ),
        )) ??
        false) {
      PosService posService = PosService();
      int? idPos = await posService.getPosId();

      if (idPos != null) {
        DiscountService discountService = DiscountService();
        if (await discountService.delete(discountEntity)) {
          await discountService.updateAll(idPos);
          updateList();
          showSnackBarWithFloating("Eliminado", 2);
        }
      }
    }
  }

  deleteDiscounts() async {
    //TODO Mejorar esto de llamar a la BD para buscar el posId
    PosService posService = PosService();
    int? idPos = await posService.getPosId();

    if (idPos != null) {
      showSnackBarWithFloating('Borrando informacion', 3);
      DiscountService discountService = DiscountService();

      _selected.getSelectedItems().forEach((element) async {
        await discountService.delete(element);
      });
      await discountService.updateAll(idPos);
      updateList();
      _handleDeleteEnd();
    }
  }
}
