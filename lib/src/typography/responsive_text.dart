import 'package:flutter/material.dart';
import 'package:flutter_responsive/src/typography/responsive_parser.dart';
import 'package:flutter_responsive/src/typography/responsive_stylesheet.dart';
import 'package:html/parser.dart';

import 'responsive_stylesheet.dart';

class ResponsiveText extends StatelessWidget {

  List<String> allowedElements;
  Map<String, ResponsiveStylesheet> stylesheet;

  ResponsiveParser parser;
  final String text;

  final double indentSize = 10.0;

  final Alignment boxAlign;
  final EdgeInsets padding;
  final EdgeInsets margin;
  final Color backgroundColor;
  final BoxDecoration boxDecoration;

  final TextStyle defaultTextStyle;
  final TextStyle defaultLinkStyle;

  final bool shrinkToFit;
  final bool renderNewLines;
  final bool showImages;

  final ImageErrorListener onImageError;

  final onLinkTap;

  ResponsiveText({
      this.text = '',
      this.allowedElements,
      this.stylesheet,
      this.boxAlign,
      this.padding,
      this.margin,
      this.backgroundColor,
      this.boxDecoration,
      this.defaultTextStyle,
      this.defaultLinkStyle,
      this.shrinkToFit,
      this.renderNewLines = true,
      this.showImages,
      this.onImageError,
      this.onLinkTap
  }){
    parser = ResponsiveParser(allowedElements ?? []);
  }

  @override
  Widget build(BuildContext context) {

    if(stylesheet == null){
      stylesheet = {};
    }

    stylesheet.addAll({
      'body' : ResponsiveStylesheet(
        textStyle: defaultTextStyle ?? TextStyle( color: Colors.black )//DefaultTextStyle.of(context).style
      )
    });

    RichText parsedText = parser.parseHTML(text, renderNewLines, stylesheet);

    return
      Container(
        margin: margin,
        decoration: boxDecoration,
        alignment: boxAlign,
        padding: padding,
        color: backgroundColor,
        width: shrinkToFit ? null : double.infinity,
        child: Wrap(
          children: [ parsedText ],
        ),
      );
  }
}
