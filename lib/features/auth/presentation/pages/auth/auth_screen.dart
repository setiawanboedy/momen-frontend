import 'package:flutter/material.dart';

import '../../../../../resources/dimens.dart';
import '../../../../../resources/palette.dart';
import '../../../../../routes/app_route.dart';
import '../../../../../utils/ext/context.dart';
import '../../../../../widgets/parent.dart';
import 'sign_in.dart';
import 'sign_up.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({Key? key}) : super(key: key);

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  bool? signUpForm;

  @override
  void initState() {
    signUpForm = true;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Parent(
      child: Stack(
        children: [
          FractionallySizedBox(
            heightFactor: 0.5,
            child: Container(
              color: Palette.orangeLight,
            ),
          ),
          SingleChildScrollView(
            padding: EdgeInsets.all(Dimens.space16),
            child: Column(
              children: [
                const SizedBox(
                  height: 20,
                ),
                Container(
                  alignment: Alignment.topCenter,
                  height: (MediaQuery.of(context).size.height / 2) - 150,
                  child: Image.asset(
                    "assets/images/logo.png",
                    fit: BoxFit.contain,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: const [
                      BoxShadow(
                        color: Palette.orangeLight,
                        offset: Offset(5, 5),
                        blurRadius: 10,
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.grey.shade100,
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(10),
                            topRight: Radius.circular(10),
                          ),
                        ),
                        child: ToggleButtons(
                          renderBorder: false,
                          selectedColor: Palette.orangeLight,
                          fillColor: Colors.transparent,
                          isSelected: [signUpForm!, !signUpForm!],
                          onPressed: (index) => setState(() {
                            signUpForm = index == 0;
                          }),
                          children: [
                            Padding(
                              padding: EdgeInsets.all(Dimens.space16),
                              child: const Text(
                                "Sign Up",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.all(Dimens.space8),
                              child: const Text(
                                "Sign In",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      AnimatedSwitcher(
                        duration: const Duration(
                          milliseconds: 200,
                        ),
                        child: signUpForm! ? const SignUp() : const SignIn(),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                const Text("Atau login dengan"),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                  ),
                  child: OutlinedButton.icon(
                    onPressed: () {
                      context.goToReplace(AppRoute.mainScreen);
                    },
                    icon: Image.asset(
                      "assets/icons/google.png",
                      scale: 1.7,
                    ),
                    label: const Text(
                      "Google",
                      style: TextStyle(
                        color: Colors.black,
                      ),
                    ),
                    style: ButtonStyle(
                      padding: MaterialStateProperty.all(
                        const EdgeInsets.all(10),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
