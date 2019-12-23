

import 'package:flutter_responsive/src/parser/jsx_node.dart';

class JSXNodeElement extends JSXNode {
  final List<JSXNode> nodes = [];
  final Map<String, String> attributes = {};

  JSXNodeElement(String localName, {List<JSXNode> nodes, Map<String, String> attributes}){
    this.tag = localName;
    if(nodes != null && nodes.isNotEmpty){

      for(JSXNode node in nodes){
        addNode(node);
      }
    }
  }

  @override
  addNode(JSXNode node){
    nodes.add(node);
    node.parentNode = this;
  }

  @override
  bool operator == (other) {
    bool result = false;

    if(other is JSXNodeElement){

      result = localName == other.localName
          //&& parentNode.getTag() == other.parentNode.getTag()
          && attributes.length == other.attributes.length
          && nodes.length == other.nodes.length;

      for (var entry in attributes.entries) {
        result = entry.value == other.attributes[entry.key];
        if(result){ break; }
      }

      for(int pos = 0; result && pos < nodes.length; pos++ ){
        result = nodes[pos] == other.nodes[pos];
      }
    }

    return result;
  }

  @override
  String toString() {
    return '{ localName: $localName, parentNode: ${parentNode?.localName}, attributes: $attributes, nodes: $nodes }';
  }
}