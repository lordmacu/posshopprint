import 'package:flutter/material.dart';
import 'package:posshop_app/data/dao/TokenDao.dart';
import 'package:posshop_app/screens/MenuScreen.dart';
import 'package:posshop_app/screens/StartupScreen.dart';
import 'package:posshop_app/service/GlobalService.dart';

class SplashScreen extends StatefulWidget {
  SplashScreen({Key? key}) : super(key: key);

  @override
  createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    _checkIfFirstOpen();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFFFFFFFF),
      child: DecoratedBox(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/logo_sistema_fondoblanco.jpg'),
          ),
        ),
      ),
    );
  }

  Future<void> _checkIfFirstOpen() async {
    TokenDao tokenDao = new TokenDao();
    tokenDao.getAll().then((value) {
      if (value.length == 0) {
        _changePageToStartup();
      } else {
        _processData();
      }
    });
  }

  _changePageToStartup() {
    Navigator.of(context).pushReplacement(
      PageRouteBuilder(
        pageBuilder: (context, animation1, animation2) => StartupScreen(),
      ),
    );
  }

  _changePageToMenu() {
    Navigator.of(context).pushReplacement(
      PageRouteBuilder(
        pageBuilder: (context, animation1, animation2) => MenuScreen(),
      ),
    );
  }

  _processData() async {
    GlobalService globalService = GlobalService();
    if (await globalService.loadAll()) {
      _changePageToMenu();
    } else {
      _changePageToStartup();
    }
  }
}
