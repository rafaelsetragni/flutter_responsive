import 'package:flutter/material.dart';
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
                'xs' : 4,
                'sm' : 3,
                'lg' : 2,
                'xl' : 1,
              },
              children: [
                Text('Lorem ipsum dolor sit amet, consectetur adipiscing elit')
              ]
          )
      ).toList();

    MediaQueryData mediaQuery = MediaQuery.of(context);

    return Scaffold(
        appBar: AppBar(
          title: const Text('Home', overflow: TextOverflow.ellipsis),
        ),
        drawer: Sidebar(),
        body: Container(
          color: Color(0xFFCCCCCC),
          child: ListView(
            children: <Widget>[
              ResponsiveContainer(
                margin: EdgeInsets.symmetric(vertical: 10),
                padding: EdgeInsets.symmetric(horizontal: 10),
                backgroundColor: Colors.white,
                widthLimit: mediaQuery.size.width * 0.95,
                children: <Widget>[
                  ResponsiveRow(
                    margin: EdgeInsets.symmetric(vertical: 10),
                    children: <Widget>[

                      ResponsiveCol(
                          padding: EdgeInsets.all(10),
                          margin: EdgeInsets.only(bottom: 20),
                          backgroundColor: Colors.blueGrey,
                          children: [
                            Text('Flutter Responsive Layout', style: ResponsiveTypography.h4.merge(TextStyle(color: Colors.white)))
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
                          ResponsiveText(
                            shrinkToFit: true,
                            padding: EdgeInsets.only(bottom: 20),
                            stylesheet: {
                              'h3': ResponsiveStylesheet(
                                  textStyle: TextStyle(color: Theme.of(context).primaryColor),
                                  displayStyle: DisplayStyle.block
                              ),
                              'h6': ResponsiveStylesheet(
                                  textStyle: TextStyle(color: Theme.of(context).primaryColor),
                                  displayStyle: DisplayStyle.block
                              )
                            },
                            margin: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                            text:
                            '<div>'
                                '<h3>Responsive Layouts</h3><h6>for <i>Flutter</i></h6>'
                                '<br><br>'
                                '<p>This <b>RichText</b> was easily produced and personalized using pure HTML</p>'
                                '<p>Bellow there is an example of 12 columns, wich changes the amount of each line depending of his father´s widget size.</p>'
                            '</div>',
                          )
                        ]
                      )

                    ]..addAll(
                        responsiveGridExampe
                    )
                  )
                ],
              )
            ],
          ),
        )
    );
  }
}
