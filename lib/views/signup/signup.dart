import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:golly_express_app/utils/constants.dart';
import 'package:golly_express_app/views/login/login.dart';
import 'package:golly_express_app/widgets/buttons.dart';
import 'package:golly_express_app/widgets/text_fields.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);
  @override
  State<SignupScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignupScreen> {
  late SignUpState _signUpState;
  final _enterUserInfoformKey = GlobalKey<FormState>();
  final _enterPasswordInfoformKey = GlobalKey<FormState>();
  late FocusNode fullNameFocusNode;
  late FocusNode phoneNumberFocusNode;
  late FocusNode emailFocusNode;
  late FocusNode passwordFocusNode;
  late FocusNode confirmPasswordFocusNode;

  var fullName = "";
  var phoneNumber = "";
  var email = "";
  var userpassword = "";
  var userconfirmPassword = "";

  @override
  void initState() {
    super.initState();
    _signUpState = SignUpState.enterUserInfo;
    fullNameFocusNode = FocusNode();
    phoneNumberFocusNode = FocusNode();
    emailFocusNode = FocusNode();
    passwordFocusNode = FocusNode();
    confirmPasswordFocusNode = FocusNode();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: Container(
          decoration: BoxDecoration(
              border: Border.all(color: GollyColors.greyShade200)),
          child: Padding(
            padding: const EdgeInsets.only(top: 14.0, bottom: 32.0),
            child: SecondaryButton(
              buttonText: StringResource.next,
              onPressed: () {
                _signUpState == SignUpState.enterUserInfo
                    ? _enterUserInfoformKey.currentState!.validate()
                        ? setState(() {
                            _signUpState = SignUpState.enterPasswordInfo;
                          })
                        : null
                    : _enterPasswordInfoformKey.currentState!.validate()
                        ? Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const LoginScreen()))
                        : null;
              },
            ),
          ),
        ),
        backgroundColor: Colors.white,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                LogoAndTitleWidget(
                  title: _signUpState == SignUpState.enterUserInfo
                      ? StringResource.registerToStart
                      : StringResource.enterPassword,
                  description: _signUpState == SignUpState.enterUserInfo
                      ? StringResource.enterYourInfoBelow
                      : StringResource.choosePasswordToSecureAccout,
                ),
                const SizedBox(height: 40),
                if (_signUpState == SignUpState.enterUserInfo)
                  EnterUserInfoWidget(
                    fullNameFocusNode: fullNameFocusNode,
                    phoneNumberFocusNode: phoneNumberFocusNode,
                    emailFocusNode: emailFocusNode,
                    onEmailChanged: (email) {
                      setState(() {
                        email = email;
                      });
                    },
                    onFullNameChanged: (fullName) {
                      setState(() {
                        fullName = fullName;
                      });
                    },
                    onPhoneNumberChanged: (phoneNumber) {
                      setState(() {
                        phoneNumber = phoneNumber;
                      });
                    },
                    formKey: _enterUserInfoformKey,
                  )
                else
                  EnterPasswordInfoWidget(
                      enterPasswordFocusNode: passwordFocusNode,
                      confirmPasswordFocusNode: confirmPasswordFocusNode,
                      formKey: _enterPasswordInfoformKey,
                      password: userpassword,
                      confirmPassword: userconfirmPassword,
                      onEnterPasswordChanged: (password) {
                        setState(() {
                          userpassword = password;
                        });
                      },
                      onConfirmPasswordChanged: (confirmPassword) {
                        setState(() {
                          userconfirmPassword = confirmPassword;
                        });
                      }),
                const SizedBox(height: 40),
              ],
            ),
          ),
        ));
  }
}

enum SignUpState { enterUserInfo, enterPasswordInfo }

class EnterUserInfoWidget extends StatelessWidget {
  final FocusNode fullNameFocusNode;
  final FocusNode phoneNumberFocusNode;
  final FocusNode emailFocusNode;
  final OnTextChanged onEmailChanged;
  final OnTextChanged onFullNameChanged;
  final OnTextChanged onPhoneNumberChanged;
  final GlobalKey<FormState> formKey;
  const EnterUserInfoWidget({
    Key? key,
    required this.fullNameFocusNode,
    required this.phoneNumberFocusNode,
    required this.emailFocusNode,
    required this.onEmailChanged,
    required this.onFullNameChanged,
    required this.onPhoneNumberChanged,
    required this.formKey,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Form(
        key: formKey,
        child: Column(
          children: [
            GollyTextField(
              onTextChanged: onEmailChanged,
              obscureText: false,
              focusNode: emailFocusNode,
              keyboardType: TextInputType.emailAddress,
              textInputAction: TextInputAction.next,
              hintText: StringResource.enterEmail,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return StringResource.enterEmail;
                } else if (!value.contains('@')) {
                  return StringResource.enterValidEmail;
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            GollyTextField(
              onTextChanged: onFullNameChanged,
              obscureText: false,
              focusNode: fullNameFocusNode,
              keyboardType: TextInputType.name,
              textInputAction: TextInputAction.next,
              hintText: StringResource.fullName,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return StringResource.enterFullName;
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            GollyTextField(
              inputFormatter: [
                FilteringTextInputFormatter.digitsOnly,
                LengthLimitingTextInputFormatter(9),
                FilteringTextInputFormatter.deny(RegExp(r'^0'))
              ],
              onTextChanged: onPhoneNumberChanged,
              obscureText: false,
              keyboardType: const TextInputType.numberWithOptions(),
              textInputAction: TextInputAction.done,
              prefixIcon: const Align(
                widthFactor: 0.1,
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: EdgeInsets.only(left: 8.0, bottom: 2.0),
                  child: Text(
                    StringResource.countryCode,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                      fontFamily: 'Dm Sans',
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return StringResource.enterPhoneNumber;
                }
                return null;
              },
              hintText: StringResource.phoneNumber,
            )
          ],
        ));
  }
}

class EnterPasswordInfoWidget extends StatefulWidget {
  final FocusNode enterPasswordFocusNode;
  final FocusNode confirmPasswordFocusNode;
  final String password;
  final String confirmPassword;
  final OnTextChanged onEnterPasswordChanged;
  final OnTextChanged onConfirmPasswordChanged;
  final GlobalKey<FormState> formKey;
  const EnterPasswordInfoWidget({
    required this.enterPasswordFocusNode,
    required this.confirmPasswordFocusNode,
    required this.formKey,
    required this.onEnterPasswordChanged,
    required this.onConfirmPasswordChanged,
    required this.password,
    required this.confirmPassword,
    Key? key,
  }) : super(key: key);

  @override
  State<EnterPasswordInfoWidget> createState() =>
      _EnterPasswordInfoWidgetState();
}

class _EnterPasswordInfoWidgetState extends State<EnterPasswordInfoWidget> {
  var _obscureEnterPassword = true;
  var _obscureConfirmPassword = true;
  @override
  Widget build(BuildContext context) {
    return Form(
        key: widget.formKey,
        child: Column(
          children: [
            GollyTextField(
              onTextChanged: widget.onEnterPasswordChanged,
              obscureText: _obscureEnterPassword,
              hintText: StringResource.enterPassword,
              focusNode: widget.enterPasswordFocusNode,
              textInputAction: TextInputAction.next,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return StringResource.enterPassword;
                } else if (value.length < 8) {
                  return StringResource.passwordLengthError;
                }
                return null;
              },
              suffixIcon: IconButton(
                icon: Icon(
                  _obscureEnterPassword
                      ? Icons.visibility_off
                      : Icons.visibility,
                  color: GollyColors.greyShade500,
                ),
                onPressed: () {
                  setState(() {
                    _obscureEnterPassword = !_obscureEnterPassword;
                  });
                },
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            GollyTextField(
                onTextChanged: widget.onConfirmPasswordChanged,
                obscureText: _obscureConfirmPassword,
                hintText: StringResource.confirmPassword,
                focusNode: widget.confirmPasswordFocusNode,
                textInputAction: TextInputAction.done,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return StringResource.confirmPassword;
                  } else if (value != widget.password) {
                    print(
                        "password: ${widget.password} confirmPassword: $value");
                    return StringResource.passwordMatchError;
                  }
                  return null;
                },
                suffixIcon: IconButton(
                  icon: Icon(
                    _obscureConfirmPassword
                        ? Icons.visibility_off
                        : Icons.visibility,
                    color: GollyColors.greyShade500,
                  ),
                  onPressed: () {
                    setState(() {
                      _obscureConfirmPassword = !_obscureConfirmPassword;
                    });
                  },
                ))
          ],
        ));
  }
}
