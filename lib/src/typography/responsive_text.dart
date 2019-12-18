import 'package:flutter/material.dart';
import 'package:flutter_responsive/src/typography/responsive_parser.dart';
import 'package:flutter_responsive/src/typography/responsive_stylesheet.dart';

import 'responsive_stylesheet.dart';

/// Transform Html text [String] into [RichText] object, combining dom elements with their respective [ResponsiveStylesheet]
class ResponsiveText extends StatelessWidget {

  /// List containing all the html elements allowed (Recommended to use due to security issues that could rise with filled with user's input)
  final List<String> allowedElements = [];

  /// List of [ResponsiveStylesheet] to be applied on each dom tree node
  final Map<String, ResponsiveStylesheet> stylesheet = {};

  /// Parser responsible to convert Html string text into [RichText] object
  final ResponsiveParser parser = ResponsiveParser();

  /// Html text to be converted into [RichText] Widget
  final String text;

  /// Amount of pixels to be used on text indent
  final double indentSize = 10.0;

  /// Alignment of the objects inside the box. The elements aligned does not respect the vertical text base line.
  final Alignment alignment;

  /// Internal space which separates the box border from the internal elements
  final EdgeInsets padding;

  /// External space which separates the box border from the outside elements
  final EdgeInsets margin;

  /// Color to be applied into box background (overrides backgroundColor into [BoxDecoration] property
  final Color backgroundColor;

  /// Decoration to be applied into box background and borders (backgroundColor property is overrided by backgroundColor property from this own Class if defined
  final BoxDecoration boxDecoration;

  /// Text style to be applied to the text element
  final TextStyle textStyle;

  /// Determines if the text element should occupy all line or not
  final DisplayStyle display;

  /// Determines if the new line characters (\n) should be converted to <br> dom nodes
  final bool renderNewLines;

  ResponsiveText({
      this.text = '',
      List<String> allowedElements = const [],
      Map<String, ResponsiveStylesheet> stylesheet = const {},
      this.alignment,
      this.padding,
      this.margin,
      this.backgroundColor,
      this.boxDecoration,
      this.textStyle,
      this.display = DisplayStyle.block,
      this.renderNewLines = true
  }){
    if (allowedElements.isNotEmpty) {
      this.allowedElements.clear();
      this.allowedElements.addAll(allowedElements);

      parser.allowedElements = allowedElements;
    }
    if (stylesheet.isNotEmpty) {
      this.stylesheet.clear();
      this.stylesheet.addAll(stylesheet);
    }
  }

  @override
  Widget build(BuildContext context) {
    stylesheet.addAll({
      'body': ResponsiveStylesheet(
          textStyle: textStyle ??
              TextStyle(
                  color: Colors.black) //DefaultTextStyle.of(context).style
          )
    });

    RichText parsedText = parser.parseHTML(text, renderNewLines, stylesheet);

    return Container(
      margin: margin,
      decoration: boxDecoration,
      alignment: alignment,
      padding: padding,
      color: backgroundColor,
      width: display == DisplayStyle.block ? double.infinity : null,
      child: Wrap(
        children: [parsedText],
      ),
    );
  }
}
