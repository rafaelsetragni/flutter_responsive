import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_responsive/src/parser/jsx_parser.dart';
import 'package:flutter_responsive/src/parser/jsx_node.dart';
import 'package:flutter_responsive/src/parser/jsx_node_text.dart';
import 'package:flutter_responsive/src/parser/jsx_node_element.dart';

void main() {

  String businessRule;

  testWidgets('Regex parser test', (WidgetTester tester) async {

    RegExpMatch match;
    List<String> parameters;
    String beforeText, tagName, attributes, closingTag, selfEnclosing;


    match = JSXParser.regExpHtml.firstMatch('pre-text\\<a\\\\\\\\\\\\\\\\\\\<aaa<div class="TbwUpd" align=\'\'><cite class="iUh30 bc"><i/>https://github.com › dart-lang › html › blob › master › lib › parser</cite></div>');

    businessRule = 'Regex parser do not work as expected';
    parameters = JSXParser.getParseParameters(match);

    beforeText = parameters[0];
    closingTag = parameters[1];
    tagName    = parameters[2];
    attributes = parameters[3];
    selfEnclosing = parameters[4];

    expect(beforeText,    'pre-text\\<a\\\\\\\\\\\\\\\\\\\<aaa', reason: businessRule);
    expect(selfEnclosing, '', reason: businessRule);
    expect(closingTag,    '', reason: businessRule);
    expect(tagName,       'div', reason: businessRule);
    expect(attributes,    ' class="TbwUpd" align=\'\'', reason: businessRule);

    match = JSXParser.regExpHtml.firstMatch('text');
    parameters = JSXParser.getParseParameters(match);

    beforeText = parameters[0];
    closingTag = parameters[1];
    tagName    = parameters[2];
    attributes = parameters[3];
    selfEnclosing = parameters[4];

    expect(beforeText, 'text', reason: businessRule);

    match = JSXParser.regExpHtml.firstMatch('<br>');
    parameters = JSXParser.getParseParameters(match);

    beforeText = parameters[0];
    closingTag = parameters[1];
    tagName    = parameters[2];
    attributes = parameters[3];
    selfEnclosing = parameters[4];
    expect(tagName, 'br', reason: businessRule);

    match = JSXParser.regExpHtml.firstMatch('<br/>');
    parameters = JSXParser.getParseParameters(match);

    beforeText = parameters[0];
    closingTag = parameters[1];
    tagName    = parameters[2];
    attributes = parameters[3];
    selfEnclosing = parameters[4];
    expect(tagName, 'br', reason: businessRule);

    match = JSXParser.regExpHtml.firstMatch('<br />');
    parameters = JSXParser.getParseParameters(match);

    beforeText = parameters[0];
    closingTag = parameters[1];
    tagName    = parameters[2];
    attributes = parameters[3];
    selfEnclosing = parameters[4];
    expect(tagName, 'br', reason: businessRule);
    expect(selfEnclosing, '/', reason: businessRule);

    match = JSXParser.regExpHtml.firstMatch('<p>teste</p>');
    parameters = JSXParser.getParseParameters(match);

    beforeText = parameters[0];
    closingTag = parameters[1];
    tagName    = parameters[2];
    attributes = parameters[3];
    selfEnclosing = parameters[4];
    expect(closingTag, '', reason: businessRule);
    expect(tagName, 'p', reason: businessRule);

    match = JSXParser.regExpHtml.firstMatch('test</div>');
    parameters = JSXParser.getParseParameters(match);

    beforeText = parameters[0];
    closingTag = parameters[1];
    tagName    = parameters[2];
    attributes = parameters[3];
    selfEnclosing = parameters[4];
    expect(beforeText, 'test', reason: businessRule);
    expect(closingTag, '/', reason: businessRule);
    expect(tagName, 'div', reason: businessRule);

  });

  testWidgets('Empty HTML parser', (WidgetTester tester) async {

    businessRule = 'Empty tags and closed empty tags should return empty node';

    JSXNode test = JSXNodeElement('body', nodes:[ JSXNodeText('') ]);
    expect(JSXParser.parse(null), null, reason: businessRule);
    expect(JSXParser.parse(''  ), test, reason: businessRule);
  });

  testWidgets('HTML parser without stylish', (WidgetTester tester) async {

    businessRule = 'Empty tags and closed empty tags should return empty node';

    expect(JSXParser.parse('text'), JSXNodeElement('body', nodes:[ JSXNodeText('text') ]), reason: businessRule);

    expect(JSXParser.parse('<p>text</p>'), JSXNodeElement('body', nodes:[ JSXNodeElement('p', nodes: [JSXNodeText('text')]) ]), reason: businessRule);

    expect(JSXParser.parse('text1<p>text2</p>'), JSXNodeElement('body', nodes:[ JSXNodeText('text1'), JSXNodeElement('p', nodes: [JSXNodeText('text2')]) ]), reason: businessRule);

    expect(JSXParser.parse('text1<p>text2</p>text3'), JSXNodeElement('body', nodes:[ JSXNodeText('text1'), JSXNodeElement('p', nodes: [JSXNodeText('text2')]), JSXNodeText('text3') ]), reason: businessRule);

  });

  testWidgets('HTML self contained elements', (WidgetTester tester) async {

    JSXNode example;
    businessRule = 'Self containing tags shoud ignore closed';

    example = JSXNodeElement('body', nodes:[ JSXNodeText('text1'), JSXNodeElement('br'), JSXNodeText('text2') ]);
    expect(JSXParser.parse('text1<br>text2'),  example, reason: businessRule);
    expect(JSXParser.parse('text1<br/>text2'), example, reason: businessRule);

    example =  JSXNodeElement('body', nodes:[ JSXNodeText('text1'), JSXNodeElement('widget'), JSXNodeText('text2') ]);
    expect(JSXParser.parse('text1<widget></widget>text2'), example, reason: businessRule);
    expect(JSXParser.parse('text1<widget/>text2')        , example, reason: businessRule);

    example =  JSXNodeElement('body', nodes:[ JSXNodeElement('widget') ]);
    expect(JSXParser.parse('<widget></widget>'), example, reason: businessRule);
    expect(JSXParser.parse('<widget/>')        , example, reason: businessRule);

    example =  JSXNodeElement('body', nodes:[ JSXNodeElement('p', nodes: [JSXNodeElement('widget')]) ]);
    expect(JSXParser.parse('<p><widget></widget></p>'), example, reason: businessRule);
    expect(JSXParser.parse('<p><widget/></p>')        , example, reason: businessRule);

    example =  JSXNodeElement('body', nodes:[ JSXNodeElement('p', nodes: [JSXNodeElement('p', nodes: [JSXNodeElement('widget')])]) ]);
    expect(JSXParser.parse('<p><p><widget></widget></p></p>'), example, reason: businessRule);
    expect(JSXParser.parse('<p><p><widget/></p></p>')        , example, reason: businessRule);
  });

}