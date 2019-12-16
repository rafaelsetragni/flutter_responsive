
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_responsive/flutter_responsive.dart';

void main() {

  String reason;

  // Function to automate border limit tests
  bool testLimitSize( String tagSize, double limit, bool expected1, bool expected2, bool expected3 ){

    return ResponsiveScreen.isScreenSize(tagSize, limit - 1) == expected1
        && ResponsiveScreen.isScreenSize(tagSize, limit + 0) == expected2
        && ResponsiveScreen.isScreenSize(tagSize, limit + 1) == expected3;
  }

  testWidgets('Ultra small grid tests', (WidgetTester tester) async {

    reason = 'Ultra small grid should be fractionated for every screen size';
    expect( testLimitSize( 'us', ResponsiveScreen.limits['us'], false, true, true ), true, reason: reason);
    expect( testLimitSize( 'us', ResponsiveScreen.limits['xs'], true,  true, true ), true, reason: reason);
    expect( testLimitSize( 'us', ResponsiveScreen.limits['sm'], true,  true, true ), true, reason: reason);
    expect( testLimitSize( 'us', ResponsiveScreen.limits['md'], true,  true, true ), true, reason: reason);
    expect( testLimitSize( 'us', ResponsiveScreen.limits['lg'], true,  true, true ), true, reason: reason);
    expect( testLimitSize( 'us', ResponsiveScreen.limits['xl'], true,  true, true ), true, reason: reason);
    expect( testLimitSize( 'us', ResponsiveScreen.limits['ul'], true,  true, true ), true, reason: reason);

  });

  testWidgets('Extra small grid tests', (WidgetTester tester) async {

    reason = 'Extra small grid should be fractionated only for screens equal or greater than extra small limit. Otherwise should get full parent width.';
    expect( testLimitSize( 'xs', ResponsiveScreen.limits['us'], false, false, false ), true, reason: reason);
    expect( testLimitSize( 'xs', ResponsiveScreen.limits['xs'], false, true,  true  ), true, reason: reason);
    expect( testLimitSize( 'xs', ResponsiveScreen.limits['sm'], true,  true,  true  ), true, reason: reason);
    expect( testLimitSize( 'xs', ResponsiveScreen.limits['md'], true,  true,  true  ), true, reason: reason);
    expect( testLimitSize( 'xs', ResponsiveScreen.limits['lg'], true,  true,  true  ), true, reason: reason);
    expect( testLimitSize( 'xs', ResponsiveScreen.limits['xl'], true,  true,  true  ), true, reason: reason);
    expect( testLimitSize( 'xs', ResponsiveScreen.limits['ul'], true,  true,  true  ), true, reason: reason);

  });

  testWidgets('Small grid tests', (WidgetTester tester) async {

    reason = 'Small grid should be fractionated only for screens equal or greater than small limit. Otherwise should get full parent width.';
    expect( testLimitSize( 'sm', ResponsiveScreen.limits['us'], false, false, false ), true, reason: reason);
    expect( testLimitSize( 'sm', ResponsiveScreen.limits['xs'], false, false, false ), true, reason: reason);
    expect( testLimitSize( 'sm', ResponsiveScreen.limits['sm'], false, true,  true  ), true, reason: reason);
    expect( testLimitSize( 'sm', ResponsiveScreen.limits['md'], true,  true,  true  ), true, reason: reason);
    expect( testLimitSize( 'sm', ResponsiveScreen.limits['lg'], true,  true,  true  ), true, reason: reason);
    expect( testLimitSize( 'sm', ResponsiveScreen.limits['xl'], true,  true,  true  ), true, reason: reason);
    expect( testLimitSize( 'sm', ResponsiveScreen.limits['ul'], true,  true,  true  ), true, reason: reason);

  });

  testWidgets('Medium grid tests', (WidgetTester tester) async {

    reason = 'Medium grid should be fractionated only for screens equal or greater than medium limit. Otherwise should get full parent width.';
    expect( testLimitSize( 'md', ResponsiveScreen.limits['us'], false, false, false ), true, reason: reason);
    expect( testLimitSize( 'md', ResponsiveScreen.limits['xs'], false, false, false ), true, reason: reason);
    expect( testLimitSize( 'md', ResponsiveScreen.limits['sm'], false, false, false ), true, reason: reason);
    expect( testLimitSize( 'md', ResponsiveScreen.limits['md'], false, true,  true  ), true, reason: reason);
    expect( testLimitSize( 'md', ResponsiveScreen.limits['lg'], true,  true,  true  ), true, reason: reason);
    expect( testLimitSize( 'md', ResponsiveScreen.limits['xl'], true,  true,  true  ), true, reason: reason);
    expect( testLimitSize( 'md', ResponsiveScreen.limits['ul'], true,  true,  true  ), true, reason: reason);

  });

  testWidgets('Large grid tests', (WidgetTester tester) async {

    reason = 'Large grid should be fractionated only for screens equal or greater than large limit. Otherwise should get full parent width.';
    expect( testLimitSize( 'lg', ResponsiveScreen.limits['us'], false, false, false ), true, reason: reason);
    expect( testLimitSize( 'lg', ResponsiveScreen.limits['xs'], false, false, false ), true, reason: reason);
    expect( testLimitSize( 'lg', ResponsiveScreen.limits['sm'], false, false, false ), true, reason: reason);
    expect( testLimitSize( 'lg', ResponsiveScreen.limits['md'], false, false, false ), true, reason: reason);
    expect( testLimitSize( 'lg', ResponsiveScreen.limits['lg'], false, true,  true  ), true, reason: reason);
    expect( testLimitSize( 'lg', ResponsiveScreen.limits['xl'], true,  true,  true  ), true, reason: reason);
    expect( testLimitSize( 'lg', ResponsiveScreen.limits['ul'], true,  true,  true  ), true, reason: reason);

  });

  testWidgets('Extra large grid tests', (WidgetTester tester) async {

    reason = 'Extra large grid should be fractionated only for screens equal or greater than extra large limit. Otherwise should get full parent width.';
    expect( testLimitSize( 'xl', ResponsiveScreen.limits['us'], false, false, false ), true, reason: reason);
    expect( testLimitSize( 'xl', ResponsiveScreen.limits['xs'], false, false, false ), true, reason: reason);
    expect( testLimitSize( 'xl', ResponsiveScreen.limits['sm'], false, false, false ), true, reason: reason);
    expect( testLimitSize( 'xl', ResponsiveScreen.limits['md'], false, false, false ), true, reason: reason);
    expect( testLimitSize( 'xl', ResponsiveScreen.limits['lg'], false, false, false ), true, reason: reason);
    expect( testLimitSize( 'xl', ResponsiveScreen.limits['xl'], false, true,  true  ), true, reason: reason);
    expect( testLimitSize( 'xl', ResponsiveScreen.limits['ul'], true,  true,  true  ), true, reason: reason);

  });

  testWidgets('Ultra large grid tests', (WidgetTester tester) async {

    reason = 'Ultra large grid should be fractionated only for screens equal or greater than extra large limit. Otherwise should get full parent width.';
    expect( testLimitSize( 'ul', ResponsiveScreen.limits['us'], false, false, false ), true, reason: reason);
    expect( testLimitSize( 'ul', ResponsiveScreen.limits['xs'], false, false, false ), true, reason: reason);
    expect( testLimitSize( 'ul', ResponsiveScreen.limits['sm'], false, false, false ), true, reason: reason);
    expect( testLimitSize( 'ul', ResponsiveScreen.limits['md'], false, false, false ), true, reason: reason);
    expect( testLimitSize( 'ul', ResponsiveScreen.limits['lg'], false, false, false ), true, reason: reason);
    expect( testLimitSize( 'ul', ResponsiveScreen.limits['xl'], false, false, false ), true, reason: reason);
    expect( testLimitSize( 'ul', ResponsiveScreen.limits['ul'], false, true,  true  ), true, reason: reason);

  });

}
