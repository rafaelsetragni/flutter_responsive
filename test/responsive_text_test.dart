import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_responsive/src/typography/responsive_parser.dart';

void main() {

  String businessRule;

  void testRichTextTree(RichText firstText, RichText secondText, String businessRule, {level = 0}){

    void testInlineSpanTree(InlineSpan firstSpan, InlineSpan secondSpan, String businessRule, {level = 0}){

      expect(firstSpan?.runtimeType, secondSpan?.runtimeType, reason: 'level $level - InlineSpan types is different - $businessRule');

      if(firstSpan is WidgetSpan && secondSpan is WidgetSpan){

        expect(firstSpan.baseline, secondSpan.baseline, reason: 'level $level - baseline is different - $businessRule');
        expect(firstSpan.alignment, secondSpan.alignment, reason: 'level $level - alignment is different - $businessRule');
        expect(firstSpan.style, secondSpan.style, reason: 'level $level - style are different - $businessRule');

        expect(firstSpan.child?.runtimeType, secondSpan.child?.runtimeType, reason: 'level $level - widget child types is different - $businessRule');

        if(firstSpan.child is RichText && secondSpan.child is RichText){
          testRichTextTree(firstSpan.child, secondSpan.child, businessRule, level: ++level);
        }
      }
      else if(firstSpan is TextSpan && secondSpan is TextSpan){

        expect(firstSpan.text, secondSpan.text, reason: 'level $level - text is different - $businessRule');
        expect(firstSpan.style, secondSpan.style, reason: 'level $level - style are different - $businessRule');

        for(int pos = 0; pos < (firstSpan.children?.length ?? 0); pos++){
          testInlineSpanTree(firstSpan.children[pos], secondSpan.children[pos], businessRule, level: ++level);
        }

      }
    }

    expect(firstText.maxLines, firstText.maxLines, reason: 'level $level - maxLines number is different - $businessRule');
    expect(firstText.textAlign, firstText.textAlign, reason: 'level $level - base textAlign is different - $businessRule');

    testInlineSpanTree(firstText.text, secondText.text, businessRule, level: ++level);
  }

  testWidgets('HTML parser without stylish', (WidgetTester tester) async {

    ResponsiveParser parser = ResponsiveParser();

    businessRule = 'Empty text or null should return empty RichText object';
    RichText test = parser.parseJSX(html: null);
    testRichTextTree(test, RichText( text: TextSpan( text: '' ) ), businessRule);
    testRichTextTree(parser.parseJSX(html: ''  ), RichText( text: TextSpan( text: '' ) ), businessRule);

    businessRule = 'Empty tags and closed empty tags should return the same RichText object';

    RichText
      emptyTags = parser.parseJSX(
        html: '<icon></icon>',
        widgets: {
          'icon': Icon(Icons.check)
        },
      ),
      closedTags = parser.parseJSX(
        html: '<icon/>',
        widgets: {
          'icon': Icon(Icons.check)
        },
      );

    testRichTextTree(emptyTags, closedTags, businessRule);

  });

  testWidgets('RichText efficiency tests', (WidgetTester tester) async {
    ResponsiveParser parser = ResponsiveParser();

    businessRule = 'RichText should be the most efficient cost as possible';

    testRichTextTree(
        parser.parseJSX(
          html: '<icon></icon>',
          widgets: {
            'icon': Icon(Icons.check)
          },
        ),
        RichText(
          text: WidgetSpan(
              child: Icon(Icons.check)
          ),
        ),
        businessRule
    );

    testRichTextTree(
        parser.parseJSX(
          html: '<div><icon></icon> test</div>',
          widgets: {
            'icon': Icon(Icons.check)
          },
        ),
        RichText(
          text: TextSpan(
            style: TextStyle(inherit: true),
            children: [
              WidgetSpan( child: Icon(Icons.check) ),
              TextSpan(
                  text: ' test'
              )
            ]
          ),
        ),
        businessRule
    );

    testRichTextTree(
        parser.parseJSX(
          html: '<icon/>',
          widgets: {
            'icon': Icon(Icons.check)
          },
        ),
        RichText(
          text: WidgetSpan(
              child: Icon(Icons.check)
          ),
        ),
        businessRule
    );

  });

}