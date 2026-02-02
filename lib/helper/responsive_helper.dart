import 'package:flutter/material.dart';

class ResponsiveHelper {
  static bool isMobile(BuildContext context) =>
      MediaQuery.of(context).size.width < 600;

  static bool isTablet(BuildContext context) =>
      MediaQuery.of(context).size.width >= 600 &&
      MediaQuery.of(context).size.width < 1024;

  static bool isDesktop(BuildContext context) =>
      MediaQuery.of(context).size.width >= 1024;

  static double getScreenWidth(BuildContext context) =>
      MediaQuery.of(context).size.width;

  static double getResponsivePadding(BuildContext context) {
    if (isMobile(context)) return 16;
    if (isTablet(context)) return 24;
    return 32;
  }

  static int getGridCrossAxisCount(BuildContext context) {
    if (isMobile(context)) return 3;
    if (isTablet(context)) return 4;
    return 6;
  }

  static int getMaxVisibleImages(BuildContext context) {
    if (isMobile(context)) return 3;
    if (isTablet(context)) return 5;
    return 6;
  }

  static double getImageSize(BuildContext context) {
    if (isMobile(context)) return 80;
    if (isTablet(context)) return 100;
    return 120;
  }

  static double getCardMaxWidth(BuildContext context) {
    if (isMobile(context)) return double.infinity;
    if (isTablet(context)) return 700;
    return 900;
  }

  static int getListColumns(BuildContext context) {
    if (isMobile(context)) return 1;
    if (isTablet(context)) return 1;
    return 2;
  }
}
