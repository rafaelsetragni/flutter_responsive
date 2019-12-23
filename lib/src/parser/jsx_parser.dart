import 'package:flutter/material.dart';
import 'jsx_node.dart';
import 'jsx_node_text.dart';
import 'jsx_node_element.dart';

class JSXParser {

  @visibleForTesting
  static String parserHtmlPattern = '^((?:\\\\.|[^<\\\\]+)*)(<([\\/!]?)(\\w+)((\\s+\\w+=("([^"]|\\\\.)*"|\'([^\']|\\\\.)*\'))*)\\s*(\\/?)>)?';

  @visibleForTesting
  static String parserAttrPattern = '\\s+(\\w+)="(([^"]|\\\\.)*)"|\'(([^\']|\\\\.)*)\'';

  @visibleForTesting
  static final RegExp regExpHtml = RegExp(
      parserHtmlPattern,
      caseSensitive: false,
      multiLine: true
  );

  @visibleForTesting
  static final RegExp regExpAttr = RegExp(
      parserAttrPattern,
      caseSensitive: false,
      multiLine: true
  );

  static List<String> _selfEnclosedTags = const [
    'input',
    'br',
  ];

  @visibleForTesting
  static extractParameters(JSXNodeElement node, String content){
    // TODO
  }

  @visibleForTesting
  static getParseParameters(RegExpMatch match){
    return [
      match.group(1) ?? '',
      match.group(3) ?? '',
      match.group(4) ?? '',
      match.group(5) ?? '',
      match.group(10) ?? ''
    ];
  }

  static parse(String html) {

    _processTree({JSXNode localNode}){
      if(html.isEmpty){ localNode.addNode(JSXNodeText('')); }

      RegExpMatch match;
      String fullMatch;

      do{
        match = regExpHtml.firstMatch(html);

        fullMatch = match?.group(0) ?? '';

        String beforeText, tagName, attributes, closingTag, selfEnclosing;

        if(match != null && fullMatch.isNotEmpty){
          JSXNodeElement childElement;

          List<String> parameters = getParseParameters(match);
          beforeText = parameters[0];
          closingTag = parameters[1];
          tagName    = parameters[2];
          attributes = parameters[3];
          selfEnclosing = parameters[4];

          if(selfEnclosing != '!'){
            if(match.groupCount == 0){

              if(html != null && html.isNotEmpty) {
                return JSXNodeText(html);
              }

            } else {

              if (beforeText.isNotEmpty) {
                localNode?.addNode(JSXNodeText(beforeText));
              }

              // Closing tags, excluding closed tags which are self closing ones
              if (closingTag.isNotEmpty && !_selfEnclosedTags.contains(tagName)) {
                if (localNode is JSXNodeElement) {

                  // If enclosing tag is wrong, invalidate the result
                  if (localNode.localName != tagName) {
                    return null;
                  } else {
                    html = html.replaceFirst(fullMatch, '');
                    return localNode;
                  }
                }
              }

              // Opening tag
              else if (match.group(2) != null) {
                childElement = JSXNodeElement(tagName);
                localNode?.addNode(childElement);
                extractParameters(childElement, attributes);
              }

              // Otherwise this HTML is pure text, so do not build nothing else
            }

            html = html.replaceFirst(fullMatch, '');

            // Self-closing tags
            if (childElement != null && selfEnclosing.isEmpty && !_selfEnclosedTags.contains(tagName)) {
              _processTree(localNode: childElement);
            }
          }
        }
      }
      while(fullMatch.isNotEmpty);

      return localNode;
    }

    return html == null ? null : _processTree(localNode: JSXNodeElement('body'));
  }


}