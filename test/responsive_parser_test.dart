import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_responsive/src/parser/html_parser.dart';

void main() {

  String businessRule;

  testWidgets('Regex parser test', (WidgetTester tester) async {

    RegExpMatch match;
    final RegExp regExp = RegExp(
        JSXParser.parserPatter,
        caseSensitive: false,
        multiLine: true
    );

    match = regExp.firstMatch('pre-text\\<a\\\\\\\\\\\\\\\\\\\<aaa<div class="TbwUpd" align=\'\'><cite class="iUh30 bc"><i/>https://github.com › dart-lang › html › blob › master › lib › parser</cite></div>');

    businessRule = 'Regex parser do not work as expected';

    expect(match?.group(1), 'pre-text\\<a\\\\\\\\\\\\\\\\\\\<aaa', reason: businessRule);
    expect(match?.group(3), '', reason: businessRule);
    expect(match?.group(4), 'div', reason: businessRule);
    expect(match?.group(5), ' class="TbwUpd" align=\'\'', reason: businessRule);

    match = regExp.firstMatch('text');
    expect(match?.group(1), 'text', reason: businessRule);

    match = regExp.firstMatch('<br>');
    expect(match?.group(4), 'br', reason: businessRule);

    match = regExp.firstMatch('<br/>');
    expect(match?.group(4), 'br', reason: businessRule);

    match = regExp.firstMatch('<br />');
    expect(match?.group(4), 'br', reason: businessRule);
    expect(match?.group(8), '/', reason: businessRule);

    match = regExp.firstMatch('<p>teste</p>');
    expect(match?.group(3), '', reason: businessRule);
    expect(match?.group(4), 'p', reason: businessRule);

    match = regExp.firstMatch('test</div>');
    expect(match?.group(1), 'test', reason: businessRule);
    expect(match?.group(3), '/', reason: businessRule);
    expect(match?.group(4), 'div', reason: businessRule);
  });

  testWidgets('HTML parser without stylish', (WidgetTester tester) async {

    businessRule = 'Empty tags and closed empty tags should return empty node';

    expect(JSXParser.parse(null), NodeText(''), reason: businessRule);
    expect(JSXParser.parse(''  ), NodeText(''), reason: businessRule);

    businessRule = 'Empty tags and closed empty tags should return empty node';

    NodeText childNode = NodeText('text');
    NodeElement parentNode = NodeElement('body');

    parentNode.nodes.add(childNode);
    childNode.parentNode = parentNode;

    expect(JSXParser.parse('text'), parentNode, reason: businessRule);

  });

}