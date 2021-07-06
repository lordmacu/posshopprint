import 'package:flutter/material.dart';
import 'package:posshop_app/data/dao/TokenDao.dart';
import 'package:provider/provider.dart';
import 'package:posshop_app/AppTheme.dart';
import 'package:posshop_app/AppThemeNotifier.dart';
import 'package:posshop_app/utils/SizeConfig.dart';
import 'package:posshop_app/screens/LoginScreen.dart';
import 'package:posshop_app/screens/RegisterScreen.dart';

class PrincipalScreen extends StatefulWidget {
  PrincipalScreen({Key? key}) : super(key: key);

  @override
  createState() => _PrincipalScreenState();
}

class _PrincipalScreenState extends State<PrincipalScreen> {
  late ThemeData themeData;
  late CustomAppTheme customAppTheme;

  @override
  void initState() {
    debugPrint('Iniciando');
    TokenDao tokenDao = new TokenDao();
    tokenDao.getAll().then((value) {
      debugPrint('Ok, termino el getAll, total ${value.length}');
      value.forEach((e) {
        debugPrint('Password: ${e.id}');
      });
    });
    debugPrint('Finalizando');
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
          debugShowCheckedModeBanner: false,
          theme: AppTheme.getThemeFromThemeMode(value.themeMode()),
          home: Container(
            child: Column(
              children: <Widget>[
                Expanded(
                  flex: 6,
                  child: Container(
                    color: themeData.primaryColor.withAlpha(24),
                  ),
                ),
                Expanded(
                  flex: 4,
                  child: Container(
                    padding: EdgeInsets.only(
                        left: MySize.size24!, right: MySize.size24!),
                    color: themeData.colorScheme.onPrimary,
                    constraints: BoxConstraints.expand(),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Container(
                            width: MediaQuery
                                .of(context)
                                .size
                                .width,
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
                            child: ElevatedButton(
                              style: ButtonStyle(
                                  padding:
                                  MaterialStateProperty.all(Spacing.xy(16, 0))),
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            RegisterScreen()));
                              },
                              child: Text(
                                "REGISTRO",
                                style: AppTheme.getTextStyle(
                                    themeData.textTheme.bodyText1,
                                    fontWeight: 600,
                                    color: themeData.colorScheme.onPrimary),
                              ),
                            ),
                          ),
                          Container(
                            width: MediaQuery
                                .of(context)
                                .size
                                .width,
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
                            child: ElevatedButton(
                              style: ButtonStyle(
                                  padding:
                                  MaterialStateProperty.all(Spacing.xy(16, 0))),
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => LoginScreen()));
                              },
                              child: Text(
                                "INICIAR SESIÓN",
                                style: AppTheme.getTextStyle(
                                    themeData.textTheme.bodyText1,
                                    fontWeight: 600,
                                    color: themeData.colorScheme.onPrimary),
                              ),
                            ),
                          ),
                        ]),
                  ),
                ),
              ],
            ),
          ),);
      },
    );
  }
}
