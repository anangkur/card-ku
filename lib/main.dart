import 'package:flutter/material.dart';
import 'detail.dart';
import 'model/card.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'model/response.dart';
import 'dart:io';

void main() => runApp(MyApp());

Future<Response> fetchCard() async{
  final response = await http.get('https://db.ygoprodeck.com/api/v7/cardinfo.php?num=100&offset=100');
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
        actions: <Widget>[
          PopupMenuButton<int>(
            itemBuilder: (context) => [
              PopupMenuItem<int>(
                child: Text('Keluar'),
                value: 1,
              )
            ],
            onSelected: (value){
              _showDialog();
            },
          )
        ],
      ),
      body: _GridView(data: fetchCard(),),
    );
  }

  void _showDialog(){
    showDialog(
      context: context,
      builder: (BuildContext context){
        return AlertDialog(
          title: Text('Perhatian'),
          content: Text('Apakah anda yakin ingin keluar?'),
          actions: <Widget>[
            FlatButton(
              onPressed: (){
                exit(0);
              },
              child: Text('Ya')
            ),
            FlatButton(
              onPressed: (){
                Navigator.pop(context);
              },
              child: Text('Tidak')
            )
          ],
        );
      }
    );
  }
}

class _GridView extends StatelessWidget{

  final Future<Response> data;
  _GridView({Key key, this.data}): super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Response> (
      future: data,
      builder: (context, snapshot){
        if(snapshot.connectionState == ConnectionState.done){
          if(snapshot.hasError) {
            return Text("${snapshot.error}");
          } else {
            return GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
              itemBuilder: (context, index){
                return _CardItemView(data: YugiohCard.fromJsonMap(snapshot.data.data[index]),);
              },
              itemCount: snapshot.data.data.length,
            );
          }
        }else{
          return LinearProgressIndicator();
        }
      },
    );
  }
}

class _CardItemView extends StatelessWidget{

  final YugiohCard data;

  _CardItemView({Key key, this.data}): super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: (){
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => DetailApp(data: data,)),
          );
        },
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
      )
    );
  }
}