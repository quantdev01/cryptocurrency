import 'dart:developer';
import 'dart:io' show Platform;

import 'package:crypto_tracker/coin_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class PriceScreen extends StatefulWidget {
  const PriceScreen({super.key});

  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  String selectedMenu = 'USD';
  CoinData coinData = CoinData();

  dynamic cryptoData = CoinData().getCoinData();

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
          Padding(
            padding: const EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
            child: Card(
              color: Colors.lightBlueAccent,
              elevation: 5.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    vertical: 15.0, horizontal: 28.0),
                child: Text(
                  '1 BTC = ${cryptoData['rates']['BTC']} USD',
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 20.0,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          Container(
            height: 150.0,
            alignment: Alignment.center,
            padding: const EdgeInsets.only(bottom: 30.0),
            color: Colors.lightBlue,
            child: Platform.isIOS ? iosPicker() : androidPicker(),
          ),
        ],
      ),
    );
  }
}
