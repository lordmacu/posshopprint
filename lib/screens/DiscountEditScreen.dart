import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:posshop_app/model/entity/DiscountEntity.dart';
import 'package:posshop_app/utils/SizeConfig.dart';
import 'package:provider/provider.dart';

import '../AppTheme.dart';
import '../AppThemeNotifier.dart';

class DiscountEditScreen extends StatefulWidget {
  final DiscountEntity? discountEntity;

  const DiscountEditScreen({Key? key, this.discountEntity}) : super(key: key);

  @override
  _DiscountEditScreenState createState() => _DiscountEditScreenState();
}

class _DiscountEditScreenState extends State<DiscountEditScreen> {
  final _formKey = GlobalKey<FormState>();
  late ThemeData themeData;
  late CustomAppTheme customAppTheme;

  @override
  Widget build(BuildContext context) {
    //You will need to initialize MySize class for responsive spaces.
    MySize().init(context);
    themeData = Theme.of(context);
    return Consumer<AppThemeNotifier>(
      builder: (BuildContext context, AppThemeNotifier value, Widget? child) {
        customAppTheme = AppTheme.getCustomAppTheme(value.themeMode());
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: AppTheme.getThemeFromThemeMode(value.themeMode()),
          home: Scaffold(
            appBar: AppBar(
              elevation: 0,
              backgroundColor: themeData.appBarTheme.color,
              title: Text(widget.discountEntity == null ? "Crear descuento" : "Editar descuento",
                  style: AppTheme.getTextStyle(themeData.textTheme.headline6, fontWeight: 600)),
              leading: IconButton(
                onPressed: () => Navigator.of(context).pop(),
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
                child: Center(
                  child: ListView(
                    shrinkWrap: true,
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.only(top: MySize.size24!),
                        child: TextFormField(
                          style: AppTheme.getTextStyle(themeData.textTheme.bodyText1,
                              letterSpacing: 0.1, color: themeData.colorScheme.onBackground, fontWeight: 500),
                          decoration: InputDecoration(
                            hintStyle: AppTheme.getTextStyle(themeData.textTheme.bodyText1,
                                letterSpacing: 0.1, color: themeData.colorScheme.onBackground, fontWeight: 500),
                            hintText: "Dirección de correo electrónico",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(8.0),
                                ),
                                borderSide: BorderSide.none),
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(8.0),
                                ),
                                borderSide: BorderSide.none),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(8.0),
                                ),
                                borderSide: BorderSide.none),
                            filled: true,
                            fillColor: themeData.colorScheme.background,
                            prefixIcon: Icon(
                              MdiIcons.emailOutline,
                              size: MySize.size22,
                            ),
                            isDense: true,
                            contentPadding: EdgeInsets.all(0),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'El campo no puede estar en blanco';
                            }
                            // return null;
                          },
                          keyboardType: TextInputType.emailAddress,
                          textCapitalization: TextCapitalization.sentences,
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: MySize.size24!),
                        child: TextFormField(
                          style: AppTheme.getTextStyle(themeData.textTheme.bodyText1,
                              letterSpacing: 0.1, color: themeData.colorScheme.onBackground, fontWeight: 500),
                          decoration: InputDecoration(
                            hintText: "Nombre del negocio",
                            hintStyle: AppTheme.getTextStyle(themeData.textTheme.bodyText1,
                                letterSpacing: 0.1, color: themeData.colorScheme.onBackground, fontWeight: 500),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(8.0),
                                ),
                                borderSide: BorderSide.none),
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(8.0),
                                ),
                                borderSide: BorderSide.none),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(8.0),
                                ),
                                borderSide: BorderSide.none),
                            filled: true,
                            fillColor: themeData.colorScheme.background,
                            prefixIcon: Icon(
                              MdiIcons.officeBuildingOutline,
                              size: MySize.size22,
                            ),
                            isDense: true,
                            contentPadding: EdgeInsets.all(0),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'El campo no puede estar en blanco';
                            }
                            // return null;
                          },
                          textCapitalization: TextCapitalization.sentences,
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
                          onPressed: () {},
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
                                onPressed: () {},
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
          ),
        );
      },
    );
  }
}
