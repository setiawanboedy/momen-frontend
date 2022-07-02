import 'package:flutter/material.dart';

import '../resources/dimens.dart';

class Loading extends StatelessWidget {
  const Loading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  WillPopScope(
            onWillPop: () async => false,
            child: Material(
              color: Colors.transparent,
              child: Center(
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(Dimens.cornerRadius),
                  ),
                  margin: EdgeInsets.symmetric(horizontal: Dimens.space30),
                  padding: EdgeInsets.all(Dimens.space24),
                  child: Wrap(children: const [CircularProgressIndicator()]),
                ),
              ),
            ),
          );
  }
}