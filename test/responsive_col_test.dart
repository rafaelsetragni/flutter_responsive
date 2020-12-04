import 'package:flutter_responsive/src/responsive_enum.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_responsive/flutter_responsive.dart';

void main() {

  String businessRule;

  // Function to automate border limit tests
  bool testLimitSize( ScreenSize tagSize, double limit, bool expected1, bool expected2, bool expected3 ){

    return ResponsiveScreen.isScreenSize(tagSize, limit - 1) == expected1
        && ResponsiveScreen.isScreenSize(tagSize, limit + 0) == expected2
        && ResponsiveScreen.isScreenSize(tagSize, limit + 1) == expected3;
  }

  testWidgets('Ultra small grid tests', (WidgetTester tester) async {

    businessRule = 'Ultra small grid should be fractionated for every screen size';
    expect( testLimitSize( ScreenSize.us, ResponsiveScreen.limits[ScreenSize.us], true, true, true ), true, reason: businessRule);
    expect( testLimitSize( ScreenSize.us, ResponsiveScreen.limits[ScreenSize.xs], true, true, true ), true, reason: businessRule);
    expect( testLimitSize( ScreenSize.us, ResponsiveScreen.limits[ScreenSize.sm], true, true, true ), true, reason: businessRule);
    expect( testLimitSize( ScreenSize.us, ResponsiveScreen.limits[ScreenSize.md], true, true, true ), true, reason: businessRule);
    expect( testLimitSize( ScreenSize.us, ResponsiveScreen.limits[ScreenSize.lg], true, true, true ), true, reason: businessRule);
    expect( testLimitSize( ScreenSize.us, ResponsiveScreen.limits[ScreenSize.xl], true, true, true ), true, reason: businessRule);
    expect( testLimitSize( ScreenSize.us, ResponsiveScreen.limits[ScreenSize.ul], true, true, true ), true, reason: businessRule);

  });

  testWidgets('Extra small grid tests', (WidgetTester tester) async {

    businessRule = 'Extra small grid should be fractionated only for screens equal or greater than extra small limit. Otherwise should get full parent width.';
    expect( testLimitSize( ScreenSize.xs, ResponsiveScreen.limits[ScreenSize.us], false, false, false ), true, reason: businessRule);
    expect( testLimitSize( ScreenSize.xs, ResponsiveScreen.limits[ScreenSize.xs], false, true,  true  ), true, reason: businessRule);
    expect( testLimitSize( ScreenSize.xs, ResponsiveScreen.limits[ScreenSize.sm], true,  true,  true  ), true, reason: businessRule);
    expect( testLimitSize( ScreenSize.xs, ResponsiveScreen.limits[ScreenSize.md], true,  true,  true  ), true, reason: businessRule);
    expect( testLimitSize( ScreenSize.xs, ResponsiveScreen.limits[ScreenSize.lg], true,  true,  true  ), true, reason: businessRule);
    expect( testLimitSize( ScreenSize.xs, ResponsiveScreen.limits[ScreenSize.xl], true,  true,  true  ), true, reason: businessRule);
    expect( testLimitSize( ScreenSize.xs, ResponsiveScreen.limits[ScreenSize.ul], true,  true,  true  ), true, reason: businessRule);

  });

  testWidgets('Small grid tests', (WidgetTester tester) async {

    businessRule = 'Small grid should be fractionated only for screens equal or greater than small limit. Otherwise should get full parent width.';
    expect( testLimitSize( ScreenSize.sm, ResponsiveScreen.limits[ScreenSize.us], false, false, false ), true, reason: businessRule);
    expect( testLimitSize( ScreenSize.sm, ResponsiveScreen.limits[ScreenSize.xs], false, false, false ), true, reason: businessRule);
    expect( testLimitSize( ScreenSize.sm, ResponsiveScreen.limits[ScreenSize.sm], false, true,  true  ), true, reason: businessRule);
    expect( testLimitSize( ScreenSize.sm, ResponsiveScreen.limits[ScreenSize.md], true,  true,  true  ), true, reason: businessRule);
    expect( testLimitSize( ScreenSize.sm, ResponsiveScreen.limits[ScreenSize.lg], true,  true,  true  ), true, reason: businessRule);
    expect( testLimitSize( ScreenSize.sm, ResponsiveScreen.limits[ScreenSize.xl], true,  true,  true  ), true, reason: businessRule);
    expect( testLimitSize( ScreenSize.sm, ResponsiveScreen.limits[ScreenSize.ul], true,  true,  true  ), true, reason: businessRule);

  });

  testWidgets('Medium grid tests', (WidgetTester tester) async {

    businessRule = 'Medium grid should be fractionated only for screens equal or greater than medium limit. Otherwise should get full parent width.';
    expect( testLimitSize( ScreenSize.md, ResponsiveScreen.limits[ScreenSize.us], false, false, false ), true, reason: businessRule);
    expect( testLimitSize( ScreenSize.md, ResponsiveScreen.limits[ScreenSize.xs], false, false, false ), true, reason: businessRule);
    expect( testLimitSize( ScreenSize.md, ResponsiveScreen.limits[ScreenSize.sm], false, false, false ), true, reason: businessRule);
    expect( testLimitSize( ScreenSize.md, ResponsiveScreen.limits[ScreenSize.md], false, true,  true  ), true, reason: businessRule);
    expect( testLimitSize( ScreenSize.md, ResponsiveScreen.limits[ScreenSize.lg], true,  true,  true  ), true, reason: businessRule);
    expect( testLimitSize( ScreenSize.md, ResponsiveScreen.limits[ScreenSize.xl], true,  true,  true  ), true, reason: businessRule);
    expect( testLimitSize( ScreenSize.md, ResponsiveScreen.limits[ScreenSize.ul], true,  true,  true  ), true, reason: businessRule);

  });

  testWidgets('Large grid tests', (WidgetTester tester) async {

    businessRule = 'Large grid should be fractionated only for screens equal or greater than large limit. Otherwise should get full parent width.';
    expect( testLimitSize( ScreenSize.lg, ResponsiveScreen.limits[ScreenSize.us], false, false, false ), true, reason: businessRule);
    expect( testLimitSize( ScreenSize.lg, ResponsiveScreen.limits[ScreenSize.xs], false, false, false ), true, reason: businessRule);
    expect( testLimitSize( ScreenSize.lg, ResponsiveScreen.limits[ScreenSize.sm], false, false, false ), true, reason: businessRule);
    expect( testLimitSize( ScreenSize.lg, ResponsiveScreen.limits[ScreenSize.md], false, false, false ), true, reason: businessRule);
    expect( testLimitSize( ScreenSize.lg, ResponsiveScreen.limits[ScreenSize.lg], false, true,  true  ), true, reason: businessRule);
    expect( testLimitSize( ScreenSize.lg, ResponsiveScreen.limits[ScreenSize.xl], true,  true,  true  ), true, reason: businessRule);
    expect( testLimitSize( ScreenSize.lg, ResponsiveScreen.limits[ScreenSize.ul], true,  true,  true  ), true, reason: businessRule);

  });

  testWidgets('Extra large grid tests', (WidgetTester tester) async {

    businessRule = 'Extra large grid should be fractionated only for screens equal or greater than extra large limit. Otherwise should get full parent width.';
    expect( testLimitSize( ScreenSize.xl, ResponsiveScreen.limits[ScreenSize.us], false, false, false ), true, reason: businessRule);
    expect( testLimitSize( ScreenSize.xl, ResponsiveScreen.limits[ScreenSize.xs], false, false, false ), true, reason: businessRule);
    expect( testLimitSize( ScreenSize.xl, ResponsiveScreen.limits[ScreenSize.sm], false, false, false ), true, reason: businessRule);
    expect( testLimitSize( ScreenSize.xl, ResponsiveScreen.limits[ScreenSize.md], false, false, false ), true, reason: businessRule);
    expect( testLimitSize( ScreenSize.xl, ResponsiveScreen.limits[ScreenSize.lg], false, false, false ), true, reason: businessRule);
    expect( testLimitSize( ScreenSize.xl, ResponsiveScreen.limits[ScreenSize.xl], false, true,  true  ), true, reason: businessRule);
    expect( testLimitSize( ScreenSize.xl, ResponsiveScreen.limits[ScreenSize.ul], true,  true,  true  ), true, reason: businessRule);

  });

  testWidgets('Ultra large grid tests', (WidgetTester tester) async {

    businessRule = 'Ultra large grid should be fractionated only for screens equal or greater than extra large limit. Otherwise should get full parent width.';
    expect( testLimitSize( ScreenSize.ul, ResponsiveScreen.limits[ScreenSize.us], false, false, false ), true, reason: businessRule);
    expect( testLimitSize( ScreenSize.ul, ResponsiveScreen.limits[ScreenSize.xs], false, false, false ), true, reason: businessRule);
    expect( testLimitSize( ScreenSize.ul, ResponsiveScreen.limits[ScreenSize.sm], false, false, false ), true, reason: businessRule);
    expect( testLimitSize( ScreenSize.ul, ResponsiveScreen.limits[ScreenSize.md], false, false, false ), true, reason: businessRule);
    expect( testLimitSize( ScreenSize.ul, ResponsiveScreen.limits[ScreenSize.lg], false, false, false ), true, reason: businessRule);
    expect( testLimitSize( ScreenSize.ul, ResponsiveScreen.limits[ScreenSize.xl], false, false, false ), true, reason: businessRule);
    expect( testLimitSize( ScreenSize.ul, ResponsiveScreen.limits[ScreenSize.ul], false, true,  true  ), true, reason: businessRule);

  });

}
