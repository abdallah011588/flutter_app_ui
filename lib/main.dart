import 'package:barter_it/components/components.dart';
import 'package:barter_it/layout/cubit/cubit.dart';
import 'package:barter_it/layout/cubit/states.dart';
import 'package:barter_it/local_notifications.dart';
import 'package:barter_it/localization/localization_methods.dart';
import 'package:barter_it/localization/set_localization.dart';
import 'package:barter_it/screens/splash/splash_screen.dart';
import 'package:barter_it/shared/shared_pref.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() async{

  WidgetsFlutterBinding.ensureInitialized();
  // await LocalNotifications.init();
  Shared.init();
  await Firebase.initializeApp();
  AppDio.init();
  FirebaseMessaging messaging = FirebaseMessaging.instance;
  await messaging.requestPermission(
    alert: true,
    badge: true,
    sound: true,
    provisional: false,
  );

  var token = await messaging.getToken();
  Shared.setData(key: 'token', value: token);
  FirebaseMessaging.onMessage.listen((event) {
   LocalNotifications.showSimpleNotification(
        title: event.notification!.title!,
        body: event.notification!.body!,
        payload: "data");
  });

  SystemChrome.setPreferredOrientations([ DeviceOrientation.portraitUp,]).then((_) {
    runApp(const MyApp());
  });

}


class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  static void setLocale(BuildContext context, Locale locale) {
    _MyAppState? state = context.findAncestorStateOfType<_MyAppState>();
    state!.setLocale(locale);
  }

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {


  Locale? _local;
  void setLocale(Locale locale) {
    setState(() {
      _local = locale;
    });
  }

  @override
  void didChangeDependencies() {
    getLocale().then((locale) {
      setState(() {
        this._local = locale;
      });
    });
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    if (_local == null) {
      return Container(
        child: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }
    else{
    return BlocProvider(
      create: (context) => AppCubit()..getUserData()..getAllProducts(),
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return MaterialApp(
            title: 'BarterIt',
            locale: _local,
            supportedLocales: [
              Locale('en', 'US'),
              Locale('ar', 'EG')
            ],
            localizationsDelegates: [
              SetLocalization.localizationsDelegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            localeResolutionCallback: (deviceLocal, supportedLocales)
            {
              for (var local in supportedLocales)
              {
                if (local.languageCode == deviceLocal!.languageCode &&
                    local.countryCode == deviceLocal.countryCode)
                {
                  return deviceLocal;
                }
              }
              return supportedLocales.first;
            },
            theme: ThemeData(
              primarySwatch: Colors.orange,
              appBarTheme: AppBarTheme(
                systemOverlayStyle: SystemUiOverlayStyle(
                  statusBarIconBrightness: Brightness.dark,
                  statusBarColor: Colors.white,
                  statusBarBrightness: Brightness.light,
                ),
                backgroundColor: Colors.white,
                elevation: 0.0,
              ),
              fontFamily: "Cairo"
            ),
            home: const SplashScreen(),
            debugShowCheckedModeBanner: false,
          );
        },
      ),
    );
  }
  }
}



