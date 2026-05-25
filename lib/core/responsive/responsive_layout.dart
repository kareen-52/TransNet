import 'package:flutter/material.dart';
import 'breakpoints.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';

class ResponsiveLayout extends StatelessWidget {
  final Widget mobile;
  final Widget? tablet;
  final Widget? desktop;

  const ResponsiveLayout({
    super.key,
    required this.mobile,
    this.tablet,
    this.desktop,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth;
        if (width <= AppBreakpoints.mobile) {
          return mobile;
        } else if (width <= AppBreakpoints.tablet) {    
          return tablet ?? mobile;
        } else {
          return desktop ?? tablet ?? mobile;
        }
      },
    );
  }
}


extension ResponsiveContext on BuildContext {
  double get screenWidth => MediaQuery.of(this).size.width;
  double get screenHeight => MediaQuery.of(this).size.height;
  bool get isTablet => screenWidth > AppBreakpoints.mobile;
  bool get isLandscape =>
      MediaQuery.of(this).orientation == Orientation.landscape;
}


extension ResponsiveValue on BuildContext {
  T responsive<T>({required T mobile, required T tablet}) =>
      isTablet ? tablet : mobile;
}


class TabletFormContainer extends StatelessWidget {
  final Widget child;
  final double maxWidth;
  final EdgeInsetsGeometry? padding;

  const TabletFormContainer({
    super.key,
    required this.child,
    this.maxWidth = 560,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: maxWidth),
        child: padding != null
            ? Padding(padding: padding!, child: child)
            : child,
      ),
    );
  }
}


double tabletHPadding(BuildContext context) =>
    context.isTablet ? 56.w : 16.w;


double tabletVPadding(BuildContext context) =>
    context.isTablet ? 32.h : 16.h;

int tabletGridColumns(BuildContext context, {int mobile = 1, int tablet = 2}) =>
    context.isTablet ? tablet : mobile;

class TabletTwoColumnLayout extends StatelessWidget {
  final Widget main;
  final Widget side;
  final int mainFlex;
  final int sideFlex;
  final double spacing;

  const TabletTwoColumnLayout({
    super.key,
    required this.main,
    required this.side,
    this.mainFlex = 3,
    this.sideFlex = 2,
    this.spacing = 24,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(flex: mainFlex, child: main),
        SizedBox(width: spacing.w),
        Expanded(flex: sideFlex, child: side),
      ],
    );
  }
}
