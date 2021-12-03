import 'package:flutter/material.dart';
import 'package:testapp/news.dart';

class Another extends StatelessWidget {
  // const Another({Key? key}) : super(key: key);
  final Post coin;
  Another(this.coin);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(coin.name),
      ),
      body: Container(
        height: 300,
        width: 500,
        child: Image.network(coin.image),
      ),
    );
  }
}
