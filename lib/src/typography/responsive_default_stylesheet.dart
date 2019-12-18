import 'package:flutter/material.dart';

import 'responsive_stylesheet.dart';
import 'responsive_typography.dart';

/// Full default stylesheet, based on styles defined on [ResponsiveTypography]
final Map<String, ResponsiveStylesheet> defaultStylesheet = {
  'h1': ResponsiveStylesheet(
      textStyle: ResponsiveTypography.h1, displayStyle: DisplayStyle.block),
  'h2': ResponsiveStylesheet(
      textStyle: ResponsiveTypography.h2, displayStyle: DisplayStyle.block),
  'h3': ResponsiveStylesheet(
      textStyle: ResponsiveTypography.h3, displayStyle: DisplayStyle.block),
  'h4': ResponsiveStylesheet(
      textStyle: ResponsiveTypography.h4, displayStyle: DisplayStyle.block),
  'h5': ResponsiveStylesheet(
      textStyle: ResponsiveTypography.h5, displayStyle: DisplayStyle.block),
  'h6': ResponsiveStylesheet(
      textStyle: ResponsiveTypography.h6, displayStyle: DisplayStyle.block),
  'pre': ResponsiveStylesheet(textStyle: TextStyle(fontFamily: 'monospace')),
  'code': ResponsiveStylesheet(
      textStyle:
          TextStyle(color: Colors.white, fontSize: 12, fontFamily: 'monospace'),
      padding: EdgeInsets.symmetric(horizontal: 5.0, vertical: 2.0),
      boxDecoration: BoxDecoration(color: Colors.grey)),
  'center': ResponsiveStylesheet(
      textAlign: TextAlign.center, alignment: Alignment.center),
  'mute': ResponsiveStylesheet(opacity: 0.5),
  'u': ResponsiveStylesheet(
      textStyle: TextStyle(
          fontStyle: FontStyle.italic, decoration: TextDecoration.underline),
      displayStyle: DisplayStyle.inline),
  'p': ResponsiveStylesheet(
    textIndent: 0,
    displayStyle: DisplayStyle.block,
    padding: EdgeInsets.symmetric(vertical: 5.0),
  ),
  'q': ResponsiveStylesheet(
      textAlign: TextAlign.justify,
      displayStyle: DisplayStyle.block,
      textStyle: TextStyle(fontStyle: FontStyle.italic),
      padding: EdgeInsets.symmetric(vertical: 5.0),
      margin: EdgeInsets.only(left: 20)),
  'b': ResponsiveStylesheet(textStyle: TextStyle(fontWeight: FontWeight.bold)),
  'i': ResponsiveStylesheet(textStyle: TextStyle(fontStyle: FontStyle.italic)),
  'a': ResponsiveStylesheet(
    textStyle: TextStyle(
      decoration: TextDecoration.underline,
      color: Colors.blueAccent,
      decorationColor: Colors.blueAccent,
    ),
  ),
  '.align-left': ResponsiveStylesheet(
    textAlign: TextAlign.left,
  ),
};
