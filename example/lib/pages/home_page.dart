import 'package:flutter/material.dart';
import 'package:flutter_jsx/flutter_jsx.dart';
import 'package:flutter_responsive/flutter_responsive.dart';
import 'package:flutter_responsive_example/layouts/sidebar.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePage createState() => _HomePage();
}

class _HomePage extends State<HomePage> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    /*create 12 columns*/
    List<Widget> responsiveGridExampe =

      /*repeat 12 times*/
      List<int>.generate(12, (index) => index).map((colIndex) =>
          ResponsiveCol(
              padding: EdgeInsets.all(10),
              backgroundColor: Colors.blue,
              gridSizes: {
                ScreenSize.xs : 4,
                ScreenSize.sm : 3,
                ScreenSize.lg : 2,
                ScreenSize.xl : 1,
              },
              children: [
                Text('Lorem ipsum dolor sit amet, consectetur adipiscing elit')
              ]
          )
      ).toList();

    ThemeData themeData = Theme.of(context);
    MediaQueryData mediaQueryData = MediaQuery.of(context);

    return Scaffold(
        appBar: AppBar(
          title: const Text('Home', overflow: TextOverflow.ellipsis),
        ),
        drawer: Sidebar(),
        body: Container( //background
          width: mediaQueryData.size.width,
          height: mediaQueryData.size.height,
          color: Color(0xFFCCCCCC),
          child: SingleChildScrollView(
            child: ResponsiveContainer(
              padding: EdgeInsets.symmetric(horizontal: 10),
              backgroundColor: Colors.white,
              maxWidth: ResponsiveScreen.limits[ScreenSize.lg],//mediaQuery.size.width * 0.95,
              children: <Widget>[
                ResponsiveRow(
                  margin: EdgeInsets.symmetric(vertical: 10),
                  children: <Widget>[

                    ResponsiveCol(
                        padding: EdgeInsets.all(10),
                        margin: EdgeInsets.only(bottom: 20),
                        backgroundColor: Colors.blueGrey,
                        children: [
                          Text('Flutter Responsive Layout', style: JSXTypography.h4.merge(TextStyle(color: Colors.white)))
                        ]
                    ),
                  ]
                ),
                ResponsiveRow(
                  margin: EdgeInsets.symmetric(vertical: 10),
                  children: <Widget>[

                    // By default, the column occupies the entire row, always
                    ResponsiveCol(
                      children: [
                        JSX(
                          '<div>'
                              '<h3>Responsive Layouts</h3>'
                              '<h6>for <i>Flutter</i></h6>'
                              '<br><br>'
                              '<p>Bellow there is an example of 12 columns, which changes the amount of each line depending of his father\'s widget size.</p>'
                          '</div>',
                          display: DisplayLine.block,
                          padding: EdgeInsets.only(bottom: 20),
                          stylesheet: {
                            'h3': JSXStylesheet(
                                textStyle: TextStyle(color: themeData.primaryColor),
                                displayLine: DisplayLine.block
                            ),
                            'h6': JSXStylesheet(
                                textStyle: TextStyle(color: themeData.primaryColor),
                                displayLine: DisplayLine.block
                            )
                          },
                          margin: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                        )
                      ]
                    )

                  ]..addAll(
                      responsiveGridExampe
                  )
                )
              ],
            )
          ),
        )
    );
  }
}
