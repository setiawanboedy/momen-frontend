import 'dart:math';

// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
// ignore: unused_import
import 'package:equatable/equatable.dart';

class SettingsCubit extends Cubit<int> {
  SettingsCubit() : super(0);

  void reloadWidget() {
    /// Generate random int to trigger bloc builder
    emit(Random().nextInt(1000));
  }
}
