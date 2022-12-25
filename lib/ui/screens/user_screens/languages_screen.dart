import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:shop/business_logic/app_layout_cubit/app_layout_cubit.dart';
import 'package:shop/translations/locale_keys.g.dart';
import 'package:shop/ui/screens/layout/app_layout.dart';
import 'package:shop/ui/widgets/profile_widgets/list_tile_item_widget.dart';
import 'package:shop/utils/app_palette.dart';
import 'package:shop/utils/app_size_boxes.dart';
import 'package:shop/utils/dimensions.dart';
import '../../../helpers/cache_helper.dart';
import '../splash_screen.dart';

class LanguagesScreen extends StatelessWidget {
  LanguagesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        iconTheme: Theme.of(context).iconTheme,
        title: Text(
          LocaleKeys.languages.tr(),
        ),
        leading: InkWell(
          onTap: () {
            AppLayoutCubit.get(context).onItemTapped(3);
            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(
                  builder: (context) => AppLayout(),
                ),
                    (route) => false);
          },
          child: const Icon(Icons.arrow_back_ios,
              size: 20.0, color: AppPalette.black),
        ),
      ),
      body: Container(
        margin: EdgeInsets.all(Dimensions.paddingSizeSmall),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: Dimensions.paddingSizeDefault),
              child: Text(
                LocaleKeys.chooseYourLanguage.tr(),
                style: const TextStyle(fontWeight: FontWeight.w700),
              ),
            ),
            20.heightBox,
            ListTileItemWidget(
              title: LocaleKeys.arabic.tr(),
              trailing: context.locale.languageCode == "ar"
                  ? const Icon(
                Icons.check_circle,
                color: AppPalette.primary,
              )
                  : null,
              onTap: () {
                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(
                      builder: (context) => SplashScreen(),),
                        (route) => false);
                context.setLocale(const Locale("ar"));
                CacheHelper().setLanguage("ar");
              },
              border: context.locale.languageCode == "ar"
                  ? Border.all(color: AppPalette.primary)
                  : null,
            ),
            ListTileItemWidget(
              title: LocaleKeys.english.tr(),
              trailing: context.locale.languageCode == "en"
                  ? const Icon(
                Icons.check_circle,
                color: AppPalette.primary,
              )
                  : null,
              onTap: () {
                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(
                      builder: (context) => SplashScreen(),),
                        (route) => false);
                context.setLocale(const Locale("en"));
                CacheHelper().setLanguage("en");
              } ,
              border: context.locale.languageCode == "en"
                  ? Border.all(color: AppPalette.primary)
                  : null,
            )
          ],
        ),
      ),
    );
  }
}
