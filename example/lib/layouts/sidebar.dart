import 'package:flutter/material.dart';
import 'package:flutter_jsx/flutter_jsx.dart';
import 'package:flutter_responsive_example/pages/grids_page.dart';
import 'package:flutter_responsive_example/pages/grids_performance.dart';
import 'package:flutter_responsive_example/pages/home_page.dart';
import 'package:flutter_responsive_example/pages/sandbox_page.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_responsive/flutter_responsive.dart';

class Sidebar extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQuery = MediaQuery.of(context);

    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          ResponsiveContainer(
            padding: EdgeInsets.all(10).add(EdgeInsets.only(top: mediaQuery.padding.top)),
            width: mediaQuery.size.width,
            backgroundColor: Theme.of(context).primaryColor,
            height: 200,
            children: <Widget>[
              ResponsiveRow(
                children: <Widget>[
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      border: Border.all(width: 2.0, color: Colors.white),
                    ),
                    width: 60,
                    height: 60,
                    padding: EdgeInsets.all(5),
                    margin: EdgeInsets.all(10),
                    alignment: Alignment.center,
                    child: Image.asset('assets/flutter-512.png', color: Colors.white,)
                  )
                ]
              ),
              ResponsiveRow(
                children: <Widget>[
                  Text('Responsive Layouts', style: JSXTypography.h4.apply(color: Colors.white)),
                ],
              ),
              ResponsiveRow(
                children: <Widget>[
                  JSX(
                    'for <i>Flutter</i>',
                    textStyle: TextStyle(color: Colors.white, fontSize: 12),
                  )
                ],
              )
            ]
          ),
          ListTile(
            contentPadding: EdgeInsets.only(left: 20, right: 20),
            title: Text('Home'),
            trailing: Icon(FontAwesomeIcons.home),
            onTap: () {
              Navigator.of(context).pop();
              Navigator.push(context, MaterialPageRoute( builder: (BuildContext context) => HomePage() ));
            },
          ),
          ExpansionTile(
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text("Grid"),
                Icon(FontAwesomeIcons.th)
              ],
            ),
            children: <Widget>[
              ListTile(
                contentPadding: EdgeInsets.only(left: 30, right: 20),
                title: Text('Single Cases Tests'),
                trailing: Icon(FontAwesomeIcons.flask),
                onTap: () {
                  Navigator.of(context).pop();
                  Navigator.push(context, MaterialPageRoute( builder: (BuildContext context) => GridPage() ));
                },
              ),
              ListTile(
                contentPadding: EdgeInsets.only(left: 30, right: 20),
                title: Text('Performance Test'),
                trailing: Icon(FontAwesomeIcons.chartLine),
                onTap: () {
                  Navigator.of(context).pop();
                  Navigator.push(context, MaterialPageRoute( builder: (BuildContext context) => GridPerformancePage() ));
                },
              )
            ],
          ),
          Divider(height: 2.0, indent: 16.0, endIndent: 10),
          ListTile(
            contentPadding: EdgeInsets.only(left: 15, right: 20),
            title: Text('Sandbox'),
            trailing: Icon(FontAwesomeIcons.fortAwesome),
            onTap: () {
              Navigator.of(context).pop();
              Navigator.push(context, MaterialPageRoute( builder: (BuildContext context) => SandboxPage() ));
            },
          ),
        ],
      ),
    );
  }
}