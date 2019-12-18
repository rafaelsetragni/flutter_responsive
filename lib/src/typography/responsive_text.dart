import 'package:flutter/material.dart';
import 'package:flutter_responsive/src/typography/responsive_parser.dart';
import 'package:flutter_responsive/src/typography/responsive_stylesheet.dart';

import 'responsive_stylesheet.dart';

class ResponsiveText extends StatelessWidget {
  final List<String> allowedElements = [];
  final Map<String, ResponsiveStylesheet> stylesheet = {};

  final ResponsiveParser parser = ResponsiveParser();
  final String text;

  final double indentSize = 10.0;

  final Alignment boxAlign;
  final EdgeInsets padding;
  final EdgeInsets margin;
  final Color backgroundColor;
  final BoxDecoration boxDecoration;

  final TextStyle defaultTextStyle;
  final TextStyle defaultLinkStyle;

  final DisplayStyle display;
  final bool renderNewLines;
  final bool showImages;

  final ImageErrorListener onImageError;

  final onLinkTap;

  ResponsiveText(
      {this.text = '',
      List<String> allowedElements = const [],
      Map<String, ResponsiveStylesheet> stylesheet = const {},
      this.boxAlign,
      this.padding,
      this.margin,
      this.backgroundColor,
      this.boxDecoration,
      this.defaultTextStyle,
      this.defaultLinkStyle,
      this.display = DisplayStyle.block,
      this.renderNewLines = true,
      this.showImages = false,
      this.onImageError,
      this.onLinkTap}) {
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
          textStyle: defaultTextStyle ??
              TextStyle(
                  color: Colors.black) //DefaultTextStyle.of(context).style
          )
    });

    RichText parsedText = parser.parseHTML(text, renderNewLines, stylesheet);

    return Container(
      margin: margin,
      decoration: boxDecoration,
      alignment: boxAlign,
      padding: padding,
      color: backgroundColor,
      width: display == DisplayStyle.block ? double.infinity : null,
      child: Wrap(
        children: [parsedText],
      ),
    );
  }
}
