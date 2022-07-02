import 'package:flutter/material.dart';

import '../../../di/di.dart';
import '../../../routes/app_route.dart';
import '../../../utils/ext/context.dart';
import '../../../widgets/parent.dart';
import '../../auth/data/datasources/local/auth_pref_manager.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Future.delayed(const Duration(seconds: 2), () {
      _initData();
    });
    super.initState();
  }

  void _initData() {
    if (sl<AuthPrefManager>().isLogin) {
      context.goToReplace(AppRoute.mainScreen);
    } else {
      context.goToReplace(AppRoute.authScreen);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Parent(
      child: Container(
        color: Colors.white,
      ),
    );
  }
}
