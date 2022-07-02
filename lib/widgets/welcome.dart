import 'package:flutter/material.dart';

Widget welcome({String? name = "User"}) {
  return Text(
    "Hello $name",
    style: const TextStyle(
        color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
  );
}
