import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_responsive/flutter_responsive.dart';

void main() {

  String businessRule;

  testWidgets('Text Style cascade tests', (WidgetTester tester) async {

    ResponsiveStylesheet originalStylesheet, newerStylesheet, cascadedStylesheet;

    businessRule = 'Newer Text Styles should merge, replacing older ones and fill thouse which wasn´t setted';

    originalStylesheet = ResponsiveStylesheet( textStyle: TextStyle(fontSize: 10.0, color: Colors.black, fontWeight: FontWeight.bold) );
    newerStylesheet    = ResponsiveStylesheet( textStyle: TextStyle(fontSize: 18.0, color: Colors.red, fontStyle: FontStyle.italic) );
    cascadedStylesheet = ResponsiveStylesheet.cascade(originalStylesheet, newerStylesheet);

    expect( cascadedStylesheet.textStyle.fontSize, 18.0, reason: businessRule );
    expect( cascadedStylesheet.textStyle.color, Colors.red, reason: businessRule );
    expect( cascadedStylesheet.textStyle.fontStyle, FontStyle.italic, reason: businessRule );
    expect( cascadedStylesheet.textStyle.fontWeight, FontWeight.bold, reason: businessRule );

  });

  testWidgets('Box properties cascate tests', (WidgetTester tester) async {

    ResponsiveStylesheet originalStylesheet, newerStylesheet, cascadedStylesheet;

    businessRule = 'Newer box decoration should not cascade to children ones';

    originalStylesheet = ResponsiveStylesheet( boxDecoration: BoxDecoration( shape: BoxShape.circle ) );
    newerStylesheet    = ResponsiveStylesheet( boxDecoration: BoxDecoration( shape: BoxShape.rectangle ) );
    cascadedStylesheet = ResponsiveStylesheet.cascade(originalStylesheet, newerStylesheet);

    expect( cascadedStylesheet.boxDecoration, null, reason: businessRule );

    businessRule = 'Box decoration should cascade only on horizontal tree direction';

    originalStylesheet = ResponsiveStylesheet( boxDecoration: BoxDecoration( shape: BoxShape.circle ) );
    newerStylesheet    = ResponsiveStylesheet( boxDecoration: BoxDecoration( shape: BoxShape.rectangle ) );
    cascadedStylesheet = ResponsiveStylesheet.cascade(originalStylesheet, newerStylesheet, mergeBoxProperties: true);

    expect( cascadedStylesheet.boxDecoration?.shape, BoxShape.rectangle, reason: businessRule );

  });

  testWidgets('Padding and margin cascade tests', (WidgetTester tester) async {

    ResponsiveStylesheet originalStylesheet, newerStylesheet, cascadedStylesheet;

    originalStylesheet = ResponsiveStylesheet( padding: EdgeInsets.all(10) );
    newerStylesheet    = ResponsiveStylesheet( padding: EdgeInsets.zero );

    businessRule = 'Padding and margin should not cascade to children ones';
    cascadedStylesheet = ResponsiveStylesheet.cascade(originalStylesheet, newerStylesheet);
    expect( cascadedStylesheet.padding, null, reason: businessRule );

    businessRule = 'Padding should merge, replacing older ones and fill thouse which was not setted only on horizontal tree';

    cascadedStylesheet = ResponsiveStylesheet.cascade(
        ResponsiveStylesheet(),
        ResponsiveStylesheet( padding: EdgeInsets.zero ),
        mergeBoxProperties: true
    );
    expect( cascadedStylesheet.padding, EdgeInsets.zero, reason: businessRule );

    cascadedStylesheet = ResponsiveStylesheet.cascade(
        ResponsiveStylesheet( padding: EdgeInsets.all(10) ),
        ResponsiveStylesheet(),
        mergeBoxProperties: true
    );
    expect( cascadedStylesheet.padding, EdgeInsets.all(10), reason: businessRule );

    cascadedStylesheet = ResponsiveStylesheet.cascade(
        ResponsiveStylesheet( padding: EdgeInsets.all(10) ),
        ResponsiveStylesheet( padding: EdgeInsets.zero ),
        mergeBoxProperties: true
    );
    expect( cascadedStylesheet.padding, EdgeInsets.zero, reason: businessRule );

    cascadedStylesheet = ResponsiveStylesheet.cascade(
        ResponsiveStylesheet( padding: EdgeInsets.zero ),
        ResponsiveStylesheet( padding: EdgeInsets.all(10) ),
        mergeBoxProperties: true
    );
    expect( cascadedStylesheet.padding, EdgeInsets.all(10), reason: businessRule );

    cascadedStylesheet = ResponsiveStylesheet.cascade(
        ResponsiveStylesheet( padding: EdgeInsets.symmetric(horizontal: 10) ),
        ResponsiveStylesheet( padding: EdgeInsets.symmetric(vertical: 10) ),
        mergeBoxProperties: true
    );
    expect( cascadedStylesheet.padding, EdgeInsets.symmetric(vertical: 10), reason: businessRule );

    businessRule = 'Margin should merge, replacing older ones and fill thouse which was not setted only on horizontal tree';

    cascadedStylesheet = ResponsiveStylesheet.cascade(
        ResponsiveStylesheet(),
        ResponsiveStylesheet( margin: EdgeInsets.zero ),
        mergeBoxProperties: true
    );
    expect( cascadedStylesheet.margin, EdgeInsets.zero, reason: businessRule );

    cascadedStylesheet = ResponsiveStylesheet.cascade(
        ResponsiveStylesheet( margin: EdgeInsets.all(10) ),
        ResponsiveStylesheet(),
        mergeBoxProperties: true
    );
    expect( cascadedStylesheet.margin, EdgeInsets.all(10), reason: businessRule );

    cascadedStylesheet = ResponsiveStylesheet.cascade(
        ResponsiveStylesheet( margin: EdgeInsets.all(10) ),
        ResponsiveStylesheet( margin: EdgeInsets.zero ),
        mergeBoxProperties: true
    );
    expect( cascadedStylesheet.margin, EdgeInsets.zero, reason: businessRule );

    cascadedStylesheet = ResponsiveStylesheet.cascade(
        ResponsiveStylesheet( margin: EdgeInsets.zero ),
        ResponsiveStylesheet( margin: EdgeInsets.all(10) ),
        mergeBoxProperties: true
    );
    expect( cascadedStylesheet.margin, EdgeInsets.all(10), reason: businessRule );

    cascadedStylesheet = ResponsiveStylesheet.cascade(
        ResponsiveStylesheet( margin: EdgeInsets.symmetric(horizontal: 10) ),
        ResponsiveStylesheet( margin: EdgeInsets.symmetric(vertical: 10) ),
        mergeBoxProperties: true
    );
    expect( cascadedStylesheet.margin, EdgeInsets.symmetric(vertical: 10), reason: businessRule );

  });
}
