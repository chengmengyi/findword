import 'package:findword/utils/ad_utils.dart';
import 'package:findword/utils/check_user_utils.dart';
import 'package:findword/utils/routers/routers_name.dart';
import 'package:findword/utils/routers/routers_utils.dart';
import 'package:findword/utils/utils.dart';
import 'package:findword/utils/value_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  _initApp();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);

  SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        systemNavigationBarDividerColor: null,
        statusBarColor: Colors.transparent,
        systemNavigationBarIconBrightness: Brightness.dark,
        //顶部导航栏字体颜色
        statusBarIconBrightness: Brightness.light,
        statusBarBrightness: Brightness.light,
        //底部导航栏颜色
        systemNavigationBarColor: Colors.white,
      ));
  runApp(const MyApp());
}

_initApp()async{
  await GetStorage.init();
  MobileAds.instance.initialize();
  ValueUtils.instance.initValue();
  CheckUserUtils.instance.check();
  AdUtils.instance.initAd();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(430, 932),
      builder: (context, child) =>
          GetMaterialApp(
            title: 'FindWord',
            debugShowCheckedModeBanner: false,
            enableLog: true,
            initialRoute: RoutersName.launch,
            getPages: RoutersUtils.routersList,
            defaultTransition: Transition.rightToLeft,
            themeMode: ThemeMode.system,
            darkTheme: ThemeData.dark(),
            builder: (context, widget) {
              return Material(
                child: InkWell(
                  onTap: () {
                    hideKeyboard(context);
                  },
                  child: MediaQuery(
                    data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
                    child: widget!,
                  ),
                ),
              );
            },
          ),
    );
  }
}