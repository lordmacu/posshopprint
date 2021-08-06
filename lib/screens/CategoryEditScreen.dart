import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:posshop_app/model/entity/CategoryEntity.dart';
import 'package:posshop_app/service/CategoryService.dart';
import 'package:posshop_app/utils/SizeConfig.dart';
import 'package:provider/provider.dart';
import 'package:posshop_app/screens/CategoryEditAddItemScreen.dart';

import '../AppTheme.dart';
import '../AppThemeNotifier.dart';

typedef UpdateListCallback = void Function();

class CategoryEditScreen extends StatefulWidget {
  final CategoryEntity? categoryEntity;
  final UpdateListCallback updateList;

  const CategoryEditScreen(
      {Key? key, this.categoryEntity, required this.updateList})
      : super(key: key);

  @override
  _CategoryEditScreenState createState() => _CategoryEditScreenState();
}

class _CategoryEditScreenState extends State<CategoryEditScreen> {
  final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey =
      GlobalKey<ScaffoldMessengerState>();
  final _formKey = GlobalKey<FormState>();
  late ThemeData themeData;
  late CustomAppTheme customAppTheme;
  late CategoryEntity categoryEntity;

  bool _isButtonSaveDisabled = false;
  bool _isButtonDeleteDisabled = false;
  late TextEditingController txtValorController;

  final int maxItemsHorizontal = 4;
  List<ColorButton> colorsButton = [
    ColorButton(color: '#E0E0E0', selected: true),
    ColorButton(color: '#F44336'),
    ColorButton(color: '#E91E63'),
    ColorButton(color: '#FF9800'),
    ColorButton(color: '#CDDC39'),
    ColorButton(color: '#4CAF50'),
    ColorButton(color: '#2196F3'),
    ColorButton(color: '#9C27B0')
  ];

  @override
  void initState() {
    if (widget.categoryEntity == null) {
      categoryEntity = CategoryEntity(
          idCloud: 0, name: '', color: colorsButton[0].color, itemsCount: 0);
      txtValorController = TextEditingController();
    } else {
      categoryEntity = CategoryEntity(
        idCloud: widget.categoryEntity!.idCloud,
        name: widget.categoryEntity!.name,
        color: widget.categoryEntity!.color,
        itemsCount: widget.categoryEntity!.itemsCount,
        id: widget.categoryEntity!.id,
      );
      pickColor(categoryEntity.color);
      txtValorController = TextEditingController();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //You will need to initialize MySize class for responsive spaces.
    MySize().init(context);
    themeData = Theme.of(context);
    return Consumer<AppThemeNotifier>(
      builder: (BuildContext context, AppThemeNotifier value, Widget? child) {
        customAppTheme = AppTheme.getCustomAppTheme(value.themeMode());
        return MaterialApp(
          scaffoldMessengerKey: scaffoldMessengerKey,
          debugShowCheckedModeBanner: false,
          theme: AppTheme.getThemeFromThemeMode(value.themeMode()),
          home: Scaffold(
            appBar: AppBar(
              elevation: 0,
              backgroundColor: themeData.appBarTheme.color,
              title: Text(
                  widget.categoryEntity == null
                      ? "Crear categoría"
                      : "Editar categoría",
                  style: AppTheme.getTextStyle(themeData.textTheme.headline6,
                      fontWeight: 600)),
              leading: IconButton(
                onPressed: () {
                  goBack();
                },
                icon: Icon(
                  MdiIcons.chevronLeft,
                  color: themeData.colorScheme.onBackground,
                ),
              ),
            ),
            backgroundColor: themeData.scaffoldBackgroundColor,
            body: Form(
              key: _formKey,
              child: Container(
                padding: EdgeInsets.only(
                    left: MySize.size24!, right: MySize.size24!),
                child: ListView(
                  shrinkWrap: true,
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(top: MySize.size24!),
                      child: TextFormField(
                        decoration: InputDecoration(
                          labelText: "Nombre",
                          hintText: "Nombre",
                          border: themeData.inputDecorationTheme.border,
                          enabledBorder: themeData.inputDecorationTheme.border,
                          focusedBorder:
                              themeData.inputDecorationTheme.focusedBorder,
                          prefixIcon: Icon(
                            MdiIcons.cardText,
                            size: MySize.size22,
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'El campo no puede estar en blanco';
                          }
                        },
                        onChanged: (value) {
                          setState(() => categoryEntity.name = value);
                        },
                        initialValue: categoryEntity.name,
                        // controller: TextEditingController(text: categoryEntity.name),
                        keyboardType: TextInputType.text,
                        textCapitalization: TextCapitalization.sentences,
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: MySize.size24!),
                      child: Text(
                        "Color de la categoría",
                        style: AppTheme.getTextStyle(
                            themeData.textTheme.bodyText1,
                            fontWeight: 600),
                      ),
                    ),
                    Container(
                      height: 200,
                      margin: EdgeInsets.only(top: MySize.size24!),
                      child: GridView.count(
                        crossAxisCount: 4,
                        children: List.of(colorsButton.map((color) => Card(
                              margin: EdgeInsets.all(MySize.size8!),
                              child: InkWell(
                                onTap: () {
                                  pickColor(color.color);
                                },
                                child: Container(
                                  color: hexColor(color.color),
                                  width: 70.0,
                                  height: 70.0,
                                  child: (color.selected)
                                      ? Icon(Icons.check,
                                          color: Colors.white, size: 30.0)
                                      : null,
                                ),
                              ),
                            ))),
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        color: customAppTheme.bgLayer1,
                        borderRadius:
                            BorderRadius.all(Radius.circular(MySize.size48!)),
                      ),
                      margin: EdgeInsets.only(top: MySize.size24!),
                      child: OutlinedButton.icon(
                        style: ButtonStyle(
                            padding:
                                MaterialStateProperty.all(Spacing.xy(16, 0))),
                        onPressed: () {
                          addItems();
                        },
                        icon: Icon(
                          MdiIcons.formatListBulleted,
                          color: themeData.colorScheme.onBackground,
                        ),
                        label: Text(
                          "ASIGNAR ARTÍCULOS",
                          style: AppTheme.getTextStyle(
                              themeData.textTheme.bodyText1,
                              fontWeight: 600,
                              color: themeData.colorScheme.onBackground),
                        ),
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        borderRadius:
                            BorderRadius.all(Radius.circular(MySize.size48!)),
                        boxShadow: [
                          BoxShadow(
                            color: themeData.primaryColor.withAlpha(20),
                            spreadRadius: 2,
                            offset: Offset(0, 2),
                          ),
                        ],
                      ),
                      margin: EdgeInsets.only(top: MySize.size24!),
                      child: ElevatedButton.icon(
                        style: ButtonStyle(
                            padding:
                                MaterialStateProperty.all(Spacing.xy(16, 0))),
                        onPressed: _isButtonSaveDisabled
                            ? null
                            : () {
                                if (_formKey.currentState!.validate()) {
                                  saveCategory();
                                }
                              },
                        icon: Icon(
                          MdiIcons.contentSaveOutline,
                          color: themeData.colorScheme.onPrimary,
                        ),
                        label: Text(
                          "GUARDAR",
                          style: AppTheme.getTextStyle(
                              themeData.textTheme.bodyText1,
                              fontWeight: 600,
                              color: themeData.colorScheme.onPrimary),
                        ),
                      ),
                    ),
                    widget.categoryEntity == null
                        ? Container()
                        : Container(
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                              color: customAppTheme.bgLayer1,
                              borderRadius: BorderRadius.all(
                                  Radius.circular(MySize.size48!)),
                            ),
                            margin: EdgeInsets.only(top: MySize.size24!),
                            child: OutlinedButton.icon(
                              style: ButtonStyle(
                                  padding: MaterialStateProperty.all(
                                      Spacing.xy(16, 0))),
                              onPressed: _isButtonDeleteDisabled
                                  ? null
                                  : () {
                                      deleteCategory();
                                    },
                              icon: Icon(
                                MdiIcons.delete,
                                color: themeData.colorScheme.onBackground,
                              ),
                              label: Text(
                                "ELIMINAR",
                                style: AppTheme.getTextStyle(
                                    themeData.textTheme.bodyText1,
                                    fontWeight: 600,
                                    color: themeData.colorScheme.onBackground),
                              ),
                            ),
                          ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  goBack() async {
    bool areChanges = false;
    if (widget.categoryEntity == null &&
        (categoryEntity.name.isNotEmpty || categoryEntity.color.isNotEmpty)) {
      areChanges = true;
    } else if (widget.categoryEntity != null &&
        (widget.categoryEntity!.name != categoryEntity.name ||
            widget.categoryEntity!.color != categoryEntity.color)) {
      areChanges = true;
    }

    if (areChanges) {
      if ((await showDialog(
            context: context,
            builder: (context) => new AlertDialog(
              title: new Text('Cambios no guardados'),
              content: new Text(
                  '¿Seguro que quiere continuar sin guardar los cambios?'),
              actions: <Widget>[
                TextButton(
                  onPressed: () => Navigator.of(context).pop(false),
                  child: new Text('CANCELAR'),
                ),
                TextButton(
                  onPressed: () => Navigator.of(context).pop(true),
                  child: new Text('CONTINUAR'),
                ),
              ],
            ),
          )) ??
          false) {
        Navigator.of(context).pop();
      }
    } else {
      Navigator.of(context).pop();
    }
  }

  saveCategory() async {
    setState(() {
      _isButtonSaveDisabled = true;
      _isButtonDeleteDisabled = true;
    });

    CategoryService categoryService = CategoryService();
    categoryService.save(categoryEntity).then((success) async {
      if (success) {
        categoryService.updateAll().then((value) {
          widget.updateList();
          Navigator.of(context).pop();
        });
      }
    }).catchError((e) {
      print(e);
      showSnackBarWithFloating('No hay conexión a internet', 2);
      setState(() {
        _isButtonSaveDisabled = false;
        _isButtonDeleteDisabled = false;
      });
    });
  }

  deleteCategory() async {
    if ((await showDialog(
          context: context,
          builder: (context) => new AlertDialog(
            title: new Text('Eliminar categoría'),
            content: new Text('¿Estás seguro de eliminar la categoría?'),
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
      setState(() {
        _isButtonSaveDisabled = true;
        _isButtonDeleteDisabled = true;
      });

      CategoryService categoryService = CategoryService();
      if (await categoryService.delete(categoryEntity).catchError((e) {
        showSnackBarWithFloating('No hay conexión a internet', 2);
        setState(() {
          _isButtonSaveDisabled = false;
          _isButtonDeleteDisabled = false;
        });
      })) {
        await categoryService.updateAll().catchError((e) {
          showSnackBarWithFloating('No hay conexión a internet', 2);
        });
        widget.updateList();
      }
      Navigator.of(context).pop();
    }
  }

  addItems() {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => CategoryEditAddItemScreen()));
  }

  void showSnackBarWithFloating(String message, [int duration = 1]) {
    scaffoldMessengerKey.currentState!.showSnackBar(
      new SnackBar(
        content: new Text(
          message,
          style: themeData.textTheme.subtitle2!
              .merge(TextStyle(color: themeData.colorScheme.onPrimary)),
        ),
        backgroundColor: themeData.colorScheme.primary,
        behavior: SnackBarBehavior.floating,
        duration: Duration(seconds: duration),
      ),
    );
  }

  Color hexColor(String hexString) {
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
    buffer.write(hexString.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }

  pickColor(String color) {
    setState(() => {
          colorsButton.forEach((colorButton) {
            if (colorButton.color == color) {
              colorButton.selected = true;
              categoryEntity.color = color;
            } else {
              colorButton.selected = false;
            }
          })
        });
  }
}

class ColorButton {
  String color;
  bool selected;

  ColorButton({required this.color, this.selected = false});
}
