import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:posshop_app/model/entity/CategoryEntity.dart';
import 'package:posshop_app/screens/CategoryEditScreen.dart';
import 'package:posshop_app/service/CategoryService.dart';
import 'package:posshop_app/service/PosService.dart';
import 'package:posshop_app/utils/SelectedObject.dart';
import 'package:posshop_app/utils/SizeConfig.dart';
import 'package:posshop_app/widget/MenuDrawerWidget.dart';
import 'package:provider/provider.dart';

import '../AppTheme.dart';
import '../AppThemeNotifier.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({Key? key}) : super(key: key);

  @override
  _CategoryScreenState createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey = GlobalKey<ScaffoldMessengerState>();

  late ThemeData themeData;
  CategoryService categoryService = CategoryService();
  late Future<List<CategoryEntity>> categories = categoryService.getAll();

  bool _isSelectable = false;
  SelectedItem _selected = SelectedItem();

  late Widget appBarTitle;
  late Icon actionIcon;
  TextEditingController _searchQuery = new TextEditingController();
  bool _isSearching = false;
  String _searchText = "";

  _CategoryScreenState() {
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
    appBarTitle = Text("Categorías");
    super.initState();
  }

  @override
  void dispose() {
    _searchQuery.dispose();
    super.dispose();
  }

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
            appBar: PreferredSize(
              preferredSize: const Size.fromHeight(56),
              child: buildAppBar(context),
            ),
            body: Container(
              color: themeData.backgroundColor,
              child: FutureBuilder<List<CategoryEntity>>(
                future: categories,
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
                Navigator.push(context, MaterialPageRoute(builder: (context) => CategoryEditScreen(updateList: updateList)));
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
                    deleteCategorys();
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
      this.appBarTitle = Text("Categorías", style: AppTheme.getTextStyle(themeData.textTheme.headline6, fontWeight: 600));
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
              child: Text(" $totalSelected categoría${totalSelected > 1 ? 's' : ''}",
                  style: AppTheme.getTextStyle(themeData.textTheme.headline6, fontWeight: 600)),
            )
          ],
        ),
      );
    });
  }

  void _handleDeleteChange(CategoryEntity entity) {
    setState(() {
      _selected.changeSelected(entity);
    });
    _changeLabelDeleteAppBar();
  }

  void _handleDeleteEnd() {
    setState(() {
      this.actionIcon = Icon(Icons.search);
      this.appBarTitle = Text("Categorías", style: AppTheme.getTextStyle(themeData.textTheme.headline6, fontWeight: 600));
      _selected.reset();
      _isSelectable = false;
    });
    if (_isSearching) {
      _handleSearchStart();
    }
  }

  Widget filteredListView(BuildContext context, List<CategoryEntity> categoriesEntity) {
    List<CategoryEntity> data;
    if (_isSearching && _searchText.isNotEmpty) {
      data = List.from(categoriesEntity.where((category) => category.name.toLowerCase().contains(_searchText.toLowerCase())));
    } else {
      data = categoriesEntity;
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
                          builder: (context) => CategoryEditScreen(categoryEntity: data[index], updateList: updateList)));
                });
              } else {
                setState(() {
                  deleteCategory(data[index]);
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
                              builder: (context) => CategoryEditScreen(categoryEntity: data[index], updateList: updateList)));
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
                          _selected.isSelected(data[index]) ? themeData.colorScheme.primary : hexColor(data[index].color),
                          child: _selected.isSelected(data[index])
                              ? Icon(
                            Icons.done,
                            color: themeData.colorScheme.onSecondary,
                          )
                              : null,
                        ),
                        Expanded(
                          flex: 1,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 16.0),
                            child: Column(
                              children: <Widget>[
                                richTextListView(data[index]),
                                Text('${data[index].itemsCount.toString()} artículos'),
                              ],
                              crossAxisAlignment: CrossAxisAlignment.start,
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

  Widget richTextListView(CategoryEntity entity) {
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
        title: new Text('Eliminar categorías'),
        content: new Text('¿Estás seguro de eliminar las categorías seleccionados?'),
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
    //TODO mejorar el uso de la busqueda y marcado de categorias, para cuando se añade uno nuevo o elimina alguno
    Future.delayed(const Duration(milliseconds: 500), () //TODO despues de los insert no trae la informacion de inmediato
    {
      categoryService.getAll().then((value) {
        categories = Future.value(value);
        setState(() {});
      }).catchError((e) {
        showSnackBarWithFloating('No hay conexión a internet', 2);
      });
    });
  }

  deleteCategory(CategoryEntity categoryEntity) async {
    if ((await showDialog(
      context: context,
      builder: (context) => new AlertDialog(
        title: new Text('Eliminar categoria'),
        content: new Text('¿Estás seguro de eliminar la categoria?'),
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
        CategoryService categoryService = CategoryService();
        if (await categoryService.delete(categoryEntity).catchError((e) {
          showSnackBarWithFloating('No hay conexión a internet', 2);
        })) {
          await categoryService.updateAll().catchError((e) {
            showSnackBarWithFloating('No hay conexión a internet', 2);
          });
          updateList();
          showSnackBarWithFloating("Eliminado", 2);
        }
      }
    }
  }

  deleteCategorys() async {
    //TODO Mejorar esto de llamar a la BD para buscar el posId
    PosService posService = PosService();
    int? idPos = await posService.getPosId();

    if (idPos != null) {
      showSnackBarWithFloating('Borrando informacion', 3);
      CategoryService categoryService = CategoryService();

      _selected.getSelectedItems().forEach((element) async {
        await categoryService.delete(element).catchError((e) {
          showSnackBarWithFloating('No hay conexión a internet', 2);
        });
      });
      await categoryService.updateAll().catchError((e) {
        showSnackBarWithFloating('No hay conexión a internet', 2);
      });
      updateList();
      _handleDeleteEnd();
    }
  }

  Color hexColor(String hexString) {
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
    buffer.write(hexString.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }
}
