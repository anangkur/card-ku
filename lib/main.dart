import 'package:flutter/material.dart';
import 'detail.dart';
import 'model/card.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'model/response.dart';

void main() => runApp(MyApp());

Future<Response> fetchCard() async{
  final response = await http.get('https://db.ygoprodeck.com/api/v5/cardinfo.php');
  if(response.statusCode == 200){
    return Response.fromJsonMap(json.decode(response.body));
  }else{
    throw Exception('Failed to load data');
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Final Task Eudeka',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Main Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: _GridView(data: fetchCard(),),
    );
  }
}

class _GridView extends StatelessWidget{

  final Future<Response> data;
  _GridView({Key key, this.data}): super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
      itemBuilder: (context, index){
        return FutureBuilder<Response> (
          future: data,
          builder: (context, snapshot){
            if(!snapshot.hasData){
              return Center(
                child: CircularProgressIndicator(),
              );
            }else if(snapshot.hasError){
              return Text("${snapshot.error}");
            }else{
              return _CardItemView(data: YugiohCard.fromJsonMap(snapshot.data.data[index]),);
            }
          },
        );
      }
    );
  }
}

class _CardItemView extends StatelessWidget{

  final YugiohCard data;

  _CardItemView({Key key, this.data}): super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => DetailApp(data: data,)),
        );
      },
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Expanded(
                child: Image.network(data.card_images[0].image_url_small,),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(top: 8),
                    child: Text(
                      data.name,
                      style: TextStyle(fontSize: 16),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}