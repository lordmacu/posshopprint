import 'package:flutter/material.dart';
import 'package:posshop_app/model/entity/TokenEntity.dart';
import 'package:posshop_app/model/dto/OutletRequest.dart';
import 'package:provider/provider.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import '../AppThemeNotifier.dart';
import '../AppTheme.dart';
import '../utils/SizeConfig.dart';
import 'SelectPosScreen.dart';
import '../model/dto/StoreRequest.dart';
import 'package:posshop_app/api/client/ApiClientOutlet.dart' as apiOutlet;

class SelectStoreScreen extends StatefulWidget {
  final TokenEntity tokenDB;

  SelectStoreScreen({Key? key, required this.tokenDB}) : super(key: key);

  @override
  createState() => _SelectStoreScreen();
}

class _SelectStoreScreen extends State<SelectStoreScreen> {
  final _formKey = GlobalKey<FormState>();
  late ThemeData themeData;
  late Future<OutletRequest> futureOutlet;
  bool _isButtonDisabled = false;
  StoreRequest? store;

  @override
  void initState() {
    super.initState();
    futureOutlet = apiOutlet.get();
  }

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
              title: Text("Elija una tienda",
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
                        child: FutureBuilder<OutletRequest>(
                          future: futureOutlet,
                          builder:
                              (BuildContext context, AsyncSnapshot snapshot) {
                            if (snapshot.hasError)
                              return Text(snapshot.error.toString());

                            return snapshot.hasData
                                ? Container(
                                    child: DropdownButton<StoreRequest>(
                                      isExpanded: true,
                                      hint: Text(
                                          'La tienda no está seleccionada'),
                                      items: snapshot.data.stores
                                          .map<DropdownMenuItem<StoreRequest>>(
                                              (item) {
                                        return DropdownMenuItem<StoreRequest>(
                                          value: item,
                                          child: Text(item.name),
                                        );
                                      }).toList(),
                                      onChanged: (value) {
                                        setState(() => store = value);
                                      },
                                      value: store,
                                      style: AppTheme.getTextStyle(
                                          themeData.textTheme.bodyText1,
                                          letterSpacing: 0.1,
                                          color: themeData
                                              .colorScheme.onBackground,
                                          fontWeight: 500),
                                    ),
                                  )
                                : Container(
                                    child: Center(
                                      child: Text('Cargando...'),
                                    ),
                                  );
                          },
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
                          onPressed: _isButtonDisabled || store == null
                              ? null
                              : () {
                                  if (_formKey.currentState!.validate()) {
                                    setState(() => _isButtonDisabled = true);

                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                SelectPosScreen(
                                                  store: this.store!,
                                                  tokenDB: widget.tokenDB,
                                                )));

                                    setState(() => _isButtonDisabled = false);
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
