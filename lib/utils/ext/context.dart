import 'package:flutter/material.dart';
import '../../widgets/loading.dart';

extension ContextExtensions on BuildContext {
  Future<dynamic> goToReplace(String routeName, {Object? args}) =>
      Navigator.pushReplacementNamed(this, routeName, arguments: args);

  dynamic back([dynamic result]) => Navigator.pop(this, result);

  Future<dynamic> goTo(String routeName, {Object? args}) =>
      Navigator.pushNamed(this, routeName, arguments: args);

  static late BuildContext ctx;

  void dismiss() {
    try {
      Navigator.pop(ctx);
    } catch (_) {}
  }

  Future<void> show() => showDialog(
        context: this,
        barrierDismissible: false,
        builder: (c) {
          ctx = c;

          return const Loading();
        },
      );

  void argsData() => ModalRoute.of(this)?.settings.arguments;
  void argsName() => ModalRoute.of(this)?.settings.name;
}
