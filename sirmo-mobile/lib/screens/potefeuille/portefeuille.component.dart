import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sirmo/utils/color-const.dart';

import '../../components/top_curve_path.dart';
import '../../models/compte.dart';
import '../../services/compte.service.dart';
import '../../utils/app-util.dart';
import 'compte.history.screen.dart';
import 'credite-porte.screen.dart';

class PortefeuilleComponent extends StatelessWidget {
  const PortefeuilleComponent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Compte? compte = context.watch<CompteService>().compte;

    return ClipPath(
      clipper: TopCurvePathClipper(),
      child: Card(
        elevation: 10.0,
        child: Container(
          color: Theme.of(context).primaryColor,
          child: Stack(children: [
            Align(
                alignment: Alignment.center,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      "Solde: ",
                      style: TextStyle(
                          color: ColorConst.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "${compte?.montant ?? "..."} F ",
                      style: const TextStyle(
                          color: ColorConst.white,
                          fontSize: 24,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                )),
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 16, left: 32, right: 32),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextButton.icon(
                        onPressed: () {
                          AppUtil.goToScreen(
                              context, CreditPortefeuilleScreen());
                        },
                        icon: const Icon(
                          Icons.add,
                          color: ColorConst.white,
                        ),
                        label: const Text(
                          "Recharger",
                          style: TextStyle(
                              color: ColorConst.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      TextButton.icon(
                        onPressed: () {
                          AppUtil.goToScreen(context, CompteHistoryScreen());
                        },
                        icon: const Icon(
                          Icons.history,
                          color: ColorConst.white,
                        ),
                        label: const Text(
                          "Historique",
                          style: TextStyle(
                              color: ColorConst.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ]),
              ),
            )
          ]),
          height: 200,
        ),
      ),
    );
  }
}
