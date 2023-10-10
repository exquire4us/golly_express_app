import 'package:flutter/material.dart';
import 'package:golly_express_app/services/google_sign_in_service.dart';
import 'package:golly_express_app/utils/constants.dart';
import 'package:golly_express_app/views/signup/signup.dart';
import 'package:golly_express_app/widgets/buttons.dart';
import 'package:golly_express_app/widgets/text_fields.dart';
import 'package:golly_express_app/widgets/texts.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late FocusNode emailFocusNode;
  late FocusNode passwordFocusNode;
  var _emailAddress = '';
  var _passWord = '';
  var _showPasswordInput = false;
  var _obscurePassword = true;
  var _showBottomBar = true;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    emailFocusNode = FocusNode();
    passwordFocusNode = FocusNode();

    emailFocusNode.addListener(() {
      if (emailFocusNode.hasFocus) {
        setState(() {
          _showBottomBar = false;
        });
      } else {
        setState(() {
          _showBottomBar = true;
        });
      }
    });
    passwordFocusNode.addListener(() {
      if (passwordFocusNode.hasFocus) {
        setState(() {
          _showBottomBar = false;
        });
      } else {
        setState(() {
          _showBottomBar = true;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: _showBottomBar
          ? Padding(
              padding: const EdgeInsets.all(32.0),
              child: TextButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const SignupScreen()));
                },
                child: const Text(
                  StringResource.signup,
                  style: TextStyle(
                      color: GollyColors.greenShade1100,
                      fontSize: 14.0,
                      fontWeight: FontWeight.w800,
                      fontFamily: GollyFonts.dmSans),
                ),
              ),
            )
          : null,
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const LogoAndTitleWidget(
                title: StringResource.letsDeliverForYou,
                description: StringResource.registerOrSignIn,
              ),
              const SizedBox(height: 32.0),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    GollyTextField(
                        focusNode: emailFocusNode,
                        editComplete: () {
                          if (_emailAddress.isEmpty) {
                            return;
                          }
                          setState(() {
                            _showPasswordInput = true;
                            emailFocusNode.unfocus();
                            passwordFocusNode.requestFocus();
                          });
                        },
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.emailAddress,
                        hintText: StringResource.enterEmail,
                        onTextChanged: (value) => setState(() {
                              _emailAddress = value;
                            }),
                        obscureText: false,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return StringResource.enterEmail;
                          }
                          return null;
                        }),
                    const SizedBox(height: 16.0),
                    if (_showPasswordInput)
                      Column(
                        children: [
                          GollyTextField(
                            focusNode: passwordFocusNode,
                            keyboardType: TextInputType.visiblePassword,
                            hintText: StringResource.enterPassword,
                            onTextChanged: (value) => setState(() {
                              _passWord = value;
                            }),
                            obscureText: _obscurePassword,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return StringResource.enterPassword;
                              }
                              return null;
                            },
                            suffixIcon: IconButton(
                              icon: Icon(
                                _obscurePassword
                                    ? Icons.visibility_off
                                    : Icons.visibility,
                                color: GollyColors.greyShade500,
                              ),
                              onPressed: () {
                                setState(() {
                                  _obscurePassword = !_obscurePassword;
                                });
                              },
                            ),
                          ),
                          const SizedBox(height: 16.0),
                          _ForgotPasswordWidget(
                            onButtonPressed: () {},
                          ),
                        ],
                      ),
                  ],
                ),
              ),
              const SizedBox(height: 24.0),
              SecondaryButton(
                  buttonText: StringResource.submit,
                  onPressed: _emailAddress.isNotEmpty || _passWord.isNotEmpty
                      ? () {
                          if (_emailAddress.isEmpty) {
                            return;
                          } else if (!_showPasswordInput) {
                            setState(() {
                              _showPasswordInput = true;
                              emailFocusNode.unfocus();
                              passwordFocusNode.requestFocus();
                            });
                          }
                        }
                      : null),
              const SizedBox(
                height: 24.0,
              ),
              const _OrWidget(),
              const SizedBox(
                height: 24.0,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  children: [
                    SocialMediaWidget(
                      image: GollyImageResource.googlePng,
                      textLabel: StringResource.continueWithGoogle,
                      onPressed: () async {
                        final user = GoogleSignInService().signInWithGoogle();
                        if (user != null) {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const SignupScreen()));
                        }
                      },
                    ),
                    const SizedBox(
                      height: 16.0,
                    ),
                    SocialMediaWidget(
                      image: GollyImageResource.applePng,
                      textLabel: StringResource.signInWithApple,
                      onPressed: () {},
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 24.0,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ForgotPasswordWidget extends StatelessWidget {
  final Function() onButtonPressed;
  const _ForgotPasswordWidget({Key? key, required this.onButtonPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: TextButton(
        onPressed: () {},
        child: const Text(
          StringResource.forgotPassword,
          style: TextStyle(
              color: GollyColors.yellowShade200,
              fontSize: 14.0,
              fontWeight: FontWeight.w400,
              fontFamily: GollyFonts.dmSans),
        ),
      ),
    );
  }
}

class _OrWidget extends StatelessWidget {
  const _OrWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        children: [
          Expanded(
              child: Divider(
            thickness: 1.0,
            color: GollyColors.greyShade200,
          )),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 6.0),
            child: Text(
              StringResource.or,
              style: TextStyle(
                  color: GollyColors.blackShade100,
                  fontSize: 14.0,
                  fontWeight: FontWeight.w400,
                  fontFamily: GollyFonts.dmSans),
            ),
          ),
          Expanded(
              child: Divider(
            thickness: 1.0,
            color: GollyColors.greyShade200,
          ))
        ],
      ),
    );
  }
}

class SocialMediaWidget extends StatelessWidget {
  final String image;
  final String textLabel;
  final Function() onPressed;

  const SocialMediaWidget({
    Key? key,
    required this.image,
    required this.textLabel,
    required this.onPressed,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        decoration: BoxDecoration(
            borderRadius: const BorderRadius.horizontal(
                left: Radius.circular(10.0), right: Radius.circular(10.0)),
            border: Border.all(color: GollyColors.greyShade200, width: 1.0)),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                image,
                width: 20,
                height: 20,
              ),
              const SizedBox(
                width: 10.0,
              ),
              Align(
                alignment: Alignment.center,
                child: Text(
                  textLabel,
                  style: const TextStyle(
                      color: GollyColors.blackShade100,
                      fontSize: 14.0,
                      fontWeight: FontWeight.w400,
                      fontFamily: GollyFonts.dmSans),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class LogoAndTitleWidget extends StatelessWidget {
  final String title;
  final String description;
  const LogoAndTitleWidget({
    Key? key,
    required this.title,
    required this.description,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 16.0),
          child: Center(
              child: Image.asset(
            GollyImageResource.logoPng,
            width: 100,
            height: 100,
          )),
        ),
        TextTitleLarge(text: title, textColor: GollyColors.blackShade100),
        TextDescription(
          text: description,
          textColor: GollyColors.blackShade100,
          fontSize: 14,
        ),
      ],
    );
  }
}
