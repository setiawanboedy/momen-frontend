import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../widgets/spacer_v.dart';
import '../../../../../widgets/text_f.dart';

import '../../../../../resources/dimens.dart';
import '../../../../../resources/palette.dart';
import '../../../../../routes/app_route.dart';
import '../../../../../utils/ext/context.dart';
import '../../../../../utils/ext/string.dart';
import '../../../domain/usecase/post_login.dart';
import '../../cubit/login_cubit.dart';

class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final _keyForm = GlobalKey<FormState>();
  final _controlEmail = TextEditingController();
  final _controlPass = TextEditingController();

  /// Focus Node
  final _fnEmail = FocusNode();
  final _fnPassword = FocusNode();

  bool _isPasswordHide = true;

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginCubit, LoginState>(
      listener: (_, state) {
        switch (state.status) {
          case LoginStatus.loading:
            context.show();
            break;
          case LoginStatus.success:
            context.dismiss();
            state.login?.message.toString().toToastSuccess();
            TextInput.finishAutofillContext();
            context.goToReplace(AppRoute.mainScreen);
            break;
          case LoginStatus.failure:
            context.dismiss();
            state.message.toString().toToastError();
            break;
        }
      },
      child: Container(
        padding: EdgeInsets.all(Dimens.space16),
        child: Form(
          key: _keyForm,
          child: Column(
            children: [
              TextF(
                autofillHints: const [AutofillHints.email],
                key: const Key("email"),
                curFocusNode: _fnEmail,
                nextFocusNode: _fnPassword,
                textInputAction: TextInputAction.next,
                controller: _controlEmail,
                keyboardType: TextInputType.emailAddress,
                prefixIcon: Icon(
                  Icons.alternate_email,
                  color: Theme.of(context).textTheme.bodyText1?.color,
                ),
                hintText: "eve.holt@gmail.com",
                hint: "Email",
                validator: (String? value) => value != null
                    ? (!value.isValidEmail() ? "Email salah" : null)
                    : null,
              ),
              const SpacerV(),
              TextF(
                        autofillHints: const [AutofillHints.password],
                        key: const Key("password"),
                        curFocusNode: _fnPassword,
                        textInputAction: TextInputAction.done,
                        controller: _controlPass,
                        keyboardType: TextInputType.text,
                        prefixIcon: Icon(
                          Icons.lock_outline,
                          color: Theme.of(context).textTheme.bodyText1?.color,
                        ),
                        obscureText: _isPasswordHide,
                        hintText: '••••••••••••',
                        maxLine: 1,
                        hint: "Password",
                        suffixIcon: IconButton(
                          padding: EdgeInsets.zero,
                          constraints: const BoxConstraints(),
                          onPressed: () {
                            setState(
                              () {
                                _isPasswordHide = !_isPasswordHide;
                              },
                            );
                          },
                          icon: Icon(
                            _isPasswordHide
                                ? Icons.visibility_off
                                : Icons.visibility,
                          ),
                        ),
                        validator: (String? value) => value != null
                            ? (value.length < 3
                                ? "Tidak boleh kosong"
                                : null)
                            : null,
                      ),
                      SpacerV(value: Dimens.space24),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(
                  horizontal: 32,
                ),
                child: ElevatedButton(
                  onPressed: () {
                    if (_keyForm.currentState?.validate() ?? false) {
                      context.read<LoginCubit>().login(
                            LoginParams(
                              email: _controlEmail.text,
                              password: _controlPass.text,
                            ),
                          );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.all(Dimens.space16),
                    primary: Palette.orangeLight,
                    elevation: 0,
                    textStyle: const TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  child: const Text("SignIn"),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
