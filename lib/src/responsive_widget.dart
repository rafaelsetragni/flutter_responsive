import 'package:flutter/cupertino.dart';
import 'package:flutter_responsive/src/responsive_screen.dart';

/// Base widget which contains all common responsive behaviours
abstract class ResponsiveWidget extends StatelessWidget {
  final Alignment alignment;

  final Color backgroundColor;
  final List<Widget> children;

  final BoxDecoration decoration;
  final EdgeInsets padding;
  final EdgeInsets margin;

  final double width;
  final double maxWidth;
  final double minWidth;

  final double height;
  final double maxHeight;
  final double minHeight;

  ResponsiveWidget(
      {Key key,
      this.alignment = Alignment.topLeft,
      this.backgroundColor,
      this.decoration,
      this.padding,
      this.margin,
      this.width,
      this.maxWidth,
      this.minWidth,
      this.height,
      this.maxHeight,
      this.minHeight,
      this.children});

  @protected
  double getColumnSize(Map<String, int> gridSizes, double screenSize) {
    double
        /* 1/12 columns */
        fraction = 0.08332,
        calculatedWidthPercentage = 1;

    if ((ResponsiveScreen.limits?.isNotEmpty ?? false) &&
        (gridSizes?.isNotEmpty ?? false)) {
      for (String gridTag in gridSizes.keys) {
        if (ResponsiveScreen.isScreenSize(gridTag, screenSize)) {
          calculatedWidthPercentage = gridSizes.containsKey(gridTag)
              ? (fraction * gridSizes[gridTag])
              : 1;
        } else {
          break;
        }
      }
    }

    return calculatedWidthPercentage;
  }

  @protected
  double getWidgetWidth(double parentWidth) {
    double widgetWidth = width != null ? width : parentWidth;
    if (maxWidth != null && parentWidth > maxWidth) {
      widgetWidth = maxWidth;
    }
    if (minWidth != null && parentWidth < minWidth) {
      widgetWidth = minWidth;
    }
    return widgetWidth;
  }

  @protected
  double getWidgetHeight(double parentHeight) {
    double widgetHeight = height != null ? height : parentHeight;
    if (maxHeight != null && parentHeight > maxHeight) {
      widgetHeight = maxWidth;
    }
    if (minHeight != null && parentHeight < minHeight) {
      widgetHeight = minHeight;
    }
    return widgetHeight == double.infinity ? null : widgetHeight;
  }

/*
  @protected
  Widget lastWidget;

  @protected
  Size lastSize;
*/
  buildWidget(BuildContext context);

  @override
  Widget build(BuildContext context) {
    //MediaQueryData mediaQuery = MediaQuery.of(context);

    // Just rebuild objects if its necessary.
    // Was necessary to use mutable object into imutable class due to Flutter redo all the
    // calculations on each frame.
    // Using a temporary variable to store the already calculated object improves performance
    /*if(lastWidget == null || lastSize != mediaQuery.size){
      lastSize = mediaQuery.size;
      lastWidget = buildWidget(context);
    }

    return lastWidget;*/
    return buildWidget(context);
  }
}
