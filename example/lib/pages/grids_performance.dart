import 'package:flutter/material.dart';
import 'package:flutter_responsive/flutter_responsive.dart';
import 'package:flutter_responsive_example/layouts/sidebar.dart';
import 'dart:math';

class GridPerformancePage extends StatefulWidget {

  @override
  _GridPerformancePage createState() => new _GridPerformancePage();
}

class _GridPerformancePage extends State<GridPerformancePage> {

  double  displayLines = 10;
  double  amountLines, heightBoxes, seed;
  bool switchTest;
  int columns;

  void updateSeed(){
    seed = Random().nextDouble();
  }

  @override
  void initState() {
    switchTest = true;
    amountLines = displayLines;
    heightBoxes = 150;
    columns = 2;

    updateSeed();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text(
            'Grid Performance', overflow: TextOverflow.ellipsis),
      ),
      drawer: Sidebar(),
      body: Scrollbar(
        child: ListView(
          children: [
            SwitchListTile(
              value: switchTest,
              onChanged: (bool value) => setState(() => switchTest = value),
              title: Text('Switch to Responsive cols', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.red)),
            ),
            Slider(
              min: 0.0,
              max: 100.0,
              divisions: 20,
              value: displayLines,
              label: '${displayLines.round()}',
              onChanged: (double value) {
                setState(() {
                  displayLines = value;
                });
              },
              onChangeEnd: (double value) {
                setState(() {
                  amountLines = value;
                  updateSeed();
                });
              },
            ),
            Slider(
              min: 0.0,
              max: 12.0,
              divisions: 12,
              value: columns.toDouble(),
              label: columns.toString(),
              onChanged: (double value) {
                setState(() {
                  columns = value.toInt();
                });
              }
            ),
          ]..addAll(
              switchTest ?
              List<int>.generate(amountLines.toInt(), (index) => index).map((rowIndex) =>
                ResponsiveRow(
                  backgroundColor: Colors.red,
                  margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  children: List<int>.generate(columns, (index) => index).map((colIndex) =>
                      ResponsiveCol(
                        alignment: Alignment.center,
                        backgroundColor: Color((seed * (rowIndex * 12 + colIndex) * 0xFFFFFF).toInt() << 0).withOpacity(1.0),
                        height: heightBoxes,
                        gridSizes: { 'us' : 1 },
                        children: <Widget>[
                          Text('R', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white))
                        ],
                      )
                  ).toList(),
                )
              ) :
              List<int>.generate(amountLines.toInt(), (index) => index).map((rowIndex) =>
                Container(
                  alignment: Alignment.topLeft,
                  margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  color: Colors.red,
                  child: Wrap(
                    children: List<int>.generate(columns, (index) => index).map((colIndex) =>
                      FractionallySizedBox(
                        widthFactor: 0.08332333333,//1.0/12.0 - 0.00001,
                        //heightFactor: 1.0,
                        child: Container(
                          alignment: Alignment.center,
                          height: heightBoxes,
                          color: Color((seed * (rowIndex * 12 + colIndex) * 0xFFFFFF).toInt() << 0).withOpacity(1.0),
                          child: Text('B', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
                        ),
                      )
                    ).toList()
                  )
                  //),
                )
              ).toList()
          )
            /*
            ResponsiveContainer(
              children: List<int>.generate(1, (index) => index).map((index) =>
                  ResponsiveRow(
                    backgroundColor: Colors.red,
                    margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    children: List<int>.generate(12, (index) => index).map((index) =>
                        ResponsiveCol(
                          alignment: Alignment.center,
                          backgroundColor: Color((Random().nextDouble() * 0xFFFFFF).toInt() << 0).withOpacity(1.0),
                          height: 50,
                          gridSizes: [ GridSize.xs_1 ],
                          children: <Widget>[
                            Text('B', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white))
                          ],
                        )
                    ).toList(),
                  )
              ).toList(),
            )
            */
        )
      ),
    );
  }
}