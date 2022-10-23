import 'package:flutter/material.dart';
import 'package:quiz_app/screens/profile_screen/components/stats.dart';
import 'package:quiz_app/screens/profile_screen/components/vertical_divider.dart';

import '../../../services/db_services.dart';
import '../../../services/resources/style_manger.dart';

class StatsCard extends StatelessWidget {
  const StatsCard({
    Key? key,
    required this.cardHeight,
    required this.scaleFactor,
  }) : super(key: key);

  final double cardHeight;
  final double scaleFactor;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: DatabaseService().getUserReport(),
        builder: (context, snapshot) => snapshot.hasData
            ? (snapshot.data!.isEmpty
                ? FittedBox(
                    child: Text("No stats...", style: getRegularTextStyle()))
                : SizedBox(
                    height: cardHeight,
                    child: ListView.separated(
                      separatorBuilder: (context, index) =>
                          const CustomVerticalDivider(),
                      itemCount: snapshot.data!.length,
                      scrollDirection: Axis.horizontal,
                      physics: const BouncingScrollPhysics(),
                      itemBuilder: (context, index) {
                        return Center(
                          child: Container(
                            alignment: Alignment.center,
                            margin: const EdgeInsets.only(right: 20.0),
                            padding: const EdgeInsets.symmetric(
                                vertical: 10.0, horizontal: 10.0),
                            width: 100,
                            height: cardHeight,
                            decoration: BoxDecoration(
                              color: ColorManager.primary.withOpacity(1),
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            child: Stats(
                                snapshot.data![index].topic
                                    .replaceAll('-', " ")
                                    .toUpperCase(),
                                snapshot.data![index].score,
                                scaleFactor),
                          ),
                        );
                      },
                    ),
                  ))
            : const Center(child: CircularProgressIndicator()));
  }
}
