import 'package:flutter/material.dart';

class Node{
  Node parentNode;
}

class NodeElement extends Node {
  final String localName;
  final List<Node> attributes = [];
  final List<Node> nodes = [];

  NodeElement(this.localName);

  @override
  bool operator == (other) {
    if(other is NodeElement){
      return parentNode == other.parentNode
          && attributes == other.attributes
          && nodes == other.nodes;
    }
    return false;
  }

  @override
  String toString() {
    return '{ localName: $localName, attributes: $attributes, nodes: $nodes }';
  }
}

class NodeText extends Node {
  final String text;

  NodeText(this.text);

  @override
  bool operator == (other) {
    if(other is NodeText){
      return parentNode == other.parentNode
          && text == other.text;
    }
    return false;
  }

  @override
  String toString() {
    return '"$text"';
  }
}

class JSXParser {

  @visibleForTesting
  static String parserPatter = '^((?:\\\\.|[^<\\\\]+)*)(<([\\/!]?)(\\w+)((\\s+\\w+=("[^"]*"|\'[^\']*\'))*)\\s*(\\/?)>)?';

  static final RegExp regExp = RegExp(
      parserPatter,
      caseSensitive: false,
      multiLine: true
  );

  static List<String> _selfEnclosedTags = const [
    'input',
    'br',
  ];

  @visibleForTesting
  static Map<String, String> extractParameters(NodeElement node, String content){
    RegExpMatch match = regExp.firstMatch(content);

    if(match.groupCount > 0){
      content = content.replaceFirst(regExp, '');
    } else if(content != null && content.isNotEmpty) {
      return null;
    }
  }

  static Node parse(String html, {Node localNode}){
    if(html == null || html.isEmpty){ return NodeText(''); }

    RegExpMatch match = regExp.firstMatch(html);

    if(match == null){ return null; }
    if(localNode == null){ localNode = NodeElement('body'); }

    if(match.groupCount == 0){

      if(html != null && html.isNotEmpty) {
        return NodeText(html);
      }

    } else {

      String
        beforeText = match.group(1) ?? '',
        tagName = match.group(2) ?? '',
        attributes = match.group(5) ?? '',
        closingTag = match.group(3) ?? '',
        selfEnclosing = match.group(8) ?? '';

      if(beforeText.isNotEmpty){
        NodeText element = NodeText(beforeText);
        element.parentNode = localNode;

        if(localNode is NodeElement){
          localNode.nodes.add(element);
        }
      }

      // Closing tag
      if(closingTag.isNotEmpty){
        if(localNode is NodeElement){

          // If enclosing tag is wrong, invalidate the result
          if(localNode.localName != tagName){
            return null;
          }
        }

      }

      // Opening tag
      else {
        NodeElement element = NodeElement(tagName);
        element.parentNode = localNode;

        if(localNode is NodeElement){
          localNode.nodes.add(element);
        }

        extractParameters(element, attributes);

        html = html.replaceFirst(regExp, '');

        // Self-closing tags
        if (selfEnclosing.isNotEmpty || _selfEnclosedTags.contains(tagName)){
          return element;
        }

        return parse(html, localNode: element);
      }

    }
    return null;
  }

}