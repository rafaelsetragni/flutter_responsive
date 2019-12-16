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
                widthLimit: MediaQuery.of(context).size.width * 0.95,
                children: <Widget>[
                  Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        border: Border.all(width: 2.0, color: Theme.of(context).primaryColor),
                      ),
                      width: 60,
                      height: 60,
                      padding: EdgeInsets.all(5),
                      margin: EdgeInsets.all(10),
                      alignment: Alignment.center,
                      child: Image.asset('assets/flutter-512.png', color: Theme.of(context).primaryColor,)
                  ),
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
                        '</div>',
                  )
                ],
              )
            ],
          ),
        )
    );
  }
}
