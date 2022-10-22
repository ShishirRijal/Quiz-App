import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quiz_app/services/db_services.dart';
import 'package:quiz_app/services/quiz.dart';
import 'package:quiz_app/services/resources/style_manger.dart';

import '../../services/auth_services.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthService>(context);
    auth.getUserData();
    final user = auth.user;
    final isMobile = MediaQuery.of(context).size.width < 480;
    final double scaleFactor = isMobile ? 1.0 : 1.5;
    return Scaffold(
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
                      height: isMobile ? 250 : 350,
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
                            user?.name?.toUpperCase() ?? "QUIZZLER",
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
                          await auth.signOut();
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
                        user?.name ?? "QUIZZLER",
                        textScaleFactor: scaleFactor,
                        style: getBoldTextStyle(
                          color: ColorManager.primary,
                        ),
                      ),
                      //tag
                      Text(
                        // "Bonus Booster, Level 24",
                        user?.email ?? 'errorLoading',
                        textScaleFactor: scaleFactor,
                        style: getRegularTextStyle(
                          color: ColorManager.grey,
                        ),
                      ),
                      const SizedBox(height: 20.0),

                      Container(
                        margin: const EdgeInsets.only(bottom: 20.0),
                        padding: const EdgeInsets.all(10.0),
                        width: double.infinity,
                        height: isMobile ? 120 : 180,
                        decoration: BoxDecoration(
                          color: ColorManager.primary.withOpacity(1),
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Expanded(
                                child:
                                    Stats("All Time Best", 173, scaleFactor)),
                            const VerticalDivider(),
                            Expanded(
                                child: Stats("Questions", 78, scaleFactor)),
                            const VerticalDivider(),
                            Expanded(
                                child: Stats("Total Score", 768, scaleFactor)),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Positioned(
              top: isMobile ? 150 : 200,
              child: Container(
                height: isMobile ? 200.0 : 350,
                width: isMobile ? 200.0 : 350,
                decoration: BoxDecoration(
                  color: ColorManager.primary,
                  borderRadius: BorderRadius.circular(20.0),
                ),
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(20.0),
                    child: Image.asset('assets/images/ccr.jpg',
                        fit: BoxFit.cover)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class VerticalDivider extends StatelessWidget {
  const VerticalDivider({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.symmetric(horizontal: 5.0),
        height: 65.0,
        color: Colors.white70,
        width: 1.0);
  }
}

class Stats extends StatelessWidget {
  const Stats(
    this.title,
    this.score,
    this.scaleFactor, {
    Key? key,
  }) : super(key: key);
  final String title;
  final int score;
  final double scaleFactor;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          Icons.blur_circular,
          color: ColorManager.white,
          size: 30.0 * scaleFactor,
        ),
        FittedBox(
          child: Text(
            title,
            textScaleFactor: scaleFactor,
            maxLines: 1,
            style: getRegularTextStyle(color: Colors.white70),
          ),
        ),
        const SizedBox(height: 5.0),
        FittedBox(
          child: Text(
            "$score",
            textScaleFactor: scaleFactor,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: getBoldTextStyle(color: ColorManager.white),
          ),
        ),
      ],
    );
  }
}
