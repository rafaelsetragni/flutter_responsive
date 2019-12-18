import 'package:flutter/material.dart';

/// Class containing all the standard Html Styles, based on Bootstrap's web project
class ResponsiveTypography {
  static int rem = 16;

  static TextStyle p =
      TextStyle(fontWeight: FontWeight.normal, fontSize: 1.0 * rem);

  static TextStyle h1 =
      TextStyle(fontWeight: FontWeight.w500, fontSize: 2.5 * rem);
  static TextStyle h2 =
      TextStyle(fontWeight: FontWeight.w500, fontSize: 2.0 * rem);
  static TextStyle h3 =
      TextStyle(fontWeight: FontWeight.w500, fontSize: 1.75 * rem);
  static TextStyle h4 =
      TextStyle(fontWeight: FontWeight.w500, fontSize: 1.5 * rem);
  static TextStyle h5 =
      TextStyle(fontWeight: FontWeight.w500, fontSize: 1.25 * rem);
  static TextStyle h6 =
      TextStyle(fontWeight: FontWeight.w500, fontSize: 1.0 * rem);

  static TextStyle abbr =
      TextStyle(decoration: TextDecoration.underline, fontSize: 1.0 * rem);
  static TextStyle quote =
      TextStyle(fontWeight: FontWeight.w500, fontSize: 1.0 * rem);
  static TextStyle quoteFooter =
      TextStyle(fontStyle: FontStyle.italic, fontSize: 0.8 * rem);
  static TextStyle quoteSource =
      TextStyle(fontStyle: FontStyle.italic, fontSize: 0.8 * rem);
  static TextStyle muted =
      TextStyle(color: Colors.black.withOpacity(0.8), fontSize: 1.0 * rem);
}
