import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../resources/dimens.dart';
import '../../../../../resources/palette.dart';
import '../../../../../utils/ext/context.dart';
import '../../../../../utils/ext/string.dart';
import '../../../../../widgets/spacer_v.dart';
import '../../../../../widgets/text_f.dart';
import '../../../domain/usecase/post_register.dart';
import '../../cubit/register_cubit.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final _controlName = TextEditingController();
  final _controlEmail = TextEditingController();
  final _controlPass = TextEditingController();
  final _controlRepeatPass = TextEditingController();

  /// Focus Node
  final _fnEmail = FocusNode();
  final _fnPassword = FocusNode();
  final _fnPasswordRepeat = FocusNode();
  final _fnName = FocusNode();

  /// Handle state visibility password
  bool _isPasswordHide = true;
  bool _isPasswordRepeatHide = true;

  //keyform
  final _keyForm = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocListener<RegisterCubit, RegisterState>(
      listener: (_, state) {
        switch (state.status) {
          case RegisterStatus.loading:
            context.show();
            break;
          case RegisterStatus.success:
            context.dismiss();
            state.message.toString().toToastSuccess();
            break;
          case RegisterStatus.failure:
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
                key: const Key("name"),
                curFocusNode: _fnName,
                nextFocusNode: _fnEmail,
                textInputAction: TextInputAction.next,
                controller: _controlName,
                keyboardType: TextInputType.text,
                prefixIcon: Icon(
                  Icons.person,
                  color: Theme.of(context).textTheme.bodyText1?.color,
                ),
                hintText: 'sinaga',
                hint: "Name",
                validator: (String? value) => value != null
                    ? (value.length < 3 ? "Tidak boleh kosong" : null)
                    : null,
              ),
              const SpacerV(),
              TextF(
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
                hintText: 'johndoe@gmail.com',
                hint: "Email",
                validator: (String? value) => value != null
                    ? (!value.isValidEmail() ? "Email salah" : null)
                    : null,
              ),
              const SpacerV(),
              TextF(
                key: const Key("password"),
                curFocusNode: _fnPassword,
                nextFocusNode: _fnPasswordRepeat,
                textInputAction: TextInputAction.next,
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
                    _isPasswordHide ? Icons.visibility_off : Icons.visibility,
                  ),
                ),
                validator: (String? value) => value != null
                    ? (value.length < 3 ? "Tidak boleh kosong" : null)
                    : null,
              ),
              const SpacerV(),
              TextF(
                key: const Key("repeat_password"),
                curFocusNode: _fnPasswordRepeat,
                textInputAction: TextInputAction.done,
                controller: _controlRepeatPass,
                keyboardType: TextInputType.text,
                prefixIcon: Icon(
                  Icons.lock_outline,
                  color: Theme.of(context).textTheme.bodyText1?.color,
                ),
                obscureText: _isPasswordRepeatHide,
                hintText: '••••••••••••',
                maxLine: 1,
                hint: "Repeat Password",
                suffixIcon: IconButton(
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                  onPressed: () {
                    setState(
                      () {
                        _isPasswordRepeatHide = !_isPasswordRepeatHide;
                      },
                    );
                  },
                  icon: Icon(
                    _isPasswordRepeatHide
                        ? Icons.visibility_off
                        : Icons.visibility,
                  ),
                ),
                validator: (String? value) => value != null
                    ? (value != _controlPass.text
                        ? "Password tidak cocok"
                        : null)
                    : null,
              ),
              const SpacerV(),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(
                  horizontal: 32,
                ),
                child: ElevatedButton(
                  onPressed: () {
                    if (_keyForm.currentState?.validate() ?? false) {
                      context.read<RegisterCubit>().register(
                            RegisterParams(
                              name: _controlName.text,
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
                  child: const Text("SignUp"),
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
