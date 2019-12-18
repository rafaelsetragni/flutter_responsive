import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'responsive_widget.dart';

/// Responsive column which change his own width based on parent width
class ResponsiveCol extends ResponsiveWidget {

  /// List of column sizes for all screen limits defined on [ResponsiveScreen]
  final Map<String, int> gridSizes;

  /// List of column offset sizes for all screen limits defined on [ResponsiveScreen]
  final Map<String, int> gridOffsetSizes;

  ResponsiveCol({
    Key key,
    this.gridSizes,
    this.gridOffsetSizes,
    Alignment alignment = Alignment.topLeft,
    Color backgroundColor,
    List<Widget> children,
    BoxDecoration decoration,
    EdgeInsets padding,
    EdgeInsets margin,
    double width,
    double maxWidth,
    double minWidth,
    double height,
    double maxHeight,
    double minHeight,
  }) : super(
            key: key,
            alignment: alignment,
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
/*
  @override
  Widget build(BuildContext context) {

    MediaQueryData mediaQuery = MediaQuery.of(context);

    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {

      EdgeInsets localMargin;

      if(gridOffsetSizes != null){
        double offset = getColumnSize(gridOffsetSizes, mediaQuery.size.width) * constraints.maxWidth;

        if(
        alignment == Alignment.topLeft ||
            alignment == Alignment.centerLeft ||
            alignment == Alignment.bottomLeft
        ){
          localMargin = EdgeInsets.only(left: offset).add(margin ?? EdgeInsets.zero);
        }
        if(
        alignment == Alignment.topRight ||
            alignment == Alignment.centerRight ||
            alignment == Alignment.bottomRight
        ){
          localMargin = EdgeInsets.only(left: offset).add(margin ?? EdgeInsets.zero);
        }
      }

      // Are not performing nicely
      return FractionallySizedBox(
        widthFactor: getColumnSize(gridSizes, mediaQuery.size.width),
        //heightFactor: 1.0,
        child: Container(
          alignment: alignment ?? Alignment.topLeft,
          height: getWidgetHeight(double.infinity),
          decoration: decoration,
          padding: padding,
          margin: localMargin ?? margin,
          color: backgroundColor,
          child: children != null ? Wrap(
              children: children
          ) : null
        )
      );
    });
  }
*/

  @override
  buildWidget(BuildContext context) {
    // Just rebuild objects if its necessary
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
      EdgeInsets localMargin;
      MediaQueryData mediaQuery = MediaQuery.of(context);

      if (gridOffsetSizes != null) {
        double offset = getColumnSize(gridOffsetSizes, mediaQuery.size.width);

        if (offset != 1) {
          offset *= constraints.maxWidth;

          if (alignment == Alignment.topLeft ||
              alignment == Alignment.centerLeft ||
              alignment == Alignment.bottomLeft) {
            localMargin =
                EdgeInsets.only(left: offset).add(margin ?? EdgeInsets.zero);
          }
          if (alignment == Alignment.topRight ||
              alignment == Alignment.centerRight ||
              alignment == Alignment.bottomRight) {
            localMargin =
                EdgeInsets.only(left: offset).add(margin ?? EdgeInsets.zero);
          }
        }
      }

      return Container(
        alignment: alignment ?? Alignment.topLeft,
        decoration: decoration,
        width: getColumnSize(gridSizes, mediaQuery.size.width) *
            constraints.maxWidth,
        height: getWidgetHeight(constraints.maxHeight),
        padding: padding,
        margin: localMargin ?? margin,
        color: backgroundColor,
        child: children != null ? Wrap(children: children) : null,
      );
    });
  }
}
