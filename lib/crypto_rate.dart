import 'package:flutter/material.dart';

class CryptoRate extends StatelessWidget {
  const CryptoRate({
    super.key,
    required this.cryptoRate,
    required this.currency,
    required this.cryptoValueText,
  });

  final double cryptoRate;
  final String currency;
  final String cryptoValueText;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
      child: Card(
        color: Colors.lightBlueAccent,
        elevation: 5.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 28),
          child: Text(
            '1 $cryptoValueText = ${cryptoRate.round()} $currency',
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 20.0,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
