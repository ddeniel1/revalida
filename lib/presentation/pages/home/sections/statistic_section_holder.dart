import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:nimbus/presentation/layout/adaptive.dart';
import 'package:nimbus/presentation/pages/home/sections/statistics_section.dart';
import 'package:nimbus/presentation/widgets/content_area.dart';
import 'package:nimbus/presentation/widgets/nimbus_info_section.dart';
import 'package:nimbus/presentation/widgets/skill_card.dart';
import 'package:nimbus/presentation/widgets/skill_level.dart';
import 'package:nimbus/presentation/widgets/spaces.dart';
import 'package:nimbus/values/values.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:visibility_detector/visibility_detector.dart';

const double kRunSpacing = 20.0;
const double kMainAxisSpacing = 16.0;
const double kCrossAxisSpacing = 16.0;


class StatisticSelectionHolder extends StatefulWidget {
  StatisticSelectionHolder({Key? key});
  @override
  _StatisticSelectionHolderState createState() => _StatisticSelectionHolderState();
}

class _StatisticSelectionHolderState extends State<StatisticSelectionHolder>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );
    // _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    
    double screenWidth = widthOfScreen(context) - (getSidePadding(context) * 2);
    double screenHeight = heightOfScreen(context);
    double contentAreaWidthLg = screenWidth * 0.5;
    double contentAreaWidthSm = screenWidth;
    double contentAreaHeight = responsiveSize(
      context,
      screenHeight * 1.6,
      screenHeight * 0.8,
      md: screenHeight * 0.8,
      sm: screenHeight * 1.6,
    );

    return Container(
      padding: EdgeInsets.symmetric(horizontal: getSidePadding(context)),
      child: ResponsiveBuilder(
        refinedBreakpoints: RefinedBreakpoints(),
        builder: (context, sizingInformation) {
          double screenWidth = sizingInformation.screenSize.width;
          if (screenWidth <= RefinedBreakpoints().tabletSmall) {
            return VisibilityDetector(
              key: Key('skills-section-BG'),
              onVisibilityChanged: (visibilityInfo) {
                double visiblePercentage = visibilityInfo.visibleFraction * 100;
                if (visiblePercentage > 20) {
                  _controller.forward();
                }
              },
              child: StatisticsSection(),
            );
          } else if (screenWidth > RefinedBreakpoints().tabletSmall &&
              screenWidth <= 1024) {
            return VisibilityDetector(
              key: Key('skills-section-LA'),
              onVisibilityChanged: (visibilityInfo) {
                double visiblePercentage = visibilityInfo.visibleFraction * 100;
                if (visiblePercentage > 25) {
                  _controller.forward();
                }
              },
              child: StatisticsSection(),
            );
          } else {
            return VisibilityDetector(
              key: Key('skills-section-lg'),
              onVisibilityChanged: (visibilityInfo) {
                double visiblePercentage = visibilityInfo.visibleFraction * 100;
                if (visiblePercentage > 50) {
                  _controller.forward();
                }
              }, child: StatisticsSection(),
            );
          }
        },
      ),
    );
  }
}
