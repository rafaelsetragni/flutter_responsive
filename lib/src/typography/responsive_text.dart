import 'package:flutter/material.dart';
import 'package:flutter_responsive/src/typography/responsive_parser.dart';
import 'package:flutter_responsive/src/typography/responsive_stylesheet.dart';

import 'responsive_stylesheet.dart';

class ResponsiveText extends StatefulWidget {

  List<String> allowedElements;
  Map<String, ResponsiveStylesheet> stylesheet;

  ResponsiveParser parser;
  String text;

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
    this.stylesheet,
    this.text,
    this.allowedElements,
    this.onLinkTap,
    this.shrinkToFit = false,
    this.renderNewLines = false,
    this.boxAlign =  Alignment.topLeft,
    this.boxDecoration,
    this.onImageError,
    this.defaultLinkStyle,
    this.showImages = true,
    this.padding,
    this.margin,
    this.backgroundColor,
    this.defaultTextStyle
  }){
    parser = ResponsiveParser(allowedElements ?? []);
  }

  @override
  _ResponsiveText createState() => _ResponsiveText(
      stylesheet,
      text,
      boxAlign,
      padding,
      margin,
      backgroundColor,
      boxDecoration,
      defaultTextStyle,
      defaultLinkStyle,
      shrinkToFit,
      renderNewLines,
      showImages,
      onImageError,
      onLinkTap
  );
}

class _ResponsiveText extends State<ResponsiveText> {

  List<String> allowedElements;
  Map<String, ResponsiveStylesheet> stylesheet;

  ResponsiveParser parser;
  String text;

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

  _ResponsiveText(
      this.stylesheet,
      this.text,
      this.boxAlign,
      this.padding,
      this.margin,
      this.backgroundColor,
      this.boxDecoration,
      this.defaultTextStyle,
      this.defaultLinkStyle,
      this.shrinkToFit,
      this.renderNewLines,
      this.showImages,
      this.onImageError,
      this.onLinkTap
  );

  @override
  Widget build(BuildContext context) {

    if(stylesheet == null){
      stylesheet = {};
    }

    stylesheet.addAll({
      'body' : ResponsiveStylesheet(
        textStyle: widget.defaultTextStyle ?? TextStyle( color: Colors.black )//DefaultTextStyle.of(context).style
      )
    });

    RichText parsedText = widget.parser.parseHTML(text, widget.renderNewLines, stylesheet);

    return
      Container(
        margin: widget.margin,
        decoration: widget.boxDecoration,
        alignment: widget.boxAlign,
        padding: widget.padding,
        color: widget.backgroundColor,
        width: widget.shrinkToFit ? null : double.infinity,
        child: Wrap(
          children: [ parsedText ],
        ),
      );
  }
}
