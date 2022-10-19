import 'package:flutter/material.dart';
import 'package:quiz_app/services/resources/style_manger.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile"),
      ),
      body: SafeArea(
        child: Stack(
          alignment: Alignment.center,
          clipBehavior: Clip.none,
          children: [
            Column(
              children: [
                Container(
                    decoration: BoxDecoration(
                      color: ColorManager.primary.withOpacity(0.75),
                      borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(20.0),
                        bottomRight: Radius.circular(20.0),
                      ),
                    ),
                    height: 200,
                    width: size.width,
                    child: Image.asset('assets/images/logo.png',
                        fit: BoxFit.contain)),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(20, 120, 20, 0),
                    child: Column(
                      // crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        //name
                        Text(
                          "Shishir Rijal",
                          style: getBoldTextStyle(
                            color: ColorManager.primary,
                          ),
                        ),
                        //tag
                        Text(
                          "Bonus Booster, Level 24",
                          style: getRegularTextStyle(
                            color: ColorManager.grey,
                          ),
                        ),
                        const SizedBox(height: 20.0),

                        Container(
                          padding: const EdgeInsets.all(10.0),
                          width: size.width,
                          height: 120.0,
                          decoration: BoxDecoration(
                            color: ColorManager.primary.withOpacity(1),
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: const [
                              // Stats(),
                              // VerticalDivider(),
                              // Stats(),
                              // VerticalDivider(),
                              // Stats(),
                              Expanded(child: Stats("All Time Best", 173)),
                              VerticalDivider(),
                              Expanded(child: Stats("Questions", 78)),
                              VerticalDivider(),
                              Expanded(child: Stats("Total Score", 768)),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Positioned(
              top: 100,
              child: Container(
                height: 200.0,
                width: 200.0,
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
    this.score, {
    Key? key,
  }) : super(key: key);
  final String title;
  final int score;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Icon(
          Icons.star_border,
          color: ColorManager.white,
          size: 30.0,
        ),
        FittedBox(
          child: Text(
            title,
            maxLines: 1,
            // overflow: TextOverflow.ellipsis,
            style: getRegularTextStyle(color: Colors.white70),
          ),
        ),
        const SizedBox(height: 5.0),
        FittedBox(
          child: Text(
            "$score",
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: getBoldTextStyle(color: ColorManager.white),
          ),
        ),
      ],
    );
  }
}

class StatsCard extends StatelessWidget {
  const StatsCard(
    this.title,
    this.score, {
    Key? key,
  }) : super(key: key);
  final String title;
  final int score;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10.0),
      height: 100.0,
      width: 150.0,
      decoration: BoxDecoration(
        color: ColorManager.primary.withOpacity(0.75),
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          FittedBox(
              child: Text("$score",
                  maxLines: 1, style: getBoldTextStyle(color: Colors.white))),
          FittedBox(
              child: Text(title,
                  maxLines: 1,
                  style: getRegularTextStyle(color: Colors.white70))),
        ],
      ),
    );
  }
}
