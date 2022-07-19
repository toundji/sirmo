import 'package:flutter/material.dart';
import 'package:sirmo/components/app-decore.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../models/conducteur.dart';

class StatistiqueConducteurScreen extends StatefulWidget {
  StatistiqueConducteurScreen({Key? key, required this.conducteur})
      : super(key: key);
  final Conducteur conducteur;

  @override
  State<StatistiqueConducteurScreen> createState() =>
      _StatistiqueConducteurScreenState();
}

class _StatistiqueConducteurScreenState
    extends State<StatistiqueConducteurScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppDecore.appBar(context, "Satistique"),
      body: Center(
          child: Container(
              child: SfCartesianChart(
                  // Initialize category axis
                  primaryXAxis: CategoryAxis(),
                  series: <LineSeries<SalesData, String>>[
            LineSeries<SalesData, String>(
                color: Colors.blue,
                width: 50,
                // Bind data source
                dataSource: <SalesData>[
                  SalesData('EXCELLENTE', 0),
                  SalesData('EXCELLENTE', 5),
                ],
                xValueMapper: (SalesData sales, _) => sales.year,
                yValueMapper: (SalesData sales, _) => sales.sales),
            LineSeries<SalesData, String>(
                color: Colors.green,
                width: 50,
                // Bind data source
                dataSource: <SalesData>[
                  SalesData('TRES BON ', 0),
                  SalesData('TRES BON ', 28),
                ],
                xValueMapper: (SalesData sales, _) => sales.year,
                yValueMapper: (SalesData sales, _) => sales.sales),
            LineSeries<SalesData, String>(
                color: Colors.amber,
                width: 50,
                // Bind data source
                dataSource: <SalesData>[
                  SalesData('BON', 0),
                  SalesData('BON', 34),
                ],
                xValueMapper: (SalesData sales, _) => sales.year,
                yValueMapper: (SalesData sales, _) => sales.sales),
            LineSeries<SalesData, String>(
                color: Colors.red,
                width: 50,
                // Bind data source
                dataSource: <SalesData>[
                  SalesData('MAUVAIS', 0),
                  SalesData('MAUVAIS', 10),
                ],
                xValueMapper: (SalesData sales, _) => sales.year,
                yValueMapper: (SalesData sales, _) => sales.sales)
          ]))),
    );
  }
}

class SalesData {
  SalesData(this.year, this.sales);
  final String year;
  final double sales;
}
