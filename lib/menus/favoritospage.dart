import 'dart:convert';

import 'package:VentasApp/conexion/detailproductopage.dart';
import 'package:VentasApp/main.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class misfavoritos extends StatelessWidget {
  Future<List> gefavoritosusuario() async{
    final trearfavoritos = await http.post("http://192.168.0.108/VentasApp/gefavoritos.php", body:{
      'email': username
    });
    return json.decode(trearfavoritos.body);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: new FutureBuilder<List>(
        future: gefavoritosusuario(),
        builder: (context, snapshot){
          if(snapshot.hasError) print(snapshot.error);
          return snapshot.hasData
          ? new ListaFavoritos(
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

class ListaFavoritos extends StatelessWidget {
  final List list;
  ListaFavoritos({this.list});

  
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
                builder: (BuildContext context) => new DetailProducto(
                  list: list,
                  index: i,
                ),
              )
            ),
            child: new Card(
              color: Colors.yellow[100],
              child: new ListTile(
                title: new Text(
                  list[i]['nom_producto'],
                  style: TextStyle(fontSize: 25.0, color: Colors.black),
                ),
                subtitle: new Text(
                  list[i]['des_producto'],
                  style: TextStyle(fontSize: 10.0, color: Colors.black38),
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