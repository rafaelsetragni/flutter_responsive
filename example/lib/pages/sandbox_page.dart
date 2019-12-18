import 'package:flutter/material.dart';
import 'package:flutter_responsive/flutter_responsive.dart';
import 'package:flutter_responsive_example/layouts/sidebar.dart';

class SandboxPage extends StatefulWidget {
  @override
  _SandboxPage createState() => new _SandboxPage();
}

class _SandboxPage extends State<SandboxPage> {

  bool highlight, shrink;

  @override
  void initState() {
    highlight = false;
    shrink = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    Color
      hilightedColor = Colors.yellowAccent,
      hilightColor = highlight ? hilightedColor : Colors.transparent;

    TextStyle defaultStyle = TextStyle(
      inherit: true,
      color: Colors.black
    );

    return Scaffold(
        appBar: AppBar(
          title: const Text(
              'Typography', overflow: TextOverflow.ellipsis),
        ),
        drawer: Sidebar(),
        body: DefaultTextStyle(
          style: defaultStyle,
          child: ListView(
            children: <Widget>[
              ResponsiveContainer(
                padding: EdgeInsets.all(10),
                children: <Widget>[

                  /* ***************************************************
                  Options
                  */
                  ResponsiveRow(
                      padding: EdgeInsets.symmetric(vertical: 10),
                      children: <Widget>[
                        SwitchListTile(
                            title: Text('Hilight text boxes'),
                            value: highlight,
                            activeColor: hilightedColor,
                            onChanged: (selected){
                              setState(() {
                                highlight = selected;
                              });
                            }
                        ),
                        SwitchListTile(
                            title: Text('Textbox shrink to fit'),
                            value: shrink,
                            activeColor: hilightedColor,
                            onChanged: (selected){
                              setState(() {
                                shrink = selected;
                              });
                            }
                        ),
                      ]
                  ),

                  /* ***************************************************
                  Divider
                  */
                  ResponsiveRow(
                    margin: EdgeInsets.only(bottom: 40),
                    children: <Widget>[
                      Divider(height: 5, color: Color.fromARGB(255, 86, 61, 124))
                    ],
                  ),

                  /* ***************************************************
                  Examples
                  */
                  ResponsiveRow(
                    padding: EdgeInsets.only(bottom: 20),
                    children: <Widget>[
                      ResponsiveText(
                        stylesheet: {
                          'b': ResponsiveStylesheet(
                            textStyle: TextStyle(fontSize: 30, color: Colors.red)
                          )
                        },
                        text:'R\$ <b>99</b>,00',
                        margin: EdgeInsets.only(bottom: 40),
                        shrinkToFit: shrink,
                      ),
                    ],
                  ),

                ],
              )
            ],
          ),
        )
    );
  }
}