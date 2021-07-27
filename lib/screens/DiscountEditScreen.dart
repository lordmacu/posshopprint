import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:posshop_app/api/exceptions/ConnectionException.dart';
import 'package:posshop_app/model/entity/DiscountEntity.dart';
import 'package:posshop_app/service/DiscountService.dart';
import 'package:posshop_app/service/PosService.dart';
import 'package:posshop_app/utils/NumberTextInputFormatter.dart';
import 'package:posshop_app/utils/PercentTextInputFormatter.dart';
import 'package:posshop_app/utils/SizeConfig.dart';
import 'package:provider/provider.dart';

import '../AppTheme.dart';
import '../AppThemeNotifier.dart';

typedef UpdateListCallback = void Function();

class DiscountEditScreen extends StatefulWidget {
  final DiscountEntity? discountEntity;
  final UpdateListCallback updateList;

  const DiscountEditScreen({Key? key, this.discountEntity, required this.updateList}) : super(key: key);

  @override
  _DiscountEditScreenState createState() => _DiscountEditScreenState();
}

class _DiscountEditScreenState extends State<DiscountEditScreen> {
  final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey = GlobalKey<ScaffoldMessengerState>();
  final _formKey = GlobalKey<FormState>();
  late ThemeData themeData;
  late CustomAppTheme customAppTheme;
  late DiscountEntity discountEntity;

  bool _isButtonSaveDisabled = false;
  bool _isButtonDeleteDisabled = false;
  late TextEditingController txtValorController;
  List<bool> toggleButtonsSelected = [true, false];

  @override
  void initState() {
    if (widget.discountEntity == null) {
      discountEntity = DiscountEntity(idCloud: 0, name: '', calculationType: '');
      txtValorController = TextEditingController();
    } else {
      discountEntity = DiscountEntity(
        idCloud: widget.discountEntity!.idCloud,
        name: widget.discountEntity!.name,
        value: widget.discountEntity!.value,
        calculationType: widget.discountEntity!.calculationType,
        id: widget.discountEntity!.id,
      );
      txtValorController = TextEditingController();

      if (discountEntity.calculationType == "PERCENT") {
        if (discountEntity.value != null) {
          txtValorController = TextEditingController(text: discountEntity.value!.toStringAsFixed(2).replaceAll(".", ","));
        }
      } else {
        toggleButtonsSelected = [false, true];
        if (discountEntity.value != null) {
          NumberFormat format = NumberFormat.currency(locale: "es_CL", symbol: '', decimalDigits: 0);
          txtValorController = TextEditingController(text: format.format(discountEntity.value).trim());
        }
      }
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
              title: Text(widget.discountEntity == null ? "Crear descuento" : "Editar descuento",
                  style: AppTheme.getTextStyle(themeData.textTheme.headline6, fontWeight: 600)),
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
                padding: EdgeInsets.only(left: MySize.size24!, right: MySize.size24!),
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
                          focusedBorder: themeData.inputDecorationTheme.focusedBorder,
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
                          setState(() => discountEntity.name = value);
                        },
                        initialValue: discountEntity.name,
                        // controller: TextEditingController(text: discountEntity.name),
                        keyboardType: TextInputType.text,
                        textCapitalization: TextCapitalization.sentences,
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: MySize.size24!),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Expanded(
                            flex: 1,
                            child: Column(
                              children: <Widget>[
                                TextFormField(
                                  decoration: InputDecoration(
                                    labelText: "Valor",
                                    hintText: "Valor",
                                    border: themeData.inputDecorationTheme.border,
                                    enabledBorder: themeData.inputDecorationTheme.border,
                                    focusedBorder: themeData.inputDecorationTheme.focusedBorder,
                                    prefixIcon: Icon(
                                      MdiIcons.cardText,
                                      size: MySize.size22,
                                    ),
                                  ),
                                  onChanged: (value) {
                                    setState(() => discountEntity.value =
                                        value.isEmpty ? null : double.parse(value.replaceAll(".", "").replaceAll(",", ".")));
                                    txtValorController.selection = TextSelection.fromPosition(TextPosition(offset: value.length));
                                  },
                                  controller: txtValorController,
                                  keyboardType: TextInputType.number,
                                  inputFormatters: [
                                    toggleButtonsSelected[0]
                                        ? PercentTextInputFormatter(decimalRange: 2, maxValue: 100)
                                        : NumberTextInputFormatter(maxValue: 99999999),
                                  ],
                                  textCapitalization: TextCapitalization.sentences,
                                ),
                                Container(
                                  margin: Spacing.top(MySize.size4!),
                                  child: Text("Dejar el campo en blanco para ingresar el valor durante la venta"),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(left: MySize.size16!, top: MySize.size8!),
                            child: ToggleButtons(
                              splashColor: themeData.colorScheme.primary.withAlpha(48),
                              color: themeData.colorScheme.onBackground,
                              fillColor: themeData.colorScheme.primary.withAlpha(48),
                              selectedBorderColor: themeData.colorScheme.primary.withAlpha(48),
                              children: <Widget>[
                                Icon(
                                  MdiIcons.percent,
                                  color: themeData.colorScheme.onBackground,
                                ),
                                Icon(
                                  Icons.attach_money,
                                  color: themeData.colorScheme.onBackground,
                                ),
                              ],
                              isSelected: toggleButtonsSelected,
                              onPressed: (int index) {
                                setState(() {
                                  if (!toggleButtonsSelected[index]) {
                                    txtValorController = TextEditingController();
                                    discountEntity.value = null;
                                    txtValorController.selection = TextSelection.fromPosition(TextPosition(offset: 0));
                                  }
                                  for (int x = 0; x < toggleButtonsSelected.length; x++) {
                                    toggleButtonsSelected[x] = x == index;
                                  }
                                });
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(MySize.size48!)),
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
                        style: ButtonStyle(padding: MaterialStateProperty.all(Spacing.xy(16, 0))),
                        onPressed: _isButtonSaveDisabled
                            ? null
                            : () {
                                if (_formKey.currentState!.validate()) {
                                  saveDiscount();
                                }
                              },
                        icon: Icon(
                          MdiIcons.contentSaveOutline,
                          color: themeData.colorScheme.onPrimary,
                        ),
                        label: Text(
                          "GUARDAR",
                          style: AppTheme.getTextStyle(themeData.textTheme.bodyText1,
                              fontWeight: 600, color: themeData.colorScheme.onPrimary),
                        ),
                      ),
                    ),
                    widget.discountEntity == null
                        ? Container()
                        : Container(
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                              color: customAppTheme.bgLayer1,
                              borderRadius: BorderRadius.all(Radius.circular(MySize.size48!)),
                            ),
                            margin: EdgeInsets.only(top: MySize.size24!),
                            child: OutlinedButton.icon(
                              style: ButtonStyle(padding: MaterialStateProperty.all(Spacing.xy(16, 0))),
                              onPressed: _isButtonDeleteDisabled
                                  ? null
                                  : () {
                                      deleteDiscount();
                                    },
                              icon: Icon(
                                MdiIcons.delete,
                                color: themeData.colorScheme.onBackground,
                              ),
                              label: Text(
                                "ELIMINAR",
                                style: AppTheme.getTextStyle(themeData.textTheme.bodyText1,
                                    fontWeight: 600, color: themeData.colorScheme.onBackground),
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
    if (widget.discountEntity == null && (discountEntity.name.isNotEmpty || discountEntity.value != null)) {
      areChanges = true;
    } else if (widget.discountEntity != null &&
        (widget.discountEntity!.name != discountEntity.name || widget.discountEntity!.value != discountEntity.value)) {
      areChanges = true;
    }

    if (areChanges) {
      if ((await showDialog(
            context: context,
            builder: (context) => new AlertDialog(
              title: new Text('Cambios no guardados'),
              content: new Text('¿Seguro que quiere continuar sin guardar los cambios?'),
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

  saveDiscount() async {
    setState(() => _isButtonSaveDisabled = true);

    PosService posService = PosService();
    int? idPos = await posService.getPosId();

    if (idPos != null) {
      if (toggleButtonsSelected[0]) {
        discountEntity.calculationType = 'PERCENT';
      } else {
        discountEntity.calculationType = 'AMOUNT';
      }
      DiscountService discountService = DiscountService();
      discountService.save(idPos, discountEntity).then((success) async {
        if (success) {
          discountService.updateAll(idPos).then((value) {
            widget.updateList();
            Navigator.of(context).pop();
          });
        }
      }).catchError((e) {
        print(e.toString());
        print('Error Final');
        showSnackBarWithFloating('No hay conexión a internet', 2);
        setState(() => _isButtonSaveDisabled = false);
      });
    }
  }

  deleteDiscount() async {
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
      setState(() => _isButtonDeleteDisabled = true);
      PosService posService = PosService();
      int? idPos = await posService.getPosId();

      if (idPos != null) {
        DiscountService discountService = DiscountService();
        if (await discountService.delete(discountEntity)) {
          await discountService.updateAll(idPos);
          widget.updateList();
        }
        Navigator.of(context).pop();
      }
    }
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
}
