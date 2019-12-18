import 'package:flutter/material.dart';
import 'package:flutter_responsive/src/typography/responsive_stylesheet.dart';
import 'package:html/dom.dart' as dom;
import 'package:html/parser.dart' as parser;

import 'responsive_default_stylesheet.dart';


/// Converts HTML [String] texts into [RichText] objects
class ResponsiveParser {
  final List<String> _allowedElements = [];
  Map<String, ResponsiveStylesheet> stylesheet;

  set allowedElements(List<String> list) {
    _allowedElements.clear();
    _allowedElements.addAll(list);
  }

  /// GET RESPECTIVE NODE STYLESHEET
  @visibleForTesting
  ResponsiveStylesheet getStylesheet(dom.Element element) {
    ResponsiveStylesheet findedStylesheet;
    String tag = element.localName;

    // TODO Match could be improve to use the same CSS Web rules. Now is working only for equal elements
    if (tag != null &&
        defaultStylesheet != null &&
        defaultStylesheet.containsKey(tag)) {
      findedStylesheet = defaultStylesheet[tag];
    }

    if (tag != null && stylesheet != null && stylesheet.containsKey(tag)) {
      findedStylesheet = findedStylesheet == null
          ? stylesheet[tag]
          : ResponsiveStylesheet.cascade(findedStylesheet, stylesheet[tag],
              mergeBoxProperties: true);
    }

    return findedStylesheet;
  }

  /// SHRINKS CODE REMOVING WHITE SPACES AND BREAK LINES
  @visibleForTesting
  String condenseHtmlWhitespace(String stringToTrim) {
    return stringToTrim.replaceAll(RegExp(r'\n+|\s+'), ' '); //.trim()
  }

  /// EXTRACTS BODY CONTENT FROM HTML CODE
  @visibleForTesting
  dom.Node extractBodyContent(String data) {
    return parser.parse(data)?.body;
  }

  /// REPLACE BREAK LINES FOR HTML BREAK LINES
  @visibleForTesting
  String replaceBreakLines(String data, bool renderNewLines) {
    return renderNewLines ? data.replaceAll("\n", "<br />") : data;
  }

  /// PARSE HTML CODE INTO RICH TEXT WIDGET
  RichText parseHTML(String html, bool renderNewLines,
      Map<String, ResponsiveStylesheet> customStylesheet) {
    stylesheet = customStylesheet;

    String data = replaceBreakLines(html, renderNewLines);
    dom.Node domBody = extractBodyContent(data);

    InlineSpan spanBody = parseDomNode(domBody, customStylesheet['body']);

    return RichText(
      text: TextSpan(
          style: customStylesheet['body'].textStyle,
          children: [spanBody ?? TextSpan(text: '')]),
    );
  }

  /// CHAIN OF RESPONSIBILITY DESIGN PATTERN
  ///
  /// PARSE DOM OBJECT AND HIS CHILDREN INTO INLINE SPAN OBJECTS AND ITS DERIVATIVES
  @visibleForTesting
  InlineSpan parseDomNode(dom.Node node, ResponsiveStylesheet lastStyle) {
    if (node == null) return null;

    InlineSpan parentSpan;

    if (node is dom.Text) {
      parentSpan = parseDomText(node, lastStyle);
    } else if (node is dom.Element) {
      parentSpan = parseDomElement(node, lastStyle);
    }

    return parentSpan;
  }

  /// Parse dom text elements into text widgets
  @visibleForTesting
  InlineSpan parseDomText(dom.Text node, ResponsiveStylesheet lastStyle) {
    List<InlineSpan> children;

    String finalText = node.text;
    if (finalText == null || finalText.trim().isEmpty) return null;

    if (node.parent is dom.Element) {
      // Special content characteristics
      switch (node.parent.localName) {
        case "q":
          finalText = '"' + finalText + '"';
          break;
      }
    }

    if (node.nodes.isNotEmpty) {
      node.nodes.forEach((dom.Node childNode) {
        children.add(parseDomNode(node, lastStyle));
      });
    }

    return TextSpan(text: finalText, children: children, style: TextStyle());
  }

  /// Parse dom elements into container widgets
  @visibleForTesting
  InlineSpan parseDomElement(dom.Element node, ResponsiveStylesheet lastStyle) {
    if (_allowedElements.isNotEmpty &&
        node.localName != 'body' &&
        !_allowedElements.contains(node.localName)) {
      return null;
    }

    List<InlineSpan> myChildren = [];
    ResponsiveStylesheet localStylesheet = getStylesheet(node),
        // Box properties and positional attributes should not cascade to children
        childStylesheet = localStylesheet == null
            ? lastStyle
            : ResponsiveStylesheet.cascade(lastStyle, localStylesheet);

    if (localStylesheet == null) {
      localStylesheet = lastStyle;
    } else {
      // Box properties and positional attributes should be maintained while local style is cascaded from last styles
      localStylesheet = ResponsiveStylesheet.cascade(lastStyle, localStylesheet,
          mergeBoxProperties: true);
    }

    node.nodes.forEach((dom.Node childNode) {
      InlineSpan child = parseDomNode(childNode, childStylesheet);
      if (child != null) myChildren.add(child);
    });

    // Special block treatment
    switch (node.localName) {
      case "br":
        return TextSpan(text: '\n', children: myChildren);
        break;

      case "p":
        myChildren = [TextSpan(text: '\t' * (lastStyle?.textIndent ?? 0))]
          ..addAll(myChildren);
        break;
    }

    InlineSpan parentSpan;
    if (myChildren.isNotEmpty) {
      parentSpan = getSpanElement(node, myChildren, localStylesheet);
    }

    return parentSpan;
  }

  /// APPLIES HTML ATTRIBUTES TO THE SPAN OBJECT
  @visibleForTesting
  ResponsiveStylesheet applyHtmlAttributes(
      dom.Element element, ResponsiveStylesheet lastStyle) {
    ResponsiveStylesheet stylesheet =
        ResponsiveStylesheet().merge(lastStyle, mergeBoxProperties: true);
    for (String attribute in element.attributes.keys) {
      switch (attribute) {
        case 'align':
          switch (element.attributes['align']) {
            case 'right':
              stylesheet.textAlign = TextAlign.right;
              break;
            case 'left':
              stylesheet.textAlign = TextAlign.left;
              break;
            case 'center':
              stylesheet.textAlign = TextAlign.center;
              break;
            case 'justify':
              stylesheet.textAlign = TextAlign.justify;
              break;
          }
          break;

        case 'width':
          if (element.attributes['width'].isNotEmpty) {
            stylesheet.width = double.parse(element.attributes['width']);
          }
          break;

        case 'height':
          if (element.attributes['height'].isNotEmpty) {
            stylesheet.width = double.parse(element.attributes['height']);
          }
          break;
      }
    }

    return stylesheet;
  }

  /// APPLIES THE STYLESHEET TO THE SPAN OBJECT
  @visibleForTesting
  InlineSpan getSpanElement(dom.Element element, List<InlineSpan> children,
      ResponsiveStylesheet lastStyle) {
    InlineSpan span = TextSpan(
        text: '',
        style: lastStyle?.textStyle ?? TextStyle(),
        children: children);

    ResponsiveStylesheet localStylesheet =
        applyHtmlAttributes(element, lastStyle);

    if (lastStyle != null && span != null) {
      RichText richText = RichText(
        softWrap: true,
        textAlign: localStylesheet.textAlign,
        text: span,
      );

      WidgetSpan blockSpan = WidgetSpan(
          style: localStylesheet?.textStyle ?? TextStyle(),
          child: Container(
            width: localStylesheet.width ??
                (localStylesheet.displayStyle == DisplayStyle.block
                    ? double.infinity
                    : null),
            height: localStylesheet.height ?? null,
            margin: localStylesheet.margin,
            padding: localStylesheet.padding,
            decoration: localStylesheet.boxDecoration,
            child: localStylesheet.opacity < 1.0
                ? Opacity(
                    opacity: localStylesheet.opacity,
                    child: richText,
                  )
                : richText,
          ));

      return blockSpan;
    }

    return span;
  }
}
