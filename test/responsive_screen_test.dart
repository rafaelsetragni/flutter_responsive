
import 'package:flutter_responsive/src/responsive_enum.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_responsive/flutter_responsive.dart';

void main() {

  // Function to automate border limit tests
  bool testLimitTag( Function testFunction, double limit, ScreenSize expected1, ScreenSize expected2, ScreenSize expected3 ){
    return (testFunction(limit - 1.0) == expected1)
        && (testFunction(limit + 0.0) == expected2)
        && (testFunction(limit + 1.0) == expected3);
  }

  testWidgets('Tests for check flexible limits', (WidgetTester tester) async {
    String businessRule;

    ResponsiveScreen.limits = {
      ScreenSize.us: 0.00,
      // smart watches
      ScreenSize.xs: 310.00,
      // small phones (5S)
      ScreenSize.sm: 576.00,
      // medium phones
      ScreenSize.md: 768.00,
      // large phones
      ScreenSize.lg: 992.00,
      // tablets
      ScreenSize.xl: 1200.00,
      // laptops
      ScreenSize.ul: 1900.00,
      // desktops and TVs 4K
    };

    businessRule = 'Ultra small validation should return US';
    expect( testLimitTag( ResponsiveScreen.getReferenceSize, ResponsiveScreen.limits[ScreenSize.us], ScreenSize.us, ScreenSize.us, ScreenSize.us ), true, reason: businessRule );
    businessRule = 'Extra small validation should return XS';
    expect( testLimitTag( ResponsiveScreen.getReferenceSize, ResponsiveScreen.limits[ScreenSize.xs], ScreenSize.us, ScreenSize.xs, ScreenSize.xs ), true, reason: businessRule );
    businessRule = 'Small validation should return SM';
    expect( testLimitTag( ResponsiveScreen.getReferenceSize, ResponsiveScreen.limits[ScreenSize.sm], ScreenSize.xs, ScreenSize.sm, ScreenSize.sm ), true, reason: businessRule );
    businessRule = 'Medium validation should return MD';
    expect( testLimitTag( ResponsiveScreen.getReferenceSize, ResponsiveScreen.limits[ScreenSize.md], ScreenSize.sm, ScreenSize.md, ScreenSize.md ), true, reason: businessRule );
    businessRule = 'Large validation should return LG';
    expect( testLimitTag( ResponsiveScreen.getReferenceSize, ResponsiveScreen.limits[ScreenSize.lg], ScreenSize.md, ScreenSize.lg, ScreenSize.lg ), true, reason: businessRule );
    businessRule = 'Extra large validation should return XL';
    expect( testLimitTag( ResponsiveScreen.getReferenceSize, ResponsiveScreen.limits[ScreenSize.xl], ScreenSize.lg, ScreenSize.xl, ScreenSize.xl ), true, reason: businessRule );
    businessRule = 'Ultra large validation should return UL';
    expect( testLimitTag( ResponsiveScreen.getReferenceSize, ResponsiveScreen.limits[ScreenSize.ul], ScreenSize.xl, ScreenSize.ul, ScreenSize.ul ), true, reason: businessRule );
    businessRule = 'Largest than ultra large validation should return UL';
    expect( testLimitTag( ResponsiveScreen.getReferenceSize, 999999,                       ScreenSize.ul, ScreenSize.ul, ScreenSize.ul ), true, reason: businessRule );

  });

}
