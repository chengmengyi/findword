import 'package:findword/page/normal/launch/launch_p.dart';
import 'package:findword/utils/cloak_utils.dart';
import 'package:findword/utils/routers/routers_utils.dart';
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
  CloakUtils.instance.requestCloak();
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
            initialRoute: '/',
            getPages: RoutersUtils.routersList,
            defaultTransition: Transition.rightToLeft,
            themeMode: ThemeMode.system,
            darkTheme: ThemeData.dark(),
            home: LaunchP(),
          ),
    );
  }
}