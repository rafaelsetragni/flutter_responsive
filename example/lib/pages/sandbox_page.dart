import 'package:flutter/material.dart';
import 'package:flutter_responsive/flutter_responsive.dart';
import 'package:flutter_responsive_example/layouts/sidebar.dart';

class SandboxPage extends StatefulWidget {
  @override
  _SandboxPage createState() => new _SandboxPage();
}

class _SandboxPage extends State<SandboxPage> {

  bool highlight, displayInline;
  DisplayStyle displayStyle;

  @override
  void initState() {
    highlight = false;
    displayInline = false;
    displayStyle = DisplayStyle.block;
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
                            title: Text('Textbox displays inline'),
                            value: displayInline,
                            activeColor: hilightedColor,
                            onChanged: (selected){
                              setState(() {
                                displayInline = selected;
                                displayStyle = selected ? DisplayStyle.inline : DisplayStyle.block;
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
                              margin: EdgeInsets.only(left: 10),
                              textAlign: TextAlign.right,
                              textStyle: TextStyle( fontSize: 30, color: Colors.white, backgroundColor: Colors.blue )
                          )
                        },
                        text:'R\$ <b>99</b>,00',
                        margin: EdgeInsets.all(10.0),
                        backgroundColor: hilightColor,
                        display: displayStyle,
                      ),

                      ResponsiveText(
                        stylesheet: {
                          'b': ResponsiveStylesheet(
                              margin: EdgeInsets.only(left: 10),
                              textAlign: TextAlign.right,
                              textStyle: TextStyle( fontSize: 30, color: Colors.white, backgroundColor: Colors.blue )
                          )
                        },
                        text:'R\$ <b>99</b>,00',
                        margin: EdgeInsets.all(10.0),
                        backgroundColor: hilightColor,
                        display: displayStyle,
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