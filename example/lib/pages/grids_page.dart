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
              maxWidth: ResponsiveScreen.limits['lg'],

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
                            'xs': 12
                          },
                          backgroundColor: ResponsiveScreen.isScreenSize('us', screenSize) ? Colors.green : Colors.red,
                          children: [
                            Text('Is Ultra Small Screen:\n('+ResponsiveScreen.limits['us'].toString()+'px)', style: JSXTypography.h4),
                            Text( ResponsiveScreen.isScreenSize('us', screenSize) ? 'true' : 'false')
                          ]
                      ),
                      ResponsiveCol(
                          padding: EdgeInsets.all(10),
                          gridSizes: {
                            'xs': 12
                          },
                          backgroundColor: ResponsiveScreen.isScreenSize('xs', screenSize) ? Colors.green : Colors.red,
                          children: [
                            Text('Is Extra Small Screen:\n('+ResponsiveScreen.limits['xs'].toString()+'px)', style: JSXTypography.h4),
                            Text( ResponsiveScreen.isScreenSize('xs', screenSize) ? 'true' : 'false')
                          ]
                      ),
                      ResponsiveCol(
                          padding: EdgeInsets.all(10),
                          backgroundColor: ResponsiveScreen.isScreenSize('sm', screenSize) ? Colors.green : Colors.red,
                          gridSizes: {
                            'xs': 12
                          },
                          children: [
                            Text('Is Small Screen:\n('+ResponsiveScreen.limits['sm'].toString()+'px)', style: JSXTypography.h4),
                            Text( ResponsiveScreen.isScreenSize('sm', screenSize) ? 'true' : 'false')
                          ]
                      ),
                      ResponsiveCol(
                          padding: EdgeInsets.all(10),
                          backgroundColor: ResponsiveScreen.isScreenSize('md', screenSize) ? Colors.green : Colors.red,
                          gridSizes: {
                            'xs': 12
                          },
                          children: [
                            Text('Is Medium Screen:\n('+ResponsiveScreen.limits['md'].toString()+'px)', style: JSXTypography.h4),
                            Text( ResponsiveScreen.isScreenSize('md', screenSize) ? 'true' : 'false')
                          ]
                      ),
                      ResponsiveCol(
                          padding: EdgeInsets.all(10),
                          backgroundColor: ResponsiveScreen.isScreenSize('lg', screenSize) ? Colors.green : Colors.red,
                          gridSizes: {
                            'xs': 12
                          },
                          children: [
                            Text('Is Large Screen:\n('+ResponsiveScreen.limits['lg'].toString()+'px)', style: JSXTypography.h4),
                            Text( ResponsiveScreen.isScreenSize('lg', screenSize) ? 'true' : 'false')
                          ]
                      ),
                      ResponsiveCol(
                          padding: EdgeInsets.all(10),
                          backgroundColor: ResponsiveScreen.isScreenSize('xl', screenSize) ? Colors.green : Colors.red,
                          gridSizes: {
                            'xs': 12
                          },
                          children: [
                            Text('Is Extra Large Screen:\n('+ResponsiveScreen.limits['xl'].toString()+'px)', style: JSXTypography.h4),
                            Text( ResponsiveScreen.isScreenSize('xl', screenSize) ? 'true' : 'false')
                          ]
                      ),
                      ResponsiveCol(
                          padding: EdgeInsets.all(10),
                          backgroundColor: ResponsiveScreen.isScreenSize('ul', screenSize) ? Colors.green : Colors.red,
                          gridSizes: {
                            'ul': 12
                          },
                          children: [
                            Text('Is Ultra Large Screen:\n('+ResponsiveScreen.limits['ul'].toString()+'px)', style: JSXTypography.h4),
                            Text( ResponsiveScreen.isScreenSize('ul', screenSize) ? 'true' : 'false')
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
                        gridSizes: { 'xs' : 4 },
                        children: [
                          Text('XS-4', style: JSXTypography.h4),
                          Text('\n\n')
                        ]..addAll(_aLotOfText)
                    ),
                    ResponsiveCol(
                        padding: EdgeInsets.all(10),
                        backgroundColor: Colors.green,
                        gridSizes: { 'xs' : 4 },
                        children: [
                          Text('XS-4', style: JSXTypography.h4),
                          Text('\n\n')
                        ]..addAll(_aLotOfText)
                    ),
                    ResponsiveCol(
                        padding: EdgeInsets.all(10),
                        backgroundColor: Colors.blue,
                        gridSizes: { 'xs' : 4 },
                        children: [
                          Text('XS-4', style: JSXTypography.h4),
                          Text('\n\n')
                        ]..addAll(_aLotOfText)
                    ),


                    ResponsiveCol(
                        padding: EdgeInsets.all(10),
                        backgroundColor: Colors.orange,
                        gridSizes: { 'sm' : 4 },
                        children: [
                          Text('SM-4', style: JSXTypography.h4),
                          Text('\n\n')
                        ]..addAll(_aLotOfText)
                    ),
                    ResponsiveCol(
                        padding: EdgeInsets.all(10),
                        backgroundColor: Colors.green,
                        gridSizes: { 'sm' : 4 },
                        children: [
                          Text('SM-4', style: JSXTypography.h4),
                          Text('\n\n')
                        ]..addAll(_aLotOfText)
                    ),
                    ResponsiveCol(
                        padding: EdgeInsets.all(10),
                        backgroundColor: Colors.blue,
                        gridSizes: { 'sm' : 4 },
                        children: [
                          Text('SM-4', style: JSXTypography.h4),
                          Text('\n\n')
                        ]..addAll(_aLotOfText)
                    ),


                    ResponsiveCol(
                        padding: EdgeInsets.all(10),
                        backgroundColor: Colors.orange,
                        gridSizes: { 'sm' : 4 },
                        children: [
                          Text('MD-4', style: JSXTypography.h4),
                          Text('\n\n')
                        ]..addAll(_aLotOfText)
                    ),
                    ResponsiveCol(
                        padding: EdgeInsets.all(10),
                        backgroundColor: Colors.green,
                        gridSizes: { 'sm' : 4 },
                        children: [
                          Text('MD-4', style: JSXTypography.h4),
                          Text('\n\n')
                        ]..addAll(_aLotOfText)
                    ),
                    ResponsiveCol(
                        padding: EdgeInsets.all(10),
                        backgroundColor: Colors.blue,
                        gridSizes: { 'sm' : 4 },
                        children: [
                          Text('MD-4', style: JSXTypography.h4),
                          Text('\n\n')
                        ]..addAll(_aLotOfText)
                    ),


                    ResponsiveCol(
                        padding: EdgeInsets.all(10),
                        backgroundColor: Colors.orange,
                        gridSizes: { 'lg' : 4 },
                        children: [
                          Text('LG-4', style: JSXTypography.h4),
                          Text('\n\n')
                        ]..addAll(_aLotOfText)
                    ),
                    ResponsiveCol(
                        padding: EdgeInsets.all(10),
                        backgroundColor: Colors.green,
                        gridSizes: { 'lg' : 4 },
                        children: [
                          Text('LG-4', style: JSXTypography.h4),
                          Text('\n\n')
                        ]..addAll(_aLotOfText)
                    ),
                    ResponsiveCol(
                        padding: EdgeInsets.all(10),
                        backgroundColor: Colors.blue,
                        gridSizes: { 'lg' : 4 },
                        children: [
                          Text('LG-4', style: JSXTypography.h4),
                          Text('\n\n')
                        ]..addAll(_aLotOfText)
                    ),


                    ResponsiveCol(
                        padding: EdgeInsets.all(10),
                        backgroundColor: Colors.orange,
                        gridSizes: { 'xl' : 4 },
                        children: [
                          Text('XL-4', style: JSXTypography.h4),
                          Text('\n\n')
                        ]..addAll(_aLotOfText)
                    ),
                    ResponsiveCol(
                        padding: EdgeInsets.all(10),
                        backgroundColor: Colors.green,
                        gridSizes: { 'xl' : 4 },
                        children: [
                          Text('XL-4', style: JSXTypography.h4),
                          Text('\n\n')
                        ]..addAll(_aLotOfText)
                    ),
                    ResponsiveCol(
                        padding: EdgeInsets.all(10),
                        backgroundColor: Colors.blue,
                        gridSizes: { 'xl' : 4 },
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
                        gridSizes: { 'xs' : 4 },
                        gridOffsetSizes: { 'xs' : 4 },
                        children: _aLotOfText
                    ),
                    ResponsiveCol(
                        padding: EdgeInsets.all(10),
                        backgroundColor: Colors.blue,
                        gridSizes: { 'xs' : 4 },
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
                        gridSizes: { 'xs' : 12 },
                        children: _smallText
                    ),

                  ]..addAll(
                    List<int>.generate(12, (index) => index).map((colIndex) =>
                      ResponsiveCol(
                          padding: EdgeInsets.all(10),
                          backgroundColor: Colors.blue,
                          gridSizes: {
                            'xs' : 4,
                            'sm' : 3,
                            'lg' : 2,
                            'xl' : 1,
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
