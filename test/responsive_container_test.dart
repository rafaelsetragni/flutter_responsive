
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_responsive/flutter_responsive.dart';

void main() {

  String businessRule;
  ResponsiveContainer containerTest = ResponsiveContainer();

  testWidgets('Container behaviour for starndard spaces tests', (WidgetTester tester) async {

    businessRule = 'Container behaviour should be limited to 95% (2,5% for each offset side) if parent container is larger than small limit';

    double limit = ResponsiveScreen.limits['md'];

    expect( containerTest.getContainerSize( limit, limit * 0.5  ), limit * 0.5 , reason: businessRule );
    expect( containerTest.getContainerSize( limit, limit * 0.94 ), limit * 0.94, reason: businessRule );
    expect( containerTest.getContainerSize( limit, limit * 0.95 ), limit * 0.95, reason: businessRule );
    expect( containerTest.getContainerSize( limit, limit * 0.96 ), limit * 0.95, reason: businessRule );
    expect( containerTest.getContainerSize( limit, limit * 1    ), limit * 0.95, reason: businessRule );
    expect( containerTest.getContainerSize( limit, limit * 1.5  ), limit * 0.95, reason: businessRule );
    expect( containerTest.getContainerSize( limit, limit * 2.0  ), limit * 0.95, reason: businessRule );
    expect( containerTest.getContainerSize( limit, limit * 10.0 ), limit * 0.95, reason: businessRule );

  });

}
