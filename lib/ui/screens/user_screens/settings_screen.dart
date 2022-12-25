import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:shop/translations/locale_keys.g.dart';

class SettingsScreen extends StatelessWidget {
  SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        iconTheme: Theme.of(context).iconTheme,
        title: Text(
          LocaleKeys.settings.tr(),
        ),
      ),
      body: Container(),
    );
  }
}
