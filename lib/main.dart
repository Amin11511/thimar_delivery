import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:easy_localization/easy_localization.dart' as lang;
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'core/routing/app_routes.dart';
import 'core/routing/app_routes_fun.dart';
import 'core/services/bloc_observer.dart';
import 'core/services/local_notification_services.dart';
import 'core/services/service_locator.dart';
import 'core/theming/app_theme.dart';
import 'core/utils/phoenix.dart';
import 'core/utils/unfocus.dart';
import 'features/auth/login/models/user_model.dart';
import 'firebase_option.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  HttpOverrides.global = MyHttpOverrides();
  await lang.EasyLocalization.ensureInitialized();
  await ScreenUtil.ensureScreenSize();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  ).then((FirebaseApp v) => GlobalNotification().setUpFirebase());
  Bloc.observer = AppBlocObserver();
  Prefs = await SharedPreferences.getInstance();
  UserModel.i.get();
  ServicesLocator().init();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return lang.EasyLocalization(
      path: 'assets/translations',
      saveLocale: true,
      startLocale: Prefs.getString('lang') == 'en'
          ? const Locale('en', 'US')
          : const Locale('ar', 'SA'),
      fallbackLocale: const Locale('ar', 'SA'),
      supportedLocales: const [Locale('ar', 'SA'), Locale('en', 'US')],
      child: ScreenUtilInit(
        designSize: const Size(375, 812),
        minTextAdapt: true,
        builder: (context, child) => MaterialApp(
          themeMode: ThemeMode.system,
          initialRoute: AppRoutes.init.initial,
          routes: AppRoutes.init.appRoutes,
          navigatorKey: navigator,
          debugShowCheckedModeBanner: false,
          localizationsDelegates: context.localizationDelegates,
          supportedLocales: context.supportedLocales,
          locale: context.locale,
          theme: AppThemes.lightTheme,

          builder: (context, child) {
            ErrorWidget.builder = (FlutterErrorDetails errorDetails) {
              return Scaffold(
                appBar: AppBar(elevation: 0, backgroundColor: Colors.white),
              );
            };
            return Phoenix(
              child: MediaQuery(
                data: MediaQuery.of(
                  context,
                ).copyWith(textScaler: TextScaler.linear(1.sp)),
                child: Unfocus(child: child ?? const SizedBox.shrink()),
              ),
            );
          },
        ),
      ),
    );
  }
}

late SharedPreferences Prefs;

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback = (cert, host, port) => true;
  }
}