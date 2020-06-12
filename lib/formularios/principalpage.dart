import 'dart:convert';

import 'package:VentasApp/conexion/detailproductopage.dart';
import 'package:VentasApp/conexion/detalleproducto.dart';
import 'package:VentasApp/main.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:VentasApp/formularios/model.dart';

class principalpage extends StatefulWidget {
  @override
  _principalpageState createState() => _principalpageState();
}

class _principalpageState extends State<principalpage> {
  List<Posts> _list = [];
  List<Posts> _search = [];
  var loading = false;

  final String comprobar = "";

  Future<Null> fetchData() async {
    setState(() {
      loading = true;
    });
    _list.clear();
    final response =  await http.post("http://192.168.0.108/VentasApp/getventas.php",body: {
      'buscar': controller.text
    });
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      setState(() {
        for (Map i in data) {
          _list.add(Posts.formJson(i));
          loading = false;
        }
      });
    }
  }
  TextEditingController controller = new TextEditingController();

  onSearch(text) async {
    _search.clear();
    if (text.isEmpty) {
      setState(() {});
      return;
    }

    _list.forEach((f) {
      if (f.nombre.contains(text) || f.id.toString().contains(text))
        _search.add(f);
    });

    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
          child: Column(children: <Widget>[
            Container(
              padding: EdgeInsets.all(10.0),
              color: Colors.yellowAccent,
              child: Card(
                child:ListTile(
                  leading: Icon(Icons.search),
                  title: TextField(
                    controller: controller,  //
                    onChanged: onSearch,
                    decoration: InputDecoration(
                      hintText: "Buscar",
                      border: InputBorder.none
                    ),
                  ),
                  trailing: IconButton(
                    onPressed: (){
                      controller.clear();
                      onSearch(controller);
                    },
                    icon: Icon(Icons.cancel),
                  ),
                ),
              ),
            ),
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
            loading 
            ? Center (
              child: CircularProgressIndicator(),
            )
            :Expanded(
              child: _search.length != 0 || controller.text.isNotEmpty
              ? ListView.builder(
                itemCount: _search.length,
                itemBuilder: (context, i) {
                  final a = _search[i];
                  return Container(
                    padding: const EdgeInsets.all(1.0),
                    child: new GestureDetector(
                      onTap: () => Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (BuildContext context) => new DetalleProducto(
                            list: _list,
                            index: i,
                            comprobar: a.eusuario,
                          ),
                        ),
                      ),

                      child: new Card(
                        child: new ListTile(
                          title: new Text(
                            a.nombre,
                            style: TextStyle(fontSize: 25.0, color: Colors.black),
                          ),
                          subtitle: new Text(
                            a.descripcion,
                            style: TextStyle(fontSize: 10.0, color: Colors.black38),
                          ),
                          leading: new Icon(
                            Icons.add_shopping_cart,
                            size: 60.0,
                            color: Colors.black,
                          )
                        ),
                      ),
                    ) ,
                  );
                },
              )
              : ListView.builder(
                itemCount: _list.length,
                itemBuilder: (context, i) {
                  final a = _list[i];
                  return Container(
                    padding: const EdgeInsets.all(1.0),
                    child: new GestureDetector(
                      onTap: () => Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (BuildContext context) => new DetalleProducto(
                            list: _list,
                            index: i,
                            comprobar: a.eusuario,
                          ),
                        ),
                      ),

                      child: new Card(
                        child: new ListTile(
                          title: new Text(
                            a.nombre,
                            style: TextStyle(fontSize: 25.0, color: Colors.black),
                          ),
                          subtitle: new Text(
                            a.descripcion,
                            style: TextStyle(fontSize: 10.0, color: Colors.black38),
                          ),
                          leading: new Icon(
                            Icons.add_shopping_cart,
                            size: 60.0,
                            color: Colors.black,
                          )
                        ),
                      ),
                    ) ,
                    /*padding: EdgeInsets.all(10.0),
                    child: Column(
                      crossAxisAlignment:
                        CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          a.nombre,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18.0),
                        ),
                        SizedBox(
                          height: 4.0,
                        ),
                        Text(a.descripcion),
                      ],
                    )*/
                  );
                            },
              ),
            )
          ]),
      ),
    );
  }
}
