import 'dart:math';

import 'package:flutter/material.dart';

int horizontalTileCount(BuildContext context, {required int minWidth}) {
  return max(MediaQuery.of(context).size.width ~/ minWidth, 1);
}

enum ResponsiveBreakpoints {
  mobile(0),
  tablet(640),
  desktop(1080);

  final int width;

  const ResponsiveBreakpoints(this.width);

  static bool isMobile(BuildContext context) =>
      MediaQuery.of(context).size.width < tablet.width;

  static bool isTablet(BuildContext context) =>
      MediaQuery.of(context).size.width < desktop.width &&
      MediaQuery.of(context).size.width >= tablet.width;

  static bool isDesktop(BuildContext context) =>
      MediaQuery.of(context).size.width >= desktop.width;
}

class Responsive extends StatelessWidget {
  final Map<int, Widget> breakpoints;
  final bool useScreenSize;

  Responsive({
    super.key,
    this.useScreenSize = false,
    required this.breakpoints,
  }) {
    assert(breakpoints.isNotEmpty, 'breakpoints must not be empty');
    assert(breakpoints.keys.first == 0, 'first breakpoint width must be 0');

    int previousBreakpointWidth = -1;
    for (final breakpointWidth in breakpoints.keys) {
      assert(
        breakpointWidth > previousBreakpointWidth,
        'breakpoints must be in ascending order',
      );
      previousBreakpointWidth = breakpointWidth;
    }
  }

  Widget findBreakpoint(double maxWidth) {
    final breakpointWidth = breakpoints.keys.toList().reversed.firstWhere(
          (breakpointWidth) => breakpointWidth < maxWidth,
        );
    return breakpoints[breakpointWidth]!;
  }

  @override
  Widget build(BuildContext context) {
    if (useScreenSize) return findBreakpoint(MediaQuery.of(context).size.width);

    return LayoutBuilder(
      builder: (context, constraints) {
        return findBreakpoint(constraints.maxWidth);
      },
    );
  }
}
