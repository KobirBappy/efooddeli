import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:resturant_delivery_boy/helper/notification_helper.dart';
import 'package:resturant_delivery_boy/provider/chat_provider.dart';
import 'package:resturant_delivery_boy/utill/app_constants.dart';
import 'package:resturant_delivery_boy/localization/app_localization.dart';
import 'package:resturant_delivery_boy/provider/auth_provider.dart';
import 'package:resturant_delivery_boy/provider/localization_provider.dart';
import 'package:resturant_delivery_boy/provider/language_provider.dart';
import 'package:resturant_delivery_boy/provider/order_provider.dart';
import 'package:resturant_delivery_boy/provider/profile_provider.dart';
import 'package:resturant_delivery_boy/provider/splash_provider.dart';
import 'package:resturant_delivery_boy/provider/theme_provider.dart';
import 'package:resturant_delivery_boy/provider/tracker_provider.dart';
import 'package:resturant_delivery_boy/theme/dark_theme.dart';
import 'package:resturant_delivery_boy/theme/light_theme.dart';
import 'package:resturant_delivery_boy/view/screens/splash/splash_screen.dart';
import 'package:provider/provider.dart';
import 'di_container.dart' as di;
import 'provider/time_provider.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
AndroidNotificationChannel channel;
final GlobalKey<NavigatorState> _navigatorKey = GlobalKey<NavigatorState>();


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await di.init();
  await NotificationHelper.initialize(flutterLocalNotificationsPlugin);
  if(defaultTargetPlatform == TargetPlatform.android){
    channel = const AndroidNotificationChannel(
      'high_importance_channel',
      'High Importance Notifications',
      importance: Importance.high,
    );
  }
  await NotificationHelper.initialize(flutterLocalNotificationsPlugin);
  FirebaseMessaging.onBackgroundMessage(myBackgroundMessageHandler);

  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (context) => di.sl<ThemeProvider>()),
      ChangeNotifierProvider(create: (context) => di.sl<SplashProvider>()),
      ChangeNotifierProvider(create: (context) => di.sl<LanguageProvider>()),
      ChangeNotifierProvider(create: (context) => di.sl<LocalizationProvider>()),
      ChangeNotifierProvider(create: (context) => di.sl<AuthProvider>()),
      ChangeNotifierProvider(create: (context) => di.sl<LocalizationProvider>()),
      ChangeNotifierProvider(create: (context) => di.sl<ProfileProvider>()),
      ChangeNotifierProvider(create: (context) => di.sl<OrderProvider>()),
      ChangeNotifierProvider(create: (context) => di.sl<TrackerProvider>()),
      ChangeNotifierProvider(create: (context) => di.sl<ChatProvider>()),
      ChangeNotifierProvider(create: (context) => di.sl<TimerProvider>()),
    ],
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<Locale> _locals = [];
    AppConstants.languages.forEach((language) {
      _locals.add(Locale(language.languageCode, language.countryCode));
    });
    return MaterialApp(
      title: AppConstants.APP_NAME,
      navigatorKey: _navigatorKey,
      debugShowCheckedModeBanner: false,
      theme: Provider.of<ThemeProvider>(context).darkTheme ? dark : light,
      locale: Provider.of<LocalizationProvider>(context).locale,
      localizationsDelegates: [
        AppLocalization.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: _locals,
      home: SplashScreen(),
    );
  }
}

class Get {
  static BuildContext get context => _navigatorKey.currentContext;
  static NavigatorState get navigator => _navigatorKey.currentState;
}

