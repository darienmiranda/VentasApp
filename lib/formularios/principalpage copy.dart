import 'dart:convert';

import 'package:VentasApp/conexion/detailproductopage.dart';
import 'package:VentasApp/main.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class principalpage extends StatelessWidget {
  Future<List> getventas() async{
    final trearventas = await http.post("http://192.168.0.108/VentasApp/getventas.php", body:{
      'persona_email': username
    });
    
    
    return json.decode(trearventas.body);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(  
        body: new FutureBuilder<List>(  
          future: getventas(),
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
        ),
        /*
        body: Container(
          child: ListView(children:[
            Padding(
                padding: const EdgeInsets.only(top: 0),
                child: SizedBox(
                  height: 250.0,
                  //width: 400.0,
                  child: Carousel(
                    images: [
                      AssetImage('assets/images/carrusel4.jpg'),
                      AssetImage('assets/images/carrusel1.jpg'),
                      AssetImage('assets/images/carrusel3.jpg'),
                      ExactAssetImage("assets/images/carrusel2.jpg")
                    ],
                    dotSize: 4.0,
                    dotSpacing: 30.0,
                    dotColor: Colors.lightGreenAccent,
                    indicatorBgPadding: 5.0,
                    dotBgColor: Colors.purple.withOpacity(0.5),
                    borderRadius: false,
                  )
                ),
              ),
          ])
        ),*/
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