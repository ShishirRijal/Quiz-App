import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quiz_app/services/register_validation.dart';

import '../../services/services.dart';
import '../../widgets/widgets.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 40.0, horizontal: 20.0),
              child: Responsive(
                mobile: Column(children: const [
                  Logo(),
                  SizedBox(height: 20.0),
                  _RegisterText(),
                  SizedBox(height: 20.0),
                  _InputAndRegister(),
                ]),
                tablet: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Expanded(
                          child: Padding(
                        padding: EdgeInsets.all(40.0),
                        child: Logo(),
                      )),
                      Expanded(
                          child: Column(
                        children: const [
                          _RegisterText(),
                          SizedBox(height: 20.0),
                          _InputAndRegister()
                        ],
                      )),
                    ]),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// Refactoring ...

class _InputAndRegister extends StatelessWidget {
  const _InputAndRegister();

  @override
  Widget build(BuildContext context) {
    final registerAuth = Provider.of<RegisterValidation>(context);

    return Column(
      children: [
        // Input Fields

        // full name
        CustomTextField(
          icon: Icons.person,
          label: "Full Name",
          errorText: registerAuth.name.error,
          onChange: (value) {
            registerAuth.setName(value.trim());
          },
        ),
        const SizedBox(height: 20.0),

        // email
        CustomTextField(
          icon: Icons.email,
          label: "E-mail",
          errorText: registerAuth.email.error,
          onChange: (value) {
            registerAuth.setEmail(value.trim());
          },
        ),
        const SizedBox(height: 20.0),

        //password

        CustomTextField(
          icon: Icons.lock,
          label: "Password",
          isObscure: true,
          errorText: registerAuth.password.error,
          onChange: (value) {
            registerAuth.setPassword(value);
          },
        ),

        const SizedBox(height: 50.0),

        // login button

        ElevatedButton(
          onPressed: !registerAuth.isValid()
              ? null
              : () async {
                  final auth = Provider.of<AuthService>(context, listen: false);
                  // implement register logic
                  await auth
                      .signUpWithEmailAndPassword(registerAuth.email.value,
                          registerAuth.password.value, context)
                      .then((_) => Navigator.pushNamedAndRemoveUntil(
                          context, Routes.homeRoute, (route) => false));
                },
          child: const Text("Sign Up"),
        ),
        const SizedBox(height: 20.0),
        // alternative sign in methods

        Text("Or, register with...",
            style: getRegularTextStyle(color: ColorManager.grey)),
        const SizedBox(height: 20.0),

        //Sign in with google, facebook, apple

        const AlternativeAccount(),
        const SizedBox(height: 20.0),

        // Register Option

        HelperRichText(
          message: "Already have an account? ",
          actionText: "Login",
          onTap: () {
            // move to login screen
            Navigator.pushNamedAndRemoveUntil(
                context, Routes.loginRoute, (route) => false);
          },
        ),
      ],
    );
  }
}

class _RegisterText extends StatelessWidget {
  const _RegisterText({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(
        "Sign Up",
        style: Theme.of(context).textTheme.headline1,
      ),
    );
  }
}
