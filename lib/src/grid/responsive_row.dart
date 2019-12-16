import 'package:flutter/cupertino.dart';
import 'responsive_widget.dart';

class ResponsiveRow extends ResponsiveWidget {

  final int columns = 12;

  ResponsiveRow({
    Key key,
    Color backgroundColor,
    List<Widget> children,

    Alignment alignment,
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
        children: children
    );

  @override
  buildWidget(BuildContext context){

    // Just rebuild objects if its necessary
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          return Container(
              alignment: alignment ?? Alignment.topLeft,
              width: (width != null && width < 0) ? null : getWidgetWidth(constraints.maxWidth),
              height: getWidgetHeight(constraints.maxHeight),
              decoration: decoration,
              padding: padding,
              margin: margin,
              color: backgroundColor,
              child: children != null ? Wrap(
                  children: children
              ) :
              null
          );
        }
    );
  }
}