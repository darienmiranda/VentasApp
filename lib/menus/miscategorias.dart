import 'dart:convert';

import 'package:VentasApp/conexion/detailcat.dart';
import 'package:VentasApp/formularios/otracategoriapage.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class miscategoriaspage extends StatelessWidget {

  Future<List> getcategorias() async{
    final trearcategorias = await http.get("http://192.168.0.108/VentasApp/getcategorias.php");
    return json.decode(trearcategorias.body);

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: new FloatingActionButton(
        child: new Icon(
          Icons.add,
          color: Colors.redAccent,
        ),
        backgroundColor: Colors.yellow,
        onPressed: () => Navigator.of(context).push(new MaterialPageRoute(
          builder: (BuildContext context) => new anadircategoria(),
        )),
      ),

      body: new FutureBuilder<List>(
        future: getcategorias(),
        builder: (context, snapshot){
          if(snapshot.hasError) print(snapshot.error);
          return snapshot.hasData
          ? new ListaCategorias(
            list: snapshot.data
          )
          : new Center(
            child: new CircularProgressIndicator(),
          );
        },
      )
    );
  }
}

class ListaCategorias extends StatelessWidget {
  final List list;
  ListaCategorias({this.list});

  
  @override
  Widget build(BuildContext context) {
    return new ListView.builder(
      itemCount: list == null ? 0: list.length,
      itemBuilder: (context, i){
        return new Container(
          padding: const EdgeInsets.all(1.0),
          child: new GestureDetector(
            onTap: () => Navigator.of(context).push(
              MaterialPageRoute(
                builder: (BuildContext context) => new DetailCat(
                  list: list,
                  index: i,
                ),
              )
            ),
            child: new Card(
              color: Colors.yellow[100],
              child: new ListTile(
                title: new Text(
                  list[i]['nom_categoria'],
                  style: TextStyle(fontSize: 20.0, color: Colors.black),
                ),
                leading: new Icon(
                  Icons.forward,
                  size: 30.0,
                  color: Colors.black,
                )
              ),
            ),
            )
          );
      },
    );
  }
}