import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sirmo/components/app-decore.dart';
import 'package:sirmo/components/personal_alert.dart';
import 'package:sirmo/models/conducteur-stat.dart';
import 'package:sirmo/services/appreciation.service.dart';
import 'package:sirmo/utils/color-const.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../models/conducteur.dart';
import '../../models/user.dart';
import '../../utils/network-info.dart';

class StatistiqueConducteurScreen extends StatefulWidget {
  const StatistiqueConducteurScreen({Key? key, required this.conducteur})
      : super(key: key);
  final Conducteur conducteur;

  @override
  State<StatistiqueConducteurScreen> createState() =>
      _StatistiqueConducteurScreenState();
}

class _StatistiqueConducteurScreenState
    extends State<StatistiqueConducteurScreen> {
  late Conducteur conducteur;
  ConducteurStat? statistique;
  User? user;
  @override
  void initState() {
    super.initState();
    conducteur = widget.conducteur;
    user = conducteur.user;
  }

  loadStat() async {
    await context
        .read<AppreciationService>()
        .loadStatistique(conducteur.id!)
        .then((value) {
      setState(() {
        statistique = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppDecore.appBar(context, "Satistique"),
      extendBody: true,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Center(
              widthFactor: 0.8,
              child: Card(
                margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
                child: Container(
                  width: size.width * 0.7,
                  padding:
                      EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
                  child: Column(
                    children: [
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.2,
                        child: Container(
                          padding: EdgeInsets.all(2),
                          height: MediaQuery.of(context).size.height * 0.2,
                          width: MediaQuery.of(context).size.height * 0.2,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white,
                          ),
                          child: CircleAvatar(
                            foregroundImage: NetworkImage(
                              "${NetworkInfo.baseUrl}${widget.conducteur.user?.profile_image}",
                              headers: {
                                "Authorization": "Bearer ${NetworkInfo.token}",
                              },
                            ),
                            backgroundImage:
                                AssetImage("assets/images/profile.jpg"),
                          ),
                        ),
                      ),
                      SizedBox(height: 16),
                      Text(
                        "${user?.nom ?? ''} ${user?.prenom ?? ''}",
                        style: const TextStyle(
                            fontStyle: FontStyle.italic,
                            fontSize: 18,
                            fontWeight: FontWeight.w500),
                      ),
                      SizedBox(height: 16),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text("Status : "),
                          Text(
                            "${conducteur.statut}",
                            style: TextStyle(
                                fontStyle: FontStyle.italic,
                                fontSize: 18,
                                color: conducteur.isActif
                                    ? ColorConst.primary
                                    : ColorConst.error,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
            Container(
                child: FutureBuilder<ConducteurStat?>(
                    future: context
                        .read<AppreciationService>()
                        .loadStatistique(conducteur.id!),
                    builder: (context, data) {
                      if (data.hasData) {
                        statistique = data.data;
                        return SfCartesianChart(
                            // Initialize category axis
                            primaryXAxis: CategoryAxis(),
                            series: <LineSeries<SalesData, String>>[
                              LineSeries<SalesData, String>(
                                  color: Colors.blue,
                                  width: 50,
                                  // Bind data source
                                  dataSource: <SalesData>[
                                    SalesData('EXCELLENTE', 0),
                                    SalesData('EXCELLENTE',
                                        statistique?.excellence ?? 0.0),
                                  ],
                                  xValueMapper: (SalesData sales, _) =>
                                      sales.year,
                                  yValueMapper: (SalesData sales, _) =>
                                      sales.sales),
                              LineSeries<SalesData, String>(
                                  color: Colors.green,
                                  width: 50,
                                  // Bind data source
                                  dataSource: <SalesData>[
                                    SalesData('TRES BON ', 0),
                                    SalesData('TRES BON ',
                                        statistique?.tres_bon ?? 0.0),
                                  ],
                                  xValueMapper: (SalesData sales, _) =>
                                      sales.year,
                                  yValueMapper: (SalesData sales, _) =>
                                      sales.sales),
                              LineSeries<SalesData, String>(
                                  color: Colors.amber,
                                  width: 50,
                                  // Bind data source
                                  dataSource: <SalesData>[
                                    SalesData('BON', 0),
                                    SalesData('BON', statistique?.bon ?? 0.0),
                                  ],
                                  xValueMapper: (SalesData sales, _) =>
                                      sales.year,
                                  yValueMapper: (SalesData sales, _) =>
                                      sales.sales),
                              LineSeries<SalesData, String>(
                                  color: Colors.red,
                                  width: 50,
                                  // Bind data source
                                  dataSource: <SalesData>[
                                    SalesData('MAUVAIS', 0),
                                    SalesData(
                                        'MAUVAIS', statistique?.mauvais ?? 0.0),
                                  ],
                                  xValueMapper: (SalesData sales, _) =>
                                      sales.year,
                                  yValueMapper: (SalesData sales, _) =>
                                      sales.sales)
                            ]);
                      }
                      if (data.hasError) {
                        return Text("${data.error ?? ""}");
                      }
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    })),
          ],
        ),
      ),
    );
  }
}

class SalesData {
  SalesData(this.year, this.sales);
  final String year;
  final double sales;
}
