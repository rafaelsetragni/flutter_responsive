import 'package:flutter/material.dart';

class JSXNode{
  JSXNode parentNode;

  @protected
  String tag;

  addNode(JSXNode node){}
  get localName => tag;
}