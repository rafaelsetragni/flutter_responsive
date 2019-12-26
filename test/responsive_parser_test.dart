import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_responsive/src/parser/jsx_parser.dart';
import 'package:flutter_responsive/src/parser/jsx_node.dart';
import 'package:flutter_responsive/src/parser/jsx_node_text.dart';
import 'package:flutter_responsive/src/parser/jsx_node_element.dart';

void main() {

  String businessRule;

  testWidgets('Extract html elements test', (WidgetTester tester) async {

    String testText;
    List<String> matches;

    businessRule = 'Regex parser to identify html elements do not work as expected';

    testText = 'Aenean laci\\<nia bibendum <a test href=\'/l<>ife\'>life</a> sed consectetur. <a href="/work">Work</a> quis risus eget urna mollis<></> ornare <w/> <a href="/about">about</a> leo.';
    matches = JSXParser.getFirstHtmlElements(testText);

    expect(matches[0], 'Aenean laci\\<nia bibendum <a test href=\'/l<>ife\'>', reason: businessRule);
    expect(matches[1], 'Aenean laci\\<nia bibendum ', reason: businessRule);
    expect(matches[2], '<', reason: businessRule);
    expect(matches[3], '', reason: businessRule);
    expect(matches[4], 'a', reason: businessRule);
    expect(matches[5], ' test href=\'/l<>ife\'', reason: businessRule);
    expect(matches[6], '', reason: businessRule);

    testText = 'life</a> sed consectetur. <a href="/work">Work</a> quis risus eget urna mollis<></> ornare <w/> <a href="/about">about</a> leo.';
    matches = JSXParser.getFirstHtmlElements(testText);

    expect(matches[0], 'life</a>', reason: businessRule);
    expect(matches[1], 'life', reason: businessRule);
    expect(matches[2], '<', reason: businessRule);
    expect(matches[3], '/', reason: businessRule);
    expect(matches[4], 'a', reason: businessRule);
    expect(matches[5], '', reason: businessRule);
    expect(matches[6], '', reason: businessRule);

    testText = ' sed consectetur. <a href="/work">Work</a> quis risus eget urna mollis<></> ornare <w/> <a href="/about">about</a> leo.';
    matches = JSXParser.getFirstHtmlElements(testText);

    expect(matches[0], ' sed consectetur. <a href="/work">', reason: businessRule);
    expect(matches[1], ' sed consectetur. ', reason: businessRule);
    expect(matches[2], '<', reason: businessRule);
    expect(matches[3], '', reason: businessRule);
    expect(matches[4], 'a', reason: businessRule);
    expect(matches[5], ' href="/work"', reason: businessRule);
    expect(matches[6], '', reason: businessRule);

    testText = 'Work</a> quis risus eget urna mollis<></> ornare <w/> <a href="/about">about</a> leo.';
    matches = JSXParser.getFirstHtmlElements(testText);

    expect(matches[0], 'Work</a>', reason: businessRule);
    expect(matches[1], 'Work', reason: businessRule);
    expect(matches[2], '<', reason: businessRule);
    expect(matches[3], '/', reason: businessRule);
    expect(matches[4], 'a', reason: businessRule);
    expect(matches[5], '', reason: businessRule);
    expect(matches[6], '', reason: businessRule);

    testText = ' quis risus eget urna mollis<></> ornare <w/> <a href="/about">about</a> leo.';
    matches = JSXParser.getFirstHtmlElements(testText);

    expect(matches[0], ' quis risus eget urna mollis<>', reason: businessRule);
    expect(matches[1], ' quis risus eget urna mollis', reason: businessRule);
    expect(matches[2], '<', reason: businessRule);
    expect(matches[3], '', reason: businessRule);
    expect(matches[4], '', reason: businessRule);
    expect(matches[5], '', reason: businessRule);
    expect(matches[6], '', reason: businessRule);

    testText = '</> ornare <w/> <a href="/about">about</a> leo.';
    matches = JSXParser.getFirstHtmlElements(testText);

    expect(matches[0], '</>', reason: businessRule);
    expect(matches[1], '', reason: businessRule);
    expect(matches[2], '<', reason: businessRule);
    expect(matches[3], '/', reason: businessRule);
    expect(matches[4], '', reason: businessRule);
    expect(matches[5], '', reason: businessRule);
    expect(matches[6], '', reason: businessRule);

    testText = ' ornare <w/> <a href="/about">about</a> leo.';
    matches = JSXParser.getFirstHtmlElements(testText);

    expect(matches[0], ' ornare <w/>', reason: businessRule);
    expect(matches[1], ' ornare ', reason: businessRule);
    expect(matches[2], '<', reason: businessRule);
    expect(matches[3], '', reason: businessRule);
    expect(matches[4], 'w', reason: businessRule);
    expect(matches[5], '', reason: businessRule);
    expect(matches[6], '/', reason: businessRule);

    testText = ' <a href="/about">about</a> leo.';
    matches = JSXParser.getFirstHtmlElements(testText);

    expect(matches[0], ' <a href="/about">', reason: businessRule);
    expect(matches[1], ' ', reason: businessRule);
    expect(matches[2], '<', reason: businessRule);
    expect(matches[3], '', reason: businessRule);
    expect(matches[4], 'a', reason: businessRule);
    expect(matches[5], ' href="/about"', reason: businessRule);
    expect(matches[6], '', reason: businessRule);

    testText = 'about</a> leo.';
    matches = JSXParser.getFirstHtmlElements(testText);

    expect(matches[0], 'about</a>', reason: businessRule);
    expect(matches[1], 'about', reason: businessRule);
    expect(matches[2], '<', reason: businessRule);
    expect(matches[3], '/', reason: businessRule);
    expect(matches[4], 'a', reason: businessRule);
    expect(matches[5], '', reason: businessRule);
    expect(matches[6], '', reason: businessRule);

    testText = ' leo.';
    matches = JSXParser.getFirstHtmlElements(testText);

    expect(matches[0], ' leo.', reason: businessRule);
    expect(matches[1], ' leo.', reason: businessRule);
    expect(matches[2], '', reason: businessRule);
    expect(matches[3], '', reason: businessRule);
    expect(matches[4], '', reason: businessRule);
    expect(matches[5], '', reason: businessRule);
    expect(matches[6], '', reason: businessRule);

    businessRule = 'Bad formated html are handle ok until error';

    testText = 'Aenean laci<nia bibendum <a test href=\'/l<>ife\'>';
    matches = JSXParser.getFirstHtmlElements(testText);

    expect(matches[0], 'Aenean laci', reason: businessRule);
    expect(matches[1], 'Aenean laci', reason: businessRule);
    expect(matches[2], '', reason: businessRule);
    expect(matches[3], '', reason: businessRule);
    expect(matches[4], '', reason: businessRule);
    expect(matches[5], '', reason: businessRule);
    expect(matches[6], '', reason: businessRule);

    businessRule = 'Entire bad formated html return all empty';

    testText = '<nia bibendum <a test href=\'/l<>ife\'>';
    matches = JSXParser.getFirstHtmlElements(testText);

    expect(matches[0], '', reason: businessRule);
    expect(matches[1], '', reason: businessRule);
    expect(matches[2], '', reason: businessRule);
    expect(matches[3], '', reason: businessRule);
    expect(matches[4], '', reason: businessRule);
    expect(matches[5], '', reason: businessRule);
    expect(matches[6], '', reason: businessRule);

    businessRule = 'Empty html should return all empty';

    testText = '';
    matches = JSXParser.getFirstHtmlElements(testText);

    expect(matches[0], '', reason: businessRule);
    expect(matches[1], '', reason: businessRule);
    expect(matches[2], '', reason: businessRule);
    expect(matches[3], '', reason: businessRule);
    expect(matches[4], '', reason: businessRule);
    expect(matches[5], '', reason: businessRule);
    expect(matches[6], '', reason: businessRule);

    businessRule = 'null html should return null and do not return same as empty';

    testText = null;
    matches = JSXParser.getFirstHtmlElements(testText);

    expect(matches, null, reason: businessRule);
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
    expect(JSXParser.parse('text1<br />text2'), example, reason: businessRule);

    example = JSXNodeElement('body', nodes:[ JSXNodeElement('p', nodes:[ JSXNodeText('text1'), JSXNodeElement('br'), JSXNodeText('text2') ]) ]);
    expect(JSXParser.parse('<p>text1<br>text2</p>'),  example, reason: businessRule);
    expect(JSXParser.parse('<p>text1<br/>text2</p>'), example, reason: businessRule);
    expect(JSXParser.parse('<p>text1<br />text2</p>'), example, reason: businessRule);

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

    example =  JSXNodeElement('body', nodes:[ JSXNodeElement('p', nodes: [JSXNodeElement('p', nodes: [JSXNodeElement('widget')])]) ]);
  });

  testWidgets('Invalid HTML elements', (WidgetTester tester) async {

    JSXNode example;
    businessRule = 'Hole invalid HTML should return empty body';

    example =  JSXNodeElement('body');
    expect(JSXParser.parse('<p></a>'), example, reason: businessRule);
    expect(JSXParser.parse('<p><widget></widget></a>'), example, reason: businessRule);

    businessRule = 'Invalid HTML trees should not be returned, only valid ones';
    example =  JSXNodeElement('body', nodes:[ JSXNodeElement('p', nodes: []) ]);
    expect(JSXParser.parse('<p><p><widget></widget></a></p>'), example, reason: businessRule);
  });

  testWidgets('Attributes test', (WidgetTester tester) async {

    JSXNode example1, example2;

    businessRule = 'Attributes extraction to node elements';
    example1 =  JSXNodeElement('a', attributes: { 'href': '/test' });
    expect(JSXParser.extractParameters(JSXNodeElement('a'), ' href="/test"'), example1, reason: businessRule);

    businessRule = 'Parser jsx with attributes';
    example2 =  JSXNodeElement('body', nodes:[ example1 ]);
    expect(JSXParser.parse('<a href="/test"></a>'), example2, reason: businessRule);

    businessRule = 'Attributes extraction to node elements with scape key';
    example1 =  JSXNodeElement('a', attributes: { 'href': '"test', 'attr': '\'test' });
    expect(JSXParser.extractParameters(JSXNodeElement('a'), ' href="\\"test" attr=\'\\\'test\''), example1, reason: businessRule);

    businessRule = 'Parser jsx with attributes with scape key';
    example2 =  JSXNodeElement('body', nodes:[ JSXNodeElement('a', attributes: { 'href': '/"test', 'attr': '\'test' }) ]);
    expect(JSXParser.parse('<a href="/\\"test" attr=\'\\\'test\'></a>'), example2, reason: businessRule);

  });

}