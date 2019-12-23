import 'package:flutter_responsive/src/parser/jsx_node.dart';

class JSXNodeText extends JSXNode {
  final String text;

  JSXNodeText(this.text);

  @override
  bool operator == (other) {
    bool result = false;

    if(other is JSXNodeText) {
      result = text == other.text;
    }
    return result;
  }

  @override
  String toString() {
    return '"$text"';
  }
}