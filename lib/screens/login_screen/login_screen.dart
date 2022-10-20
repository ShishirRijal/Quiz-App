import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../services/services.dart';
import '../../widgets/widgets.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // dismiss keyboard when touched outside the textfield
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
          backgroundColor: Colors.white,
          body: SafeArea(
              child: SingleChildScrollView(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 40.0, horizontal: 20.0),
              child: Responsive(
                mobile: Column(
                  children: const [
                    Logo(),
                    SizedBox(height: 20.0),
                    _LoginText(),
                    SizedBox(height: 20.0),
                    _InputAndLogin(),
                  ],
                ),
                tablet: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Expanded(
                      child: SizedBox(
                          child: Padding(
                        padding: EdgeInsets.all(40.0),
                        child: Logo(),
                      )),
                    ),
                    Expanded(
                        child: Column(
                      children: const [
                        _LoginText(),
                        SizedBox(height: 20.0),
                        _InputAndLogin(),
                      ],
                    )),
                  ],
                ),
              ),
            ),
          ))),
    );
  }
}

// Refactoring the code....

class _LoginText extends StatelessWidget {
  const _LoginText({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(
        "Login",
        style: Theme.of(context).textTheme.headline1,
      ),
    );
  }
}

class _InputAndLogin extends StatelessWidget {
  const _InputAndLogin({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final loginAuth = Provider.of<LoginValidation>(context);
    return Column(
      children: [
        // Input Fields

        // email
        CustomTextField(
          icon: Icons.email,
          label: "E-mail",
          errorText: loginAuth.email.error,
          onChange: (value) {
            loginAuth.setEmail(value.trim());
          },
        ),
        const SizedBox(height: 20.0),

        //password

        CustomTextField(
          icon: Icons.lock,
          label: "Password",
          isObscure: true,
          errorText: loginAuth.password.error,
          onChange: (value) {
            loginAuth.setPassword(value);
          },
        ),

        const SizedBox(height: 50.0),

        // login button

        ElevatedButton(
          onPressed: !loginAuth.isValid()
              ? null
              : () async {
                  //implement sign in
                  await Provider.of<AuthService>(context, listen: false)
                      .signInWithEmailAndPassword(loginAuth.email.value,
                          loginAuth.password.value, context);
                },
          child: const Text("Login"),
        ),
        Align(
          alignment: Alignment.topLeft,
          child: TextButton(
              onPressed: () {
                Navigator.pushNamed(context, Routes.forgotPasswordRoute);
              },
              child: Text(
                "Forgot password?",
                style: Theme.of(context)
                    .textTheme
                    .bodyText1!
                    .copyWith(color: ColorManager.primary),
              )),
        ),

        const SizedBox(height: 10.0),
        // alternative sign in methods

        Text("Or, login with...",
            style: getRegularTextStyle(color: ColorManager.grey)),

        const SizedBox(height: 20.0),

        //Sign in with google, facebook, apple

        const AlternativeAccount(),
        const SizedBox(height: 20.0),

        // Register Option

        HelperRichText(
          message: "Don't have an account yet? ",
          actionText: "Sign Up",
          onTap: () {
            // move to register screen
            Navigator.pushNamedAndRemoveUntil(
                context, Routes.registerRoute, (route) => false);
          },
        ),
      ],
    );
  }
}
