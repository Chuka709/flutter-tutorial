import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:movie/global_keys.dart';
import 'package:movie/providers/common.dart';
import 'package:movie/screens/home.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await Firebase.initializeApp();
  print(await FirebaseMessaging.instance.getToken());
  runApp(
    EasyLocalization(
      supportedLocales: [Locale('en', 'EN'), Locale('mn', 'MN')],
      path: 'assets/translations',
      fallbackLocale: Locale('mn', 'MN'),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => CommonProvider()),
      ],
      child: MaterialApp(
        title: 'Movie App',
        navigatorKey: GlobalKeys.navigatorKey,
        builder: (context, child) => MediaQuery(data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0), child: child!),
        localizationsDelegates: context.localizationDelegates,
        supportedLocales: context.supportedLocales,
        locale: context.locale,
        home: HomePage(),
      ),
    );
  }
}
