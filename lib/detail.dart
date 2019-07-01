import 'package:flutter/material.dart';
import 'model/card.dart';

void main() => runApp(DetailApp());

class DetailApp extends StatelessWidget{

  final YugiohCard data;

  const DetailApp({Key key, this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(data.name),),
      body: ListView(
        children: <Widget>[
          Image.network(data.card_images[0].image_url),
          Container(
            margin: EdgeInsets.symmetric(vertical: 8),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(data.name, style: TextStyle(fontSize: 24),),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: <Widget>[
                Text(data.type),
                Text(' | '),
                Text(data.race),
              ],
            )
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(data.desc),
          ),
          Container(
            margin: EdgeInsets.symmetric(vertical: 8),
          ),
        ],
      ),
    );
  }
}