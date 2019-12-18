import 'package:flutter/cupertino.dart';

enum DisplayStyle { block, inline }

class ResponsiveStylesheet {
  TextStyle textStyle;
  TextOverflow textOverflow;
  DisplayStyle displayStyle;
  BoxDecoration boxDecoration;
  EdgeInsets padding;
  EdgeInsets margin;
  TextAlign textAlign;
  Alignment boxAlignment;
  double opacity;
  double width;
  double height;

  int textIndent;

  ResponsiveStylesheet({
    this.padding,
    this.margin,
    this.textStyle,
    this.textOverflow = TextOverflow.clip,
    this.displayStyle = DisplayStyle.inline,
    this.boxDecoration,
    this.opacity = 1.0,
    this.textAlign = TextAlign.left,
    this.boxAlignment = Alignment.topLeft,
    this.textIndent = 0,
    this.width,
    this.height,
  });

  ResponsiveStylesheet merge(ResponsiveStylesheet newStylesheet,
      {bool mergeBoxProperties = false}) {
    if (newStylesheet != null) {
      textStyle = textStyle == null
          ? newStylesheet.textStyle
          : (
          newStylesheet.textStyle == null ? textStyle :
            textStyle.merge(newStylesheet.textStyle)
      );
      textStyle?.merge(TextStyle(inherit: true));
      opacity = newStylesheet.opacity ?? opacity;
      textAlign = newStylesheet.textAlign ?? textAlign;
      boxAlignment = newStylesheet.boxAlignment ?? boxAlignment;
      textIndent = newStylesheet.textIndent ?? textIndent;
      displayStyle = newStylesheet.displayStyle ?? displayStyle;
      textOverflow = newStylesheet.textOverflow ?? textOverflow;

      if (mergeBoxProperties) {
        width = newStylesheet.width ?? width;
        height = newStylesheet.height ?? height;
        margin = newStylesheet.margin ?? newStylesheet.margin;
        padding = newStylesheet.padding ?? newStylesheet.padding;
        boxDecoration = newStylesheet.boxDecoration;
      }
    }
    return this;
  }

  static ResponsiveStylesheet cascade(
      ResponsiveStylesheet oldStylesheet, ResponsiveStylesheet newStylesheet,
      {bool mergeBoxProperties = false}) {
    ResponsiveStylesheet resultedStylesheet = ResponsiveStylesheet();

    if (oldStylesheet != null) {
      resultedStylesheet.merge(oldStylesheet,
          mergeBoxProperties: mergeBoxProperties);
    }

    if (newStylesheet != null) {
      resultedStylesheet.merge(newStylesheet,
          mergeBoxProperties: mergeBoxProperties);
    }

    return resultedStylesheet;
  }
}
