import 'package:flutter/cupertino.dart';

/// Flutter's responsive configuration similar to display Html property
enum DisplayStyle {
  /// Text element should occupy the entire line
  block,
  /// Text element should adjust his size to only occupy what it needs
  inline
}

/// Stylesheet that contemplates all properties that could be applied to a single text element inside ResponsiveText widget.
/// [textStyle] Text style to be applied to the text element
/// [textOverflow] Determines how the text overflow should be handled
class ResponsiveStylesheet {

  TextStyle textStyle;
  TextOverflow textOverflow;
  DisplayStyle displayStyle;
  BoxDecoration boxDecoration;
  EdgeInsets padding;
  EdgeInsets margin;
  TextAlign textAlign;
  Alignment alignment;
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
    this.alignment = Alignment.topLeft,
    this.textIndent = 0,
    this.width,
    this.height,
  });

  /// Merge two EdgeInsets objects, merging empty properties. If both properties are defined, than the new property replaces the old one.
  EdgeInsets mergeEdges(EdgeInsets older, EdgeInsets newer) {
    if (newer == null) return older?.copyWith();
    if (older == null) return newer?.copyWith();

    return older.copyWith(
        bottom: newer.bottom,
        top: newer.top,
        left: newer.left,
        right: newer.right);
  }

  /// Merge the stylesheet, replacing the actual parameters by the new ones, when they are defined. Otherwise the old property is preserved.
  /// [mergeBoxProperties] Define if box properties should be merged. Otherwise all box properties receives null values.
  ResponsiveStylesheet merge(ResponsiveStylesheet newStylesheet,
      {bool mergeBoxProperties = false}) {
    if (newStylesheet != null) {
      textStyle = textStyle == null
          ? newStylesheet.textStyle
          : (newStylesheet.textStyle == null
              ? textStyle
              : textStyle.merge(newStylesheet.textStyle));
      textStyle?.merge(TextStyle(inherit: true));
      opacity = newStylesheet.opacity ?? opacity;
      textAlign = newStylesheet.textAlign ?? textAlign;
      alignment = newStylesheet.alignment ?? alignment;
      textIndent = newStylesheet.textIndent ?? textIndent;
      displayStyle = newStylesheet.displayStyle ?? displayStyle;
      textOverflow = newStylesheet.textOverflow ?? textOverflow;

      if (mergeBoxProperties) {
        width = newStylesheet.width ?? width;
        height = newStylesheet.height ?? height;
        margin = mergeEdges(margin, newStylesheet.margin);
        padding = mergeEdges(padding, newStylesheet.padding);
        boxDecoration = newStylesheet.boxDecoration;
      }
    }
    return this;
  }

  /// Cascade the stylesheet, combining two stylesheets into a new one.
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
