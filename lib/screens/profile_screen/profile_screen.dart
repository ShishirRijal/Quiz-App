import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quiz_app/services/resources/style_manger.dart';
import 'package:quiz_app/widgets/loading_screen.dart';

import '../../services/auth_services.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isMobile = size.width < 480;
    final cardHeight = isMobile ? 120.0 : 180.0;
    final double pictureSize = isMobile ? 200.0 : 350;
    final double scaleFactor = isMobile ? 1.0 : 1.5;

    return FutureBuilder(
      future: AuthService().getUserData(),
      builder: (context, snapshot) => snapshot.connectionState ==
              ConnectionState.waiting
          ? const LoadingScreen(
              title: "Fetching User Details!\nPlease wait...",
            )
          : Scaffold(
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
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20.0),
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
                                    snapshot.data?.name?.toUpperCase() ??
                                        "QUIZZLER",
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
                              top: 30.0,
                              right: 20.0,
                              child: IconButton(
                                tooltip: "Exit",
                                icon: const Icon(Icons.exit_to_app),
                                color: Colors.white,
                                iconSize: 25.0,
                                onPressed: () async {
                                  await Provider.of<AuthService>(context,
                                          listen: false)
                                      .signOut();
                                },
                              ),
                            ),
                            Positioned(
                              top: 30.0,
                              left: 10.0,
                              child: IconButton(
                                tooltip: "Drawer",
                                icon: const Icon(Icons.menu),
                                color: Colors.white,
                                iconSize: 25.0,
                                onPressed: () {
                                  Scaffold.of(context).openDrawer();
                                },
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: EdgeInsets.fromLTRB(
                              20, isMobile ? 120 : 250, 20, 0),
                          child: Column(
                            children: [
                              //name
                              Text(
                                snapshot.data?.name ?? "QUIZZLER",
                                textScaleFactor: scaleFactor,
                                style: getBoldTextStyle(
                                  color: ColorManager.primary,
                                ),
                              ),
                              //tag
                              Text(
                                // "Bonus Booster, Level 24",
                                snapshot.data?.email ?? 'quizzler@quizzler.com',
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
                                height: cardHeight,
                                decoration: BoxDecoration(
                                  color: ColorManager.primary.withOpacity(1),
                                  borderRadius: BorderRadius.circular(20.0),
                                ),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Expanded(
                                        child: Stats(
                                            "All Time Best", 173, scaleFactor)),
                                    const VerticalDivider(),
                                    Expanded(
                                        child: Stats(
                                            "Questions", 78, scaleFactor)),
                                    const VerticalDivider(),
                                    Expanded(
                                        child: Stats(
                                            "Total Score", 768, scaleFactor)),
                                  ],
                                ),
                              ),
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
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20.0),
                          child: Image.asset('assets/images/ccr.jpg',
                              fit: BoxFit.cover),
                        ),
                      ),
                    ),
                  ],
                ),
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
