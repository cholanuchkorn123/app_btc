import 'package:btc_app/src/model/CoinModel.dart';
import 'package:btc_app/src/model/commonModel.dart';
import 'package:btc_app/src/services/Services.dart';
import 'package:flutter/material.dart';

class Homeprovider extends ChangeNotifier {
  Coin? item;
  List<LastData> lastUsdData = [];
  List<LastData> lastGbpData = [];
  List<LastData> lastEurData = [];

  List<String> rateList = ['', '', ''];
  void updateData(String type) async {
    item = await Services().getCoinData();

    rateList[0] = item!.bpi.usd.rate.toString();
    rateList[1] = item!.bpi.gbp.rate.toString();
    rateList[2] = item!.bpi.eur.rate.toString();
    notifyListeners();

    lastUsdData.add(
        LastData(item!.time.updated.toString(), item!.bpi.usd.rate.toString()));

    lastGbpData.add(
        LastData(item!.time.updated.toString(), item!.bpi.gbp.rate.toString()));

    lastEurData.add(
        LastData(item!.time.updated.toString(), item!.bpi.eur.rate.toString()));

    notifyListeners();
  }
}
