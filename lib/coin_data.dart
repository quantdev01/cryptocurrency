import 'dart:developer';

import 'package:http/http.dart' as http;
import 'dart:convert';

const List<String> currenciesList = [
  'AUD',
  'BRL',
  'CAD',
  'CNY',
  'EUR',
  'GBP',
  'HKD',
  'IDR',
  'ILS',
  'INR',
  'JPY',
  'MXN',
  'NOK',
  'NZD',
  'PLN',
  'RON',
  'RUB',
  'SEK',
  'SGD',
  'USD',
  'ZAR'
];

var i = 0;
var len = currenciesList.length;

const List<String> cryptoList = [
  'BTC',
  'ETH',
  'LTC',
];

class CoinData {
  Future<String> getCoinData() async {
    var url =
        'https://api.coinlayer.com/live?access_key=bdc01231bd1939f577537b248ed5f9d2';

    var data = '';

    try {
      var uri = Uri.parse(url);

      http.Response response = await http.get(uri);

      if (response.statusCode == 200) {
        data = response.body;
        log(data);
        return jsonDecode(data);
      } else {
        log(response.statusCode.toString());
      }
    } on Exception catch (e) {
      log('This happened $e');
    }
    return data;
  }
}
