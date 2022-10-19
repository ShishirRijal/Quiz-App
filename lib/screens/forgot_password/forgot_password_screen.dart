import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:quiz_app/services/services.dart';
import '../../widgets/widgets.dart';

class ForgotPasswordScreen extends StatelessWidget {
  const ForgotPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 40.0),
        child: Responsive(
          mobile: Column(
            children: [
              // lotties animation
              Expanded(child: LottieBuilder.asset(AssetManager.forgotPassword)),
              const SizedBox(height: 20.0),
              const Expanded(child: MessageAndInput()),
              const SizedBox(height: 20.0),

              // login
            ],
          ),
          tablet: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Expanded(child: LottieBuilder.asset(AssetManager.forgotPassword)),
              const Expanded(child: MessageAndInput())
            ],
          ),
        ),
      ),
    ));
  }
}

// Refactoring....

class MessageAndInput extends StatelessWidget {
  const MessageAndInput({super.key});

  @override
  Widget build(BuildContext context) {
    final loginAuth = Provider.of<LoginValidation>(context);

    return Column(
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            "Forgot \nPassword?",
            style: Theme.of(context).textTheme.headline1,
          ),
        ),
        const SizedBox(height: 10.0),

        Text(
            "Don't worry! It happens.\nPlease enter the email address associated with your account to help us find it for you.",
            style: Theme.of(context).textTheme.bodyText1),

        const SizedBox(height: 30.0),

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

        //su button
        ElevatedButton(
          onPressed: !loginAuth.isEmailValid() ? null : loginAuth.submit,
          child: const Text("Submit"),
        ),
      ],
    );
  }
}
