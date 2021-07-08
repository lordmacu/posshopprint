import 'package:flutter/material.dart';
import 'package:posshop_app/data/dao/PosDao.dart';
import 'package:posshop_app/data/dao/TokenDao.dart';
import 'package:posshop_app/model/db/PosDB.dart';
import 'package:posshop_app/model/db/TokenDB.dart';
import 'package:posshop_app/model/dto/PosRequest.dart';
import 'package:posshop_app/model/dto/StoreRequest.dart';
import 'package:posshop_app/screens/MenuScreen.dart';
import 'package:provider/provider.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import '../AppThemeNotifier.dart';
import '../AppTheme.dart';
import '../utils/SizeConfig.dart';

class SelectPosScreen extends StatefulWidget {
  final TokenDB tokenDB;
  final StoreRequest store;

  SelectPosScreen({Key? key, required this.store, required this.tokenDB})
      : super(key: key);

  @override
  createState() => _SelectPosScreen();
}

class _SelectPosScreen extends State<SelectPosScreen> {
  final _formKey = GlobalKey<FormState>();
  late ThemeData themeData;
  bool _isButtonDisabled = false;
  PosRequest? pos;

  @override
  Widget build(BuildContext context) {
    themeData = Theme.of(context);
    return Consumer<AppThemeNotifier>(
      builder: (BuildContext context, AppThemeNotifier value, Widget? child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          // theme: AppTheme.getThemeFromThemeMode(value.themeMode()),
          home: Scaffold(
            appBar: AppBar(
              elevation: 0,
              backgroundColor: themeData.appBarTheme.color,
              title: Text("Seleccione el registro",
                  style: AppTheme.getTextStyle(themeData.textTheme.headline6,
                      fontWeight: 600)),
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
                padding: EdgeInsets.only(left: 24, right: 24),
                child: Center(
                  child: ListView(
                    shrinkWrap: true,
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.only(top: MySize.size24!),
                        child: widget.store.listPos == null
                            ? Text('No hay cajas para seleccionar')
                            : DropdownButton<PosRequest>(
                                isExpanded: true,
                                hint: Text('Registro sin seleccionar'),
                                //La caja no está seleccionada'),
                                items: widget.store.listPos!
                                    .map<DropdownMenuItem<PosRequest>>((item) {
                                  return DropdownMenuItem<PosRequest>(
                                    value: item,
                                    child: Text(item.name),
                                  );
                                }).toList(),
                                onChanged: (value) {
                                  setState(() => pos = value);
                                },
                                value: pos,
                                style: AppTheme.getTextStyle(
                                    themeData.textTheme.bodyText1,
                                    letterSpacing: 0.1,
                                    color: themeData.colorScheme.onBackground,
                                    fontWeight: 500),
                              ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          borderRadius:
                              BorderRadius.all(Radius.circular(MySize.size28!)),
                          boxShadow: [
                            BoxShadow(
                              color: themeData.primaryColor.withAlpha(24),
                              blurRadius: 5,
                              offset:
                                  Offset(0, 3), // changes position of shadow
                            ),
                          ],
                        ),
                        margin: EdgeInsets.only(top: MySize.size24!),
                        child: ElevatedButton(
                          style: ButtonStyle(
                              padding:
                                  MaterialStateProperty.all(Spacing.xy(16, 0))),
                          onPressed: _isButtonDisabled ||
                                  widget.store.listPos == null ||
                                  pos == null
                              ? null
                              : () {
                                  if (_formKey.currentState!.validate()) {
                                    setState(() => _isButtonDisabled = true);

                                    TokenDao tokenDao = new TokenDao();
                                    tokenDao
                                        .insert(widget.tokenDB)
                                        .then((value) {
                                      debugPrint('Obteniendo listado');
                                      tokenDao.getAll().then((value) {
                                        value
                                            .map((e) => debugPrint(e.password));
                                      });
                                      debugPrint('Fin listado');

                                      PosDB posDb = new PosDB(
                                        storeId: widget.store.id,
                                        storeName: widget.store.name,
                                        posId: pos!.id,
                                        posName: pos!.name,
                                      );

                                      PosDao posDao = PosDao();
                                      posDao.insert(posDb).then((value) {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    MenuScreen()));

                                        setState(
                                            () => _isButtonDisabled = false);
                                      });
                                    });
                                  }
                                },
                          child: Text(
                            "CONTINUAR",
                            style: AppTheme.getTextStyle(
                                    themeData.textTheme.bodyText2,
                                    fontWeight: 600)
                                .merge(TextStyle(
                                    color: themeData.colorScheme.onPrimary)),
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
