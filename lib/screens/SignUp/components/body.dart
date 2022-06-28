import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:mazzad/components/already_have_an_account_check.dart';
import 'package:mazzad/components/default_button.dart';
import 'package:mazzad/components/default_text_field.dart';
import 'package:mazzad/constants.dart';
import 'package:mazzad/controller/text_field_controller.dart';
import 'package:mazzad/screens/SignUp/components/background.dart';
import 'package:mazzad/screens/home/home_screen.dart';
import 'package:mazzad/screens/login/login_screen.dart';
import 'package:mazzad/services/auth_service.dart';
import 'package:mazzad/utils/validator.dart';

import '../../../utils/size_config.dart';

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return BodyState();
  }
}

class BodyState extends State<Body> {
  final _passwordFieldKey = GlobalKey<FormFieldState<String>>();
  bool passVisible1 = true;
  bool passVisible2 = true;
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Background(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(
          15,
        ),
        child: Form(
          key: _formKey,
          child: GetBuilder<TextFieldController>(
              init: TextFieldController(),
              builder: (controller) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'SignUp',
                      style: Theme.of(context).appBarTheme.titleTextStyle,
                    ),
                    SvgPicture.asset('assets/icons/singup.svg',
                        height: size.height * 0.35),
                    const SizedBox(height: 8.0),
                    Column(
                      children: [
                        const DefaultTextField(
                          title: 'Name',
                          validate: Validator.validateName,
                        ),
                        const SizedBox(height: 5.0),
                        const DefaultTextField(
                          title: 'Your Email',
                          validate: Validator.validateEmail,
                        ),
                        const SizedBox(height: 5.0),
                        const DefaultTextField(
                          title: 'Phone',
                          validate: Validator.validatePhone,
                        ),
                        const SizedBox(height: 5.0),
                        DefaultTextField(
                          title: 'Password',
                          isSecure: true,
                          validate: Validator.validatePassword,
                          passwordFieldKey: _passwordFieldKey,
                        ),
                        const SizedBox(height: 5.0),
                        DefaultTextField(
                          title: 'Confirm Password',
                          isSecure: true,
                          validate: Validator.validatePassword,
                          passwordFieldKey: _passwordFieldKey,
                        ),
                        const SizedBox(height: 5.0),
                      ],
                    ),
                    SizedBox(
                      height: getProportionateScreenHeight(20),
                    ),
                    DefaultButton(
                      text: 'Create',
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          bool check = await AuthService.signUp(
                              name: controller.name,
                              email: controller.email,
                              password: controller.password,
                              phoneNumber: controller.phoneNumber);
                          if (check) {
                            // reset the controller fields if the user logged in successfully
                            controller.resetFields();
                            Get.offAndToNamed(HomeScreen.routeName);
                          }
                        }
                      },
                    ),
                    Constants.kBigVertcialSpacing,
                    AlreadyHaveAnAccountCheck(
                      login: false,
                      press: () {
                        // rest the auth fields if the usr navigates other screen
                        controller.resetFields();
                        Get.offAllNamed(LoginScreen.routeName);
                      },
                    ),
                    SizedBox(
                      height: getProportionateScreenHeight(20),
                    ),
                  ],
                );
              }),
        ),
      ),
    );
  }
}
