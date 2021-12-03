import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:testapp/another.dart';
// import 'package:login_app/pages/Widgets/data.dart';

Future<List<Post>> fetchPosts() async {
  http.Response response = await http.get(Uri.parse(
      "https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&order=market_cap_desc&per_page=100&page=1&sparkline=false"));
  var responseJson = json.decode(response.body);
  return (responseJson as List).map((p) => Post.fromJson(p)).toList();
}

class Post {
  // ignore: non_constant_identifier_names
  final String name, image, symbol, current_price, market_cap_rank, updateDate;

  Post({
    required this.name,
    required this.image,
    required this.symbol,
    // ignore: non_constant_identifier_names
    required this.current_price,
    // ignore: non_constant_identifier_names
    required this.market_cap_rank,
    required this.updateDate,
  });

  factory Post.fromJson(Map<String, dynamic> json) {
    return new Post(
      name: json['name'].toString(),
      image: json['image'].toString(),
      symbol: json['symbol'].toString(),
      current_price: json['current_price'].toString(),
      market_cap_rank: json['market_cap_rank'].toString(),
      updateDate: json['utcTime'].toString(),
    );
  }
}

class NewsApp extends StatefulWidget {
  NewsApp({Key? key}) : super(key: key);

  @override
  _NewsAppState createState() => _NewsAppState();
}

class _NewsAppState extends State<NewsApp> {
  // var listSource;
  var refreshKey = GlobalKey<RefreshIndicatorState>();
  @override
  void initState() {
    super.initState();
    fetchPosts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // backgroundColor: Colors.black,
        appBar: new AppBar(
          centerTitle: true,
          // backgroundColor: Colors.transparent,
          elevation: 0.0,
          title: Text(
            'Cryptocurrency',
          ),
        ),
        // drawer: MyDrawer(),
        body: Container(
          child: FutureBuilder(
              future: fetchPosts(),
              builder: (context, AsyncSnapshot snapshot) {
                if (snapshot.data == null) {
                  return Container(
                    child: Center(
                      child: Text(
                        "Loading...",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  );
                } else {
                  return ListView.builder(
                    itemCount: snapshot.data.length,
                    itemBuilder: (BuildContext context, int index) {
                      return ListTile(
                        leading: CircleAvatar(
                          backgroundImage:
                              NetworkImage(snapshot.data[index].image),
                        ),
                        title: Text(snapshot.data[index].name),
                        subtitle: Text(snapshot.data[index].market_cap_rank),
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      Another(snapshot.data[index])));
                        },
                      );
                    },
                  );
                }
              }),
        ));
  }
}
