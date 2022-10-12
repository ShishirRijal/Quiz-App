import 'package:flutter/material.dart';

import '../services/asset_manager.dart';
import 'image_button.dart';

class AlternativeAccount extends StatelessWidget {
  const AlternativeAccount({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Wrap(
      alignment: WrapAlignment.center,
      clipBehavior: Clip.antiAlias,
      crossAxisAlignment: WrapCrossAlignment.center,
      spacing: 20.0,
      // mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        // sign in with google
        ImageButton(imagePath: AssetManager.googleIcon, onPressed: () {}),
        // sign in with facebook

        ImageButton(imagePath: AssetManager.facebookLogo, onPressed: () {}),
        // sign in with apple

        ImageButton(imagePath: AssetManager.appleLogo, onPressed: () {}),
      ],
    );
  }
}
