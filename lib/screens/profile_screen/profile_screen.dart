import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quiz_app/services/resources/routes_manager.dart';
import 'package:quiz_app/services/resources/style_manger.dart';

import '../../models/user_model.dart';
import '../../services/auth_services.dart';
import 'components/profile_photo.dart';
import 'components/stats_card.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isMobile = size.width < 480;
    final cardHeight = isMobile ? 120.0 : 180.0;
    final double pictureSize = isMobile ? 200.0 : 350;
    final double scaleFactor = isMobile ? 1.0 : 1.5;
    final auth = Provider.of<AuthService>(context);
    final UserModel? user = auth.user;

    return Scaffold(
      drawer: Container(),
      body: SingleChildScrollView(
        child: Stack(
          alignment: Alignment.center,
          clipBehavior: Clip.none,
          children: [
            Column(
              children: [
                Stack(
                  children: [
                    Container(
                      height: size.height * 0.4,
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      decoration: const BoxDecoration(
                        color: ColorManager.primary,
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(20.0),
                          bottomRight: Radius.circular(20.0),
                        ),
                      ),
                      child: Center(
                        child: FittedBox(
                          child: Text(
                            user?.name?.toUpperCase() ?? "QUIZZIER",
                            style: getBoldTextStyle(
                              color: Colors.white38,
                              size: 200.0,
                            ),
                          ),
                        ),
                      ),
                    ),
                    //exit button
                    Positioned(
                      top: 40.0,
                      right: 20.0,
                      child: IconButton(
                        tooltip: "Exit",
                        icon: const Icon(Icons.exit_to_app),
                        color: Colors.white,
                        iconSize: 30.0,
                        onPressed: () async {
                          await Provider.of<AuthService>(context, listen: false)
                              .signOut();
                          // .whenComplete(
                          //   // I want to disconnect all previoius connections and remove all screens in stack
                          //   () => Navigator.pushNamedAndRemoveUntil(context,
                          //       Routes.loginRoute, (route) => true),
                          // );
                        },
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(20, isMobile ? 120 : 250, 20, 0),
                  child: Column(
                    children: [
                      //name
                      Text(
                        user?.name ?? "QUIZZER",
                        textScaleFactor: scaleFactor,
                        style: getBoldTextStyle(
                          color: ColorManager.primary,
                        ),
                      ),
                      //tag
                      Text(
                        // "Bonus Booster, Level 24",
                        user?.email ?? 'quizzey@quizzey.com',
                        textScaleFactor: scaleFactor,
                        style: getRegularTextStyle(
                          color: ColorManager.grey,
                        ),
                      ),

                      const SizedBox(height: 20.0),
                      FittedBox(
                        child: Text("Performance:",
                            style:
                                getBoldTextStyle(color: ColorManager.primary)),
                      ),
                      const SizedBox(height: 20.0),

                      /// stats card...

                      StatsCard(
                          cardHeight: cardHeight, scaleFactor: scaleFactor),

                      ///
                    ],
                  ),
                ),
              ],
            ),
            Positioned(
              top: (size.height * 0.4) - (pictureSize / 2),
              child: Container(
                height: pictureSize,
                width: pictureSize,
                decoration: BoxDecoration(
                  color: ColorManager.primary,
                  borderRadius: BorderRadius.circular(20.0),
                ),
                child: ProfilePhoto(user?.imgUrl ?? ""),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
