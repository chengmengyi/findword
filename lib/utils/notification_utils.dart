import 'dart:io';

import 'package:findword/utils/data.dart';
import 'package:findword/utils/guide/guide_utils.dart';
import 'package:findword/utils/routers/routers_name.dart';
import 'package:findword/utils/routers/routers_utils.dart';
import 'package:findword/utils/sign_utils.dart';
import 'package:findword/utils/utils.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_max_ad/flutter_max_ad.dart';

class NotificationsId{
  static const int regular=100;
  static const int sign=200;
  static const int paypal=300;
  static const int upgrade=400;
}

class NotificationUtils{
  factory NotificationUtils()=>_getInstance();
  static NotificationUtils get instance => _getInstance();
  static NotificationUtils? _instance;
  static NotificationUtils _getInstance(){
    _instance??=NotificationUtils._internal();
    return _instance!;
  }

  NotificationUtils._internal();


  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  initNotification()async{
    const AndroidInitializationSettings initializationSettingsAndroid = AndroidInitializationSettings('@mipmap/ic_launcher');

    DarwinInitializationSettings initializationSettingsDarwin = const DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
    );

    InitializationSettings initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsDarwin,
    );
    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: (NotificationResponse notificationResponse) {
        switch (notificationResponse.notificationResponseType) {
          case NotificationResponseType.selectedNotification:
            _clickNotification(notificationResponse);
            break;
          case NotificationResponseType.selectedNotificationAction:
            _clickNotification(notificationResponse);
            break;
        }
      },
    );
  }

  requestPermission()async{
    if (Platform.isIOS || Platform.isMacOS) {
      await flutterLocalNotificationsPlugin
          .resolvePlatformSpecificImplementation<
          IOSFlutterLocalNotificationsPlugin>()
          ?.requestPermissions(
        alert: true,
        badge: true,
        sound: true,
      );
      await flutterLocalNotificationsPlugin
          .resolvePlatformSpecificImplementation<
          MacOSFlutterLocalNotificationsPlugin>()
          ?.requestPermissions(
        alert: true,
        badge: true,
        sound: true,
      );
    }
  }

  registerNotifications(){
    _showNotifications(
        NotificationsId.regular,
        RepeatInterval.daily,
        "Win money from FindWord",
        ["💰Discover Words, Earn Cash!","🎁Find Words, Reap Rewards!","🔥Word Search That Pays - Start Earning Today!"].random()
    );
    if(!SignUtils.instance.todaySign){
      Future.delayed(const Duration(milliseconds: 5000),(){
        _showNotifications(
            NotificationsId.sign,
            RepeatInterval.hourly,
            "Spell, sign in, and earn cash",
            "Word Seeker Check-in: Find Words, Earn Cash!"
        );
      });
    }
    Future.delayed(const Duration(milliseconds: 10000),(){
      _showNotifications(
          NotificationsId.paypal,
          RepeatInterval.hourly,
          "Withdrawal received",
          "\$100 cash waiting to be claimed！"
      );
    });
    Future.delayed(const Duration(milliseconds: 15000),(){
      _showNotifications(
          NotificationsId.upgrade,
          RepeatInterval.daily,
          "Upgrade For More Money",
          ["🔥Level Up Your Word Finding Skills and Unlock Rewards! ","Find Words, Level Up, and Earn Exciting Upgrades!"].random()
      );
    });
  }

  _showNotifications(int id,RepeatInterval repeatInterval,String title,String content){
    var androidNotificationDetails = const AndroidNotificationDetails('fw channel id', 'fw channel name',
        channelDescription: 'fw channel description',
        importance: Importance.max,
        priority: Priority.high,
        ticker: 'ticker'
    );
    var details = NotificationDetails(android: androidNotificationDetails);
    // flutterLocalNotificationsPlugin.periodicallyShow(id, title, content, kDebugMode?RepeatInterval.everyMinute:repeatInterval, details);
    flutterLocalNotificationsPlugin.periodicallyShow(id, title, content, repeatInterval, details);
  }

  _clickNotification(NotificationResponse response){
    if(FlutterMaxAd.instance.fullAdShowing()){
      return;
    }
    clickNotification=true;
    RoutersUtils.toPage(name: RoutersName.launch,map: {"NotificationId":response.id});
    Future.delayed(const Duration(milliseconds: 2000),(){
      clickNotification=false;
    });
  }

  Future<NotificationAppLaunchDetails?> getNotificationAppLaunchDetails()async{
    return await flutterLocalNotificationsPlugin.getNotificationAppLaunchDetails();
  }

  cancelNotification(int id){
    flutterLocalNotificationsPlugin.cancel(id);
  }
}