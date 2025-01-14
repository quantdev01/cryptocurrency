import 'dart:developer';
import 'dart:io' show Platform;

import 'package:crypto_tracker/coin_data.dart';
import 'package:crypto_tracker/crypto_rate.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class PriceScreen extends StatefulWidget {
  const PriceScreen({super.key});

  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  double cryptoRate = 0;
  double cryptoRate1 = 0;
  double cryptoRate2 = 0;

  String selectedMenu = 'USD';

  CoinData coinData = CoinData();

  DropdownButton<String> androidPicker() {
    List<DropdownMenuItem<String>> newItems = [];

    for (var i in currenciesList) {
      newItems.add(
        DropdownMenuItem(
          value: i,
          child: Text(i),
        ),
      );
    }

    return DropdownButton<String>(
      value: selectedMenu,
      items: newItems,
      onChanged: (value) {
        setState(() {
          selectedMenu = value!;
          _loadData();
        });
        log(value.toString());
      },
    );
  }

  Widget iosPicker() {
    List<Widget> newItems = [];

    for (var i in currenciesList) {
      newItems.add(Text(i));
    }
    return CupertinoPicker(
      backgroundColor: Colors.lightBlue,
      itemExtent: 32,
      onSelectedItemChanged: (value) {
        log(value.toString());
      },
      children: newItems,
    );
  }

  Future<void> _loadData() async {
    double data = await getData(cryptoList[0]);
    double data1 = await getData(cryptoList[1]);
    double data2 = await getData(cryptoList[2]);

    setState(() {
      cryptoRate = data;
      cryptoRate1 = data1;
      cryptoRate2 = data2;
    });
  }

  Future<double> getData(String myCrypto) async {
    var dataDecoded = await CoinData().getCoinData(myCrypto, selectedMenu);
    log(dataDecoded != null ? dataDecoded['rate'].toString() : 'No data found');
    return dataDecoded != null ? dataDecoded['rate'] : 0.0;
  }

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('🤑 Coin Ticker'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              CryptoRate(
                  cryptoValueText: cryptoList[0],
                  cryptoRate: cryptoRate,
                  currency: selectedMenu),
              CryptoRate(
                  cryptoValueText: cryptoList[1],
                  cryptoRate: cryptoRate1,
                  currency: selectedMenu),
              CryptoRate(
                  cryptoValueText: cryptoList[2],
                  cryptoRate: cryptoRate2,
                  currency: selectedMenu),
            ],
          ),
          Container(
            height: 150.0,
            alignment: Alignment.center,
            padding: const EdgeInsets.only(bottom: 30.0),
            color: Colors.black87,
            child: Platform.isIOS ? iosPicker() : androidPicker(),
          ),
        ],
      ),
    );
  }
}
