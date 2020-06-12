import 'dart:convert';

import 'package:VentasApp/conexion/detailproductopage.dart';
import 'package:VentasApp/formularios/otraventapage.dart';
import 'package:VentasApp/main.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class misventaspage extends StatelessWidget {
  Future<List> getventasusuario() async{
    final trearventas = await http.post("http://192.168.0.108/VentasApp/getventasusuario.php", body:{
      'persona_email': username
    });
    return json.decode(trearventas.body);
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
          builder: (BuildContext context) => new anadirproducto(),
        )),
      ),

      body: new FutureBuilder<List>(
        future: getventasusuario(),
        builder: (context, snapshot){
          if(snapshot.hasError) print(snapshot.error);
          return snapshot.hasData
          ? new ListaProductos(
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

class ListaProductos extends StatelessWidget {
  final List list;
  ListaProductos({this.list});

  
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
                  style: TextStyle(fontSize: 25.0, color: Colors.orangeAccent),
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