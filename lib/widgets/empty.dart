import 'package:flutter/material.dart';

class Empty extends StatelessWidget {
  final String? errorMessage;

  const Empty({Key? key, this.errorMessage}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
      
        Text(
          errorMessage ?? "Error",
        ),
      ],
    );
  }
}