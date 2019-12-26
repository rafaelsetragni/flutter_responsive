import 'package:flutter/material.dart';
import 'package:flutter_responsive/src/typography/responsive_stylesheet.dart';
import 'responsive_default_stylesheet.dart';
import 'package:flutter_responsive/src/parser/jsx_parser.dart';
import 'package:flutter_responsive/src/parser/jsx_node.dart';
import 'package:flutter_responsive/src/parser/jsx_node_text.dart';
import 'package:flutter_responsive/src/parser/jsx_node_element.dart';

/// Converts HTML [String] texts into [RichText] objects
class ResponsiveParser {
  final List<String> _allowedElements = [];
  Map<String, ResponsiveStylesheet> stylesheet;
  Map<String, Widget> widgets;

  set allowedElements(List<String> list) {
    _allowedElements.clear();
    _allowedElements.addAll(list);
  }

  /// GET RESPECTIVE NODE STYLESHEET
  @visibleForTesting
  ResponsiveStylesheet getStylesheet(String tag) {
    ResponsiveStylesheet finderStylesheet;

    // TODO Match could be improve to use the same CSS Web rules. Now is working only for equal elements
    if (tag != null &&
        defaultStylesheet != null &&
        defaultStylesheet.containsKey(tag)) {
      finderStylesheet = defaultStylesheet[tag];
    }

    if (tag != null && stylesheet.containsKey(tag)) {
      finderStylesheet = finderStylesheet == null
          ? (stylesheet != null ? stylesheet[tag] : null)
          : ResponsiveStylesheet.cascade(finderStylesheet, stylesheet[tag],
              mergeBoxProperties: true);
    }

    return finderStylesheet;
  }

  /// SHRINKS CODE REMOVING WHITE SPACES AND BREAK LINES
  @visibleForTesting
  String condenseHtmlWhitespace(String stringToTrim) {
    return stringToTrim.replaceAll(RegExp(r'\n+|\s+'), ' '); //.trim()
  }

  /// EXTRACTS BODY CONTENT FROM HTML CODE
  @visibleForTesting
  JSXNode extractBodyContent(String data) {
    return JSXParser.parse(data);
  }

  /// REPLACE BREAK LINES FOR HTML BREAK LINES
  @visibleForTesting
  String replaceBreakLines(String data, bool renderNewLines) {
    return renderNewLines ? data.replaceAll("\n", "<br />") : data;
  }

  /// PARSE HTML CODE INTO RICH TEXT WIDGET
  RichText parseJSX({
      @required
      String html,
      bool renderNewLines = false,
      Map<String, ResponsiveStylesheet> customStylesheet = const {},
      Map<String, Widget> widgets = const {}
  }) {
    stylesheet = customStylesheet;
    this.widgets = widgets;

    String data = replaceBreakLines(html, renderNewLines);
    JSXNodeElement domBody = extractBodyContent(data);

    InlineSpan spanBody;
    if(domBody != null){
      spanBody = parseDomNode(domBody, customStylesheet['body']);
    }

    return RichText(
      text: spanBody ?? TextSpan( text: '' ),
    );
  }

  /// CHAIN OF RESPONSIBILITY DESIGN PATTERN
  ///
  /// PARSE DOM OBJECT AND HIS CHILDREN INTO INLINE SPAN OBJECTS AND ITS DERIVATIVES
  @visibleForTesting
  InlineSpan parseDomNode(JSXNode node, ResponsiveStylesheet lastStyle) {
    if (node == null) return null;

    InlineSpan parentSpan;

    if (node is JSXNodeText) {
      parentSpan = parseDomText(node, lastStyle);
    } else if (node is JSXNodeElement) {
      parentSpan = parseDomElement(node, lastStyle);
    }
/*
    for(JSXNode childNode in node.nodes){
      parseDomNode(node, lastStyle);
    }*/

    return parentSpan;
  }

  /// Parse dom text elements into text widgets
  @visibleForTesting
  InlineSpan parseDomText(JSXNodeText node, ResponsiveStylesheet lastStyle) {

    String finalText = node.text;
    if (finalText == null || finalText.trim().isEmpty) return null;

    InlineSpan returnedSpan;

    if (node.parentNode is JSXNodeElement) {
      // Special content characteristics
      switch (node.parentNode.localName) {
        case "q":
          finalText = '"' + finalText + '"';
          break;
      }
    }

    TextStyle style = lastStyle?.textStyle;// ?? TextStyle();

    return returnedSpan ??
        TextSpan( text: finalText, style: style );
  }

  /// Parse dom elements into container widgets
  @visibleForTesting
  InlineSpan parseDomElement(JSXNodeElement node, ResponsiveStylesheet lastStyle) {

    if (_allowedElements.isNotEmpty &&
        node.localName != 'body' &&
        !_allowedElements.contains(node.localName)) {
      return null;
    }

    List<InlineSpan> myChildren = [];
    ResponsiveStylesheet localStylesheet = getStylesheet(node.localName),
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

    node.nodes.forEach((JSXNode childNode) {
      InlineSpan child = parseDomNode(childNode, childStylesheet);
      if (child != null) myChildren.add(child);
    });

    // Special block treatment
    switch (node.localName) {
      case 'br':
        return TextSpan(text: '\n', children: myChildren);
        break;

      case 'p':
        int indentAmout = lastStyle?.textIndent ?? 0;
        if(indentAmout > 0){
          myChildren = [TextSpan(text: '\t' * indentAmout)]
            ..addAll(myChildren);
        }
        break;
    }

    if (widgets.containsKey(node.localName)) {
      Widget widget = widgets[node.localName];

      if (widget != null) {
        myChildren = [WidgetSpan(child: widget)]..addAll(myChildren);
      }
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
      JSXNodeElement element, ResponsiveStylesheet lastStyle) {

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
              stylesheet.alignment = Alignment.center;
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
  InlineSpan getSpanElement(JSXNodeElement element, List<InlineSpan> children,
      ResponsiveStylesheet lastStyle) {

    InlineSpan span =
      children.length == 1 ? children[0] :
      TextSpan(
          style: lastStyle?.textStyle ?? TextStyle(),
          children: children
      );

    ResponsiveStylesheet localStylesheet =
        applyHtmlAttributes(element, lastStyle);

    if (lastStyle != null && span != null) {
      RichText richText = RichText(
        softWrap: true,
        textAlign: localStylesheet.textAlign ?? TextAlign.left,
        text: span,
      );

      Widget widget = richText;

      if(localStylesheet.opacity < 1.0){
        widget = Opacity(
          opacity: localStylesheet.opacity,
          child: widget,
        );
      }

      if(
        localStylesheet.width != null ||
        localStylesheet.height != null ||
        localStylesheet.margin != null ||
        localStylesheet.padding != null ||
        localStylesheet.boxDecoration != null ||
        localStylesheet.displayStyle == DisplayStyle.block
      ){
        widget = Container(
          width: localStylesheet.width ??
              (localStylesheet.displayStyle == DisplayStyle.block
                  ? double.infinity
                  : null),
          height: localStylesheet.height ?? null,
          margin: localStylesheet.margin,
          padding: localStylesheet.padding,
          decoration: localStylesheet.boxDecoration,
          child: widget
        );
      }

      if(localStylesheet.borderRadius != null){
        widget = ClipRRect(
          borderRadius: localStylesheet.borderRadius,
          child: widget
        );
      }

      WidgetSpan blockSpan = WidgetSpan(
        style: localStylesheet?.textStyle ?? TextStyle(),
        alignment: ( [
          PlaceholderAlignment.baseline,
          PlaceholderAlignment.aboveBaseline,
          PlaceholderAlignment.belowBaseline,
        ].contains(localStylesheet.placeholderAlignment) ) ? PlaceholderAlignment.bottom : localStylesheet.placeholderAlignment ??
            PlaceholderAlignment.bottom,
        child: widget
      );

      return blockSpan;
    }

    return span;
  }
}
