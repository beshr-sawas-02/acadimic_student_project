import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'app/data/providers/api_provider.dart';
import 'app/modules/language_controller.dart';
import 'app/modules/theme_controller.dart';
import 'app/routes/app_pages.dart';
import 'app/utils/theme.dart';
import 'app/data/providers/storage_provider.dart';
import 'lang/translations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  await initServices();
  runApp(MyApp());
}

Future<void> initServices() async {
  await Get.putAsync(() => StorageProvider().init());
  Get.put(ApiProvider());
  Get.put(LanguageController());
  Get.put(ThemeController());
}

class MyApp extends StatelessWidget {
  final LanguageController languageController = Get.find<LanguageController>();
  final ThemeController themeController = Get.find<ThemeController>();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final isArabic = languageController.locale.languageCode == 'ar';

      return Directionality(
        textDirection: isArabic ? TextDirection.rtl : TextDirection.ltr,
        child: GetMaterialApp(
          title: 'University Student App',
          debugShowCheckedModeBanner: false,
          translations: AppTranslations(),
          locale: languageController.locale,
          fallbackLocale: const Locale('en'),
          theme: AppTheme.lightTheme,
          darkTheme: AppTheme.darkTheme,
          themeMode: themeController.isDarkMode ? ThemeMode.dark : ThemeMode.light,
          initialRoute: AppPages.INITIAL,
          getPages: AppPages.routes,
        ),
      );
    });
  }
}
