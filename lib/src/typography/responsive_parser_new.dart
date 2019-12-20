import 'dart:html';

import 'package:flutter/material.dart';
import 'package:flutter_responsive/src/typography/responsive_stylesheet.dart';

/// Converts HTML [String] texts into [RichText] objects
class ResponsiveParser {
  final List<String> _allowedElements = [];
  Map<String, ResponsiveStylesheet> stylesheet;
  Map<String, Widget> widgets;

  // RichText methods return error when they received null values
  InlineSpan emptyTextSpan = TextSpan(text: '');

  set allowedElements(List<String> list) {
    _allowedElements.clear();
    _allowedElements.addAll(list);
  }

  static final RegExp regExp = RegExp(
      r'(?<!\\)<([\/!])?\w+(\s+\w+="[^"]*")*(\s+)?(\/)?>',
      caseSensitive: false,
      multiLine: true
  );

  static List<String> _selfEnclosedTags = const [
    'input',
    'br',
  ];

  @visibleForTesting
  static Map<String, String> extractParameters(Element node, String content){
    RegExpMatch match = regExp.firstMatch(content);

    if(match.groupCount > 0){
      content = content.replaceFirst(regExp, '');
    } else if(content != null && content.isNotEmpty) {

    }
  }

  static List<Node> parse(String html, {Node localNode}){
    RegExpMatch match = regExp.firstMatch(html);

    if(match.groupCount == 0){
      if(html != null && html.isNotEmpty) {
        return [Text(html)];
      }
    } else {
      String
      tagName = match.group(2),
          attributes = match.group(3),
          closingTag = match.group(1),
          selfEnclosing = match.group(11);

      // Closing tag
      if(closingTag.isNotEmpty){
        if(localNode is Element){
          if(localNode.localName != tagName){

          }
        }

      } else

        // Self-closing tag
      if (selfEnclosing.isNotEmpty){

      }

      // Opening tag
      else {
        Element element = Element(tagName);
        extractParameters(element, attributes);
        element.parentNode = localNode;

        html = html.replaceFirst(regExp, '');

        element.nodes..addAll(parse(html, localNode: element));
      }

    }
    return null;
  }

  /// Extracts body content from html code
  @visibleForTesting
  dom.Node extractBodyContent(String data) {
    return data == null ? null : parser.parse(data)?.body?.children?.first;
  }

  /// Replace break lines for html break lines
  @visibleForTesting
  String replaceBreakLines(String data, bool renderNewLines) {
    return renderNewLines ? data.replaceAll("\n", "<br />") : data;
  }

  /// Parse html code into rich text widget
  RichText parseHTML({
      String html,
      bool renderNewLines = false,
      Map<String, ResponsiveStylesheet> stylesheet,
      Map<String, Widget> widgets
  }){
    if(html == null || html.isEmpty){ return RichText( text: emptyTextSpan ); }

    this.widgets = widgets;

    String data = replaceBreakLines(html, renderNewLines);
    dom.Node domBody = extractBodyContent(data);

    return RichText(
      text: parseDomNode(domBody) ?? emptyTextSpan
    );
  }

  /// CHAIN OF RESPONSIBILITY DESIGN PATTERN
  ///
  /// Parse dom object and his children into inline span objects and its derivatives
  @visibleForTesting
  InlineSpan parseDomNode(dom.Node node) {
    if (node == null) return null;

    InlineSpan parentSpan;

    if (node is dom.Text) {
      parentSpan = parseDomText(node);
    } else if (node is dom.Element) {
      parentSpan = parseDomElement(node);
    }

    return parentSpan;
  }

  /// Parse dom text elements into text widgets
  @visibleForTesting
  InlineSpan parseDomText(dom.Text node) {
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
        children.add(parseDomNode(node));
      });
    }

    return getSpanText( finalText, children );
  }

  /// Parse dom elements into container widgets
  @visibleForTesting
  InlineSpan parseDomElement(dom.Element node) {

    // Body should never be excluded
    if (node.localName != 'body' && _allowedElements.isNotEmpty && !_allowedElements.contains(node.localName)) {
      return null;
    }

    List<InlineSpan> myChildren = [];

    for(dom.Node childNode in node.nodes) {
      InlineSpan child = parseDomNode(childNode);
      if (child != null) myChildren.add(child);
    }

    return getSpanElement(node, myChildren);
  }

  @visibleForTesting
  InlineSpan getSpanText(String content, List<InlineSpan> children){
    return TextSpan(text: content, children: children ?? []);
  }

  /// Applies the stylesheet to the span object
  @visibleForTesting
  InlineSpan getSpanElement(dom.Element node, List<InlineSpan> children) {

    InlineSpan span;

    if (widgets.containsKey(node.localName)) {

      Widget widget = widgets[node.localName];

      if (widget != null) {
        return children == null || children.isEmpty ?
          WidgetSpan(child: widget):
          TextSpan(
              children: [WidgetSpan(child: widget)]..addAll(children)
          );
      }

    } else {

      span = TextSpan(
          children: children
      );

      if (span != null) {
        Widget widget;

        if(false /*container*/){

          RichText richText = RichText(
            softWrap: true,
            text: span,
          );

          Widget widget = richText;
        }

        return widget == null ? span : WidgetSpan(
            child: widget
        );
      }

    }

    return span ?? emptyTextSpan;
  }
}
