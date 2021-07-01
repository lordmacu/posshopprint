import 'package:flutter/material.dart';
import '../AppTheme.dart';

class SimpleDialogWidget extends StatelessWidget {
  final String title;
  final String message;

  SimpleDialogWidget(this.title, this.message);

  @override
  Widget build(BuildContext context) {
    ThemeData themeData = Theme.of(context);
    return Dialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(8.0))),
      child: Container(
        padding: EdgeInsets.all(16),
        decoration: new BoxDecoration(
          color: themeData.backgroundColor,
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 10.0,
              offset: const Offset(0.0, 10.0),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(title,
                style: AppTheme.getTextStyle(
                  themeData.textTheme.headline6,
                  fontWeight: 700,
                )),
            Text(message,
                style: AppTheme.getTextStyle(
                  themeData.textTheme.subtitle1,
                  fontWeight: 500,
                )),
            Container(
              alignment: AlignmentDirectional.centerEnd,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text(
                  "ACEPTAR",
                  style: AppTheme.getTextStyle(themeData.textTheme.bodyText2,
                      letterSpacing: 0.3,
                      fontWeight: 600,
                      color: themeData.colorScheme.onPrimary),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
