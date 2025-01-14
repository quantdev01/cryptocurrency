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

var apiKey = '895bf7bf-777b-4873-ac83-23422c9d519b';
var apiKeyMarket = '04b0eeff-9849-4bd2-a07f-bbc27621ee2e';

class CoinData {
  Future getCoinData(
    String value,
    String toChange,
  ) async {
    var url =
        'https://rest.coinapi.io/v1/exchangerate/$value/$toChange?apikey=$apiKeyMarket';

    var data = '';

    try {
      var uri = Uri.parse(url);

      http.Response response = await http.get(uri);

      if (response.statusCode == 200) {
        if (response.body.isNotEmpty) {
          data = response.body;
        }

        log('from class');
        var decodedData = jsonDecode(data);
        log(decodedData['rate'].toString());

        return jsonDecode(data);
      } else {
        log(response.statusCode.toString());
      }
    } on Exception catch (e) {
      log('This happened $e');
    }
  }
}
