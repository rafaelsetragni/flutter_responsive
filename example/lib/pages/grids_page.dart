import 'package:flutter/material.dart';
import 'package:flutter_jsx/flutter_jsx.dart';
import 'package:flutter_responsive/flutter_responsive.dart';
import 'package:flutter_responsive_example/layouts/sidebar.dart';

class GridPage extends StatefulWidget {
  @override
  _GridPage createState() => _GridPage();
}

class _GridPage extends State<GridPage> {

  List<Widget> _aLotOfText = [
      Text('Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim'
          ' veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate'
          ' velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit '
          'anim id est laborum.')
    ],
    _smallText = [
      Text('Lorem ipsum dolor sit amet, consectetur adipiscing elit')
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    MediaQueryData mediaQuery = MediaQuery.of(context);
    double screenSize = mediaQuery.size.width;

    return Scaffold(
        appBar: AppBar(
          title: const Text('Grid Examples', overflow: TextOverflow.ellipsis),
        ),
        drawer: Sidebar(),
        body: ListView(
          children: <Widget>[
            ResponsiveContainer(

              // Determines the container's limit size
              maxWidth: ResponsiveScreen.limits[ScreenSize.lg],

              margin: EdgeInsets.symmetric(horizontal: 10),

              children: <Widget>[

                ResponsiveRow(
                    margin: EdgeInsets.symmetric(vertical: 10),
                    children: <Widget>[

                      ResponsiveCol(
                          padding: EdgeInsets.all(10),
                          margin: EdgeInsets.only(bottom: 20),
                          backgroundColor: Colors.blueGrey,
                          children: [
                            Text('Actual Screen Size: '+mediaQuery.size.width.toString()+'px', style: JSXTypography.h4)
                          ]
                      ),
                      ResponsiveCol(
                          padding: EdgeInsets.all(10),
                          gridSizes: {
                            ScreenSize.xs: 12
                          },
                          backgroundColor: ResponsiveScreen.isScreenSize(ScreenSize.us, screenSize) ? Colors.green : Colors.red,
                          children: [
                            Text('Is Ultra Small Screen:\n('+ResponsiveScreen.limits[ScreenSize.us].toString()+'px)', style: JSXTypography.h4),
                            Text( ResponsiveScreen.isScreenSize(ScreenSize.us, screenSize) ? 'true' : 'false')
                          ]
                      ),
                      ResponsiveCol(
                          padding: EdgeInsets.all(10),
                          gridSizes: {
                            ScreenSize.xs: 12
                          },
                          backgroundColor: ResponsiveScreen.isScreenSize(ScreenSize.xs, screenSize) ? Colors.green : Colors.red,
                          children: [
                            Text('Is Extra Small Screen:\n('+ResponsiveScreen.limits[ScreenSize.xs].toString()+'px)', style: JSXTypography.h4),
                            Text( ResponsiveScreen.isScreenSize(ScreenSize.xs, screenSize) ? 'true' : 'false')
                          ]
                      ),
                      ResponsiveCol(
                          padding: EdgeInsets.all(10),
                          backgroundColor: ResponsiveScreen.isScreenSize(ScreenSize.sm, screenSize) ? Colors.green : Colors.red,
                          gridSizes: {
                            ScreenSize.xs: 12
                          },
                          children: [
                            Text('Is Small Screen:\n('+ResponsiveScreen.limits[ScreenSize.sm].toString()+'px)', style: JSXTypography.h4),
                            Text( ResponsiveScreen.isScreenSize(ScreenSize.sm, screenSize) ? 'true' : 'false')
                          ]
                      ),
                      ResponsiveCol(
                          padding: EdgeInsets.all(10),
                          backgroundColor: ResponsiveScreen.isScreenSize(ScreenSize.md, screenSize) ? Colors.green : Colors.red,
                          gridSizes: {
                            ScreenSize.xs: 12
                          },
                          children: [
                            Text('Is Medium Screen:\n('+ResponsiveScreen.limits[ScreenSize.md].toString()+'px)', style: JSXTypography.h4),
                            Text( ResponsiveScreen.isScreenSize(ScreenSize.md, screenSize) ? 'true' : 'false')
                          ]
                      ),
                      ResponsiveCol(
                          padding: EdgeInsets.all(10),
                          backgroundColor: ResponsiveScreen.isScreenSize(ScreenSize.lg, screenSize) ? Colors.green : Colors.red,
                          gridSizes: {
                            ScreenSize.xs: 12
                          },
                          children: [
                            Text('Is Large Screen:\n('+ResponsiveScreen.limits[ScreenSize.lg].toString()+'px)', style: JSXTypography.h4),
                            Text( ResponsiveScreen.isScreenSize(ScreenSize.lg, screenSize) ? 'true' : 'false')
                          ]
                      ),
                      ResponsiveCol(
                          padding: EdgeInsets.all(10),
                          backgroundColor: ResponsiveScreen.isScreenSize(ScreenSize.xl, screenSize) ? Colors.green : Colors.red,
                          gridSizes: {
                            ScreenSize.xs: 12
                          },
                          children: [
                            Text('Is Extra Large Screen:\n('+ResponsiveScreen.limits[ScreenSize.xl].toString()+'px)', style: JSXTypography.h4),
                            Text( ResponsiveScreen.isScreenSize(ScreenSize.xl, screenSize) ? 'true' : 'false')
                          ]
                      ),
                      ResponsiveCol(
                          padding: EdgeInsets.all(10),
                          backgroundColor: ResponsiveScreen.isScreenSize(ScreenSize.ul, screenSize) ? Colors.green : Colors.red,
                          gridSizes: {
                            ScreenSize.ul: 12
                          },
                          children: [
                            Text('Is Ultra Large Screen:\n('+ResponsiveScreen.limits[ScreenSize.ul].toString()+'px)', style: JSXTypography.h4),
                            Text( ResponsiveScreen.isScreenSize(ScreenSize.ul, screenSize) ? 'true' : 'false')
                          ]
                      ),

                    ]
                ),

                ResponsiveRow(
                    margin: EdgeInsets.only(top: 20, bottom: 5),
                    children: <Widget>[
                      Text('Grid Test', style: JSXTypography.h2)
                    ]
                ),
                ResponsiveRow(
                    margin: EdgeInsets.only(bottom: 20),
                    children: <Widget>[
                      Text('Open this page on different devices and different orientations.')
                    ]
                ),

                ResponsiveRow(
                  margin: EdgeInsets.only(bottom: 10),
                  children: <Widget>[

                    ResponsiveCol(
                        padding: EdgeInsets.all(10),
                        backgroundColor: Colors.orange,
                        gridSizes: { ScreenSize.xs : 4 },
                        children: [
                          Text('XS-4', style: JSXTypography.h4),
                          Text('\n\n')
                        ]..addAll(_aLotOfText)
                    ),
                    ResponsiveCol(
                        padding: EdgeInsets.all(10),
                        backgroundColor: Colors.green,
                        gridSizes: { ScreenSize.xs : 4 },
                        children: [
                          Text('XS-4', style: JSXTypography.h4),
                          Text('\n\n')
                        ]..addAll(_aLotOfText)
                    ),
                    ResponsiveCol(
                        padding: EdgeInsets.all(10),
                        backgroundColor: Colors.blue,
                        gridSizes: { ScreenSize.xs : 4 },
                        children: [
                          Text('XS-4', style: JSXTypography.h4),
                          Text('\n\n')
                        ]..addAll(_aLotOfText)
                    ),


                    ResponsiveCol(
                        padding: EdgeInsets.all(10),
                        backgroundColor: Colors.orange,
                        gridSizes: { ScreenSize.sm : 4 },
                        children: [
                          Text('SM-4', style: JSXTypography.h4),
                          Text('\n\n')
                        ]..addAll(_aLotOfText)
                    ),
                    ResponsiveCol(
                        padding: EdgeInsets.all(10),
                        backgroundColor: Colors.green,
                        gridSizes: { ScreenSize.sm : 4 },
                        children: [
                          Text('SM-4', style: JSXTypography.h4),
                          Text('\n\n')
                        ]..addAll(_aLotOfText)
                    ),
                    ResponsiveCol(
                        padding: EdgeInsets.all(10),
                        backgroundColor: Colors.blue,
                        gridSizes: { ScreenSize.sm : 4 },
                        children: [
                          Text('SM-4', style: JSXTypography.h4),
                          Text('\n\n')
                        ]..addAll(_aLotOfText)
                    ),


                    ResponsiveCol(
                        padding: EdgeInsets.all(10),
                        backgroundColor: Colors.orange,
                        gridSizes: { ScreenSize.md : 4 },
                        children: [
                          Text('MD-4', style: JSXTypography.h4),
                          Text('\n\n')
                        ]..addAll(_aLotOfText)
                    ),
                    ResponsiveCol(
                        padding: EdgeInsets.all(10),
                        backgroundColor: Colors.green,
                        gridSizes: { ScreenSize.md : 4 },
                        children: [
                          Text('MD-4', style: JSXTypography.h4),
                          Text('\n\n')
                        ]..addAll(_aLotOfText)
                    ),
                    ResponsiveCol(
                        padding: EdgeInsets.all(10),
                        backgroundColor: Colors.blue,
                        gridSizes: { ScreenSize.md : 4 },
                        children: [
                          Text('MD-4', style: JSXTypography.h4),
                          Text('\n\n')
                        ]..addAll(_aLotOfText)
                    ),


                    ResponsiveCol(
                        padding: EdgeInsets.all(10),
                        backgroundColor: Colors.orange,
                        gridSizes: { ScreenSize.lg : 4 },
                        children: [
                          Text('LG-4', style: JSXTypography.h4),
                          Text('\n\n')
                        ]..addAll(_aLotOfText)
                    ),
                    ResponsiveCol(
                        padding: EdgeInsets.all(10),
                        backgroundColor: Colors.green,
                        gridSizes: { ScreenSize.lg : 4 },
                        children: [
                          Text('LG-4', style: JSXTypography.h4),
                          Text('\n\n')
                        ]..addAll(_aLotOfText)
                    ),
                    ResponsiveCol(
                        padding: EdgeInsets.all(10),
                        backgroundColor: Colors.blue,
                        gridSizes: { ScreenSize.lg : 4 },
                        children: [
                          Text('LG-4', style: JSXTypography.h4),
                          Text('\n\n')
                        ]..addAll(_aLotOfText)
                    ),


                    ResponsiveCol(
                        padding: EdgeInsets.all(10),
                        backgroundColor: Colors.orange,
                        gridSizes: { ScreenSize.xl : 4 },
                        children: [
                          Text('XL-4', style: JSXTypography.h4),
                          Text('\n\n')
                        ]..addAll(_aLotOfText)
                    ),
                    ResponsiveCol(
                        padding: EdgeInsets.all(10),
                        backgroundColor: Colors.green,
                        gridSizes: { ScreenSize.xl : 4 },
                        children: [
                          Text('XL-4', style: JSXTypography.h4),
                          Text('\n\n')
                        ]..addAll(_aLotOfText)
                    ),
                    ResponsiveCol(
                        padding: EdgeInsets.all(10),
                        backgroundColor: Colors.blue,
                        gridSizes: { ScreenSize.xl : 4 },
                        children: [
                          Text('XL-4', style: JSXTypography.h4),
                          Text('\n\n')
                        ]..addAll(_aLotOfText)
                    ),


                    ResponsiveRow(
                        margin: EdgeInsets.only(top: 20, bottom: 5),
                        children: <Widget>[
                          Text('Grid Offset Test', style: JSXTypography.h2)
                        ]
                    ),
                    ResponsiveRow(
                        margin: EdgeInsets.only(bottom: 20),
                        children: <Widget>[
                          Text('Offset Elements')
                        ]
                    ),

                    ResponsiveCol(
                        padding: EdgeInsets.all(10),
                        backgroundColor: Colors.green,
                        gridSizes: { ScreenSize.xs : 4 },
                        gridOffsetSizes: { ScreenSize.xs : 4 },
                        children: _aLotOfText
                    ),
                    ResponsiveCol(
                        padding: EdgeInsets.all(10),
                        backgroundColor: Colors.blue,
                        gridSizes: { ScreenSize.xs : 4 },
                        children: _aLotOfText
                    ),


                    ResponsiveRow(
                        margin: EdgeInsets.only(top: 20, bottom: 25),
                        children: <Widget>[
                          Text('Grid Multiple Screen Resizing', style: JSXTypography.h2)
                        ]
                    ),

                    ResponsiveCol(
                        padding: EdgeInsets.all(10),
                        backgroundColor: Colors.green,
                        gridSizes: { ScreenSize.xs : 12 },
                        children: _smallText
                    ),

                  ]..addAll(
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
                          children: _smallText
                      )
                    ).toList()
                  ),
                ),
              ],
            ),
          ],
        )
    );
  }
}
