import 'package:flutter/material.dart';
import 'package:quiz_app/screens/profile_screen/components/stats.dart';

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
    return Container(
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
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Expanded(child: Stats("All Time Best", 173, scaleFactor)),
          const VerticalDivider(),
          Expanded(child: Stats("Questions", 78, scaleFactor)),
          const VerticalDivider(),
          Expanded(child: Stats("Total Score", 768, scaleFactor)),
        ],
      ),
    );
  }
}
