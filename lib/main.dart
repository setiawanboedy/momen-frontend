import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:oktoast/oktoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'di/di.dart';
import 'features/home/settings/cubit/settings_cubit.dart';
import 'routes/app_route.dart';

Future<void> main() async {
  await serviceLocator();
  WidgetsFlutterBinding.ensureInitialized();
  runZonedGuarded(
      () => SystemChrome.setPreferredOrientations(
            [
              DeviceOrientation.portraitUp,
              DeviceOrientation.portraitDown,
            ],
          ).then((_) async {
            SharedPreferences.getInstance().then((value) {
              initPrefManager(value);
              runApp(const MyApp());
            });
          }),
      ((error, stack) {}));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => SettingsCubit(),
      child: OKToast(
        child: ScreenUtilInit(
          designSize: const Size(375, 667),
          minTextAdapt: true,
          splitScreenMode: true,
          builder: (_, __) =>
              BlocBuilder<SettingsCubit, int>(
            builder: (_, __) => MaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'Momen Demo',
              theme: ThemeData(
                primarySwatch: Colors.blue,
              ),
              builder: (BuildContext context, Widget? child) {
                final MediaQueryData data = MediaQuery.of(context);
      
                return MediaQuery(
                    data: data.copyWith(
                        textScaleFactor: 1, alwaysUse24HourFormat: true),
                    child: child!);
              },
              onGenerateRoute: (RouteSettings settings) {
                final route = AppRoute.getRoutes(settings: settings);
                final WidgetBuilder? builder = route[settings.name];
      
                return MaterialPageRoute(
                  builder: (context) => builder!(context),
                  settings: settings,
                );
              },
              initialRoute: AppRoute.splashScreen,
            ),
          ),
        ),
      ),
    );
  }
}
