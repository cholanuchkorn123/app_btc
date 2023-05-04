import 'dart:convert';

import 'package:dio/dio.dart';

import '../model/CoinModel.dart';

class Services {
  Dio _dio = Dio();
  final String _url = 'https://api.coindesk.com/v1/bpi/currentprice.json';
  Future<Coin> getCoinData() async {
    try {
      var response = await _dio.get(_url);
      var item = jsonDecode(response.data);

      Coin dataFromServer = Coin.fromJson(item);

      return dataFromServer;
    } catch (e) {
      throw (e);
    }
  }
}
