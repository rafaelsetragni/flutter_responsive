import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'responsive_widget.dart';

/// Responsive container who center his content elements and limits his own widget based on [ResponsiveScreen] limits
class ResponsiveContainer extends ResponsiveWidget {
  ResponsiveContainer({
    Key key,
    Color backgroundColor,
    List<Widget> children,
    BoxDecoration decoration,
    EdgeInsets padding,
    EdgeInsets margin,
    double width,
    double maxWidth = double.infinity,
    double minWidth,
    double height,
    double maxHeight,
    double minHeight,
  }) : super(
            key: key,
            backgroundColor: backgroundColor,
            decoration: decoration,
            padding: padding,
            margin: margin,
            width: width,
            maxWidth: maxWidth,
            minWidth: minWidth,
            height: height,
            maxHeight: maxHeight,
            minHeight: minHeight,
            children: children);

  @visibleForTesting
  double getContainerSize(double widthLimit, double parentSize) {
    double limitSize = widthLimit * 0.95;
    return min(parentSize, limitSize);
  }

  @override
  Widget buildWidget(BuildContext context) {
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
      return Align(
        alignment: Alignment.topCenter,
        child: Container(
          width: min(maxWidth, constraints.maxWidth),
          height: getWidgetHeight(constraints.maxHeight),
          padding: padding,
          margin: margin,
          color: backgroundColor,
          child: children != null ? Wrap(children: children) : null,
        ),
      );
    });
  }
}
