import 'package:flutter/material.dart';

class HelperRichText extends StatelessWidget {
  const HelperRichText({
    Key? key,
    required this.message,
    required this.actionText,
    required this.onTap,
  }) : super(key: key);
  final VoidCallback onTap;
  final String message;
  final String actionText;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: RichText(
          text: TextSpan(
        children: [
          TextSpan(
            text: message,
            style: Theme.of(context).textTheme.bodyText2,
          ),
          TextSpan(
            text: actionText,
            style: Theme.of(context)
                .textTheme
                .caption
                ?.copyWith(fontWeight: FontWeight.bold),
          ),
        ],
      )),
    );
  }
}
