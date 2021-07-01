import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import '../AppThemeNotifier.dart';
import '../AppTheme.dart';
import '../utils/SizeConfig.dart';
import 'RegisterScreen.dart';
import '../api/client/ApiClientLogin.dart' as apiLogin;
import '../widget/SimpleDialogWidget.dart';

class LoginScreen extends StatefulWidget {
  @override
  createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  late ThemeData themeData;
  bool _isPasswordVisible = false;
  bool _isButtonDisabled = false;
  String email = '';
  String password = '';

  void _showDialog(String title, String message) {
    showDialog(
        context: context,
        builder: (BuildContext context) => SimpleDialogWidget(title, message));
  }

  @override
  Widget build(BuildContext context) {
    themeData = Theme.of(context);
    return Consumer<AppThemeNotifier>(
      builder: (BuildContext context, AppThemeNotifier value, Widget? child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: AppTheme.getThemeFromThemeMode(value.themeMode()),
          home: Scaffold(
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
                        child: Center(
                          child: Text(
                            "Iniciar Sesión",
                            style: AppTheme.getTextStyle(
                                themeData.textTheme.headline6,
                                fontWeight: 600),
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: MySize.size24!),
                        child: TextFormField(
                          style: AppTheme.getTextStyle(
                              themeData.textTheme.bodyText1,
                              letterSpacing: 0.1,
                              color: themeData.colorScheme.onBackground,
                              fontWeight: 500),
                          decoration: InputDecoration(
                            hintText: "Dirección de correo electrónico",
                            hintStyle: AppTheme.getTextStyle(
                                themeData.textTheme.subtitle2,
                                letterSpacing: 0.1,
                                color: themeData.colorScheme.onBackground,
                                fontWeight: 500),
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
                          onChanged: (value) {
                            setState(() => email = value);
                          },
                          keyboardType: TextInputType.emailAddress,
                          textCapitalization: TextCapitalization.sentences,
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: MySize.size16!),
                        child: TextFormField(
                          autofocus: false,
                          obscureText: _isPasswordVisible,
                          style: AppTheme.getTextStyle(
                              themeData.textTheme.bodyText1,
                              letterSpacing: 0.1,
                              color: themeData.colorScheme.onBackground,
                              fontWeight: 500),
                          decoration: InputDecoration(
                            hintStyle: AppTheme.getTextStyle(
                                themeData.textTheme.subtitle2,
                                letterSpacing: 0.1,
                                color: themeData.colorScheme.onBackground,
                                fontWeight: 500),
                            hintText: "Contraseña",
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
                              MdiIcons.lockOutline,
                              size: MySize.size22,
                            ),
                            suffixIcon: InkWell(
                              onTap: () {
                                setState(() {
                                  _isPasswordVisible = !_isPasswordVisible;
                                });
                              },
                              child: Icon(
                                _isPasswordVisible
                                    ? MdiIcons.eyeOutline
                                    : MdiIcons.eyeOffOutline,
                                size: MySize.size22,
                              ),
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
                          onChanged: (value) {
                            setState(() => password = value);
                          },
                          textCapitalization: TextCapitalization.sentences,
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: MySize.size16!),
                        alignment: Alignment.centerRight,
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => RegisterScreen()));
                          },
                          child: Text(
                            "¿Ha olvidado la contraseña?",
                            style: AppTheme.getTextStyle(
                                themeData.textTheme.bodyText2,
                                fontWeight: 500),
                          ),
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
                          onPressed: _isButtonDisabled
                              ? null
                              : () {
                                  if (_formKey.currentState!.validate()) {
                                    setState(() => _isButtonDisabled = true);
                                    apiLogin
                                        .post(email, password)
                                        .then((response) {
                                      debugPrint(response.token);
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  RegisterScreen()));
                                    }).catchError((error) {
                                      debugPrint(error.toString());
                                      _showDialog("Error", error.toString());
                                      setState(() => _isButtonDisabled = false);
                                    });
                                  }
                                },
                          child: Text(
                            "INICIAR SESIÓN",
                            style: AppTheme.getTextStyle(
                                    themeData.textTheme.bodyText2,
                                    fontWeight: 600)
                                .merge(TextStyle(
                                    color: themeData.colorScheme.onPrimary)),
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: MySize.size16!),
                        child: Center(
                          child: GestureDetector(
                            onTap: () {
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => RegisterScreen()));
                            },
                            child: Text(
                              "No tengo una cuenta",
                              style: AppTheme.getTextStyle(
                                  themeData.textTheme.bodyText2,
                                  decoration: TextDecoration.underline),
                            ),
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
