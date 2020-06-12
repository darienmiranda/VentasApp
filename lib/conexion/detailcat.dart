import 'dart:convert';

import 'package:VentasApp/menus/menuprincipal.dart';
import 'package:flutter/material.dart';
 import 'package:http/http.dart' as http;

class DetailCat extends StatefulWidget {
  List list;
  int index;
  DetailCat({this.list, this.index});
  @override
  _DetailCatState createState() => _DetailCatState();
}

class _DetailCatState extends State<DetailCat> {

  void deletedcat() async{
    final categoriauso = await http.post("http://192.168.0.108/VentasApp/borrar_categoria.php", body: {
      'id_categoria': widget.list[widget.index]['id_categoria']
    });

    var categoriaenuso = json.decode(categoriauso.body);
    if(categoriaenuso.length == 0)
    {
        showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16)
          ),
          elevation:0,
          backgroundColor: Colors.green[200],
          title: Text('Exitoso!'),
          content: Text('Categoria Eliminada Con Exito'),
          actions: <Widget>[
            FlatButton(
              child: Text(
                'Ok',
                style: TextStyle(color: Colors.black, fontWeight: FontWeight.w300)
              ),
              onPressed: (){
                Navigator.of(context).push(
                  new MaterialPageRoute(builder: (BuildContext context)  => menupricipal())
                );
              },
            )
          ],
        ),
      );
    }else{
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16)
          ),
          elevation:0,
          backgroundColor: Colors.red[200],
          title: Text('ERROR'),
          content: Text('No puedes eliminar esta categoria porque esta en uso'),
          actions: <Widget>[
            FlatButton(
              child: Text(
                'Ok',
                style: TextStyle(color: Colors.black, fontWeight: FontWeight.w300)
              ),
              onPressed: (){
                Navigator.pop(context);
              },
            )
          ],
        ),
      );
    }
  }

  void Confirmar(){
    AlertDialog alertDialog = AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16)
      ),
      elevation:0,
      backgroundColor: Colors.yellow,
      content: new Text("Seguro que desea eliminar la categoria '${widget.list[widget.index]['nom_categoria']}'"),
      actions: <Widget>[
        new RaisedButton(
          child: new Text('Si, Elimiar', style: new TextStyle(color: Colors.black),),
          color: Colors.green,
          onPressed: (){
            deletedcat();
          },
        ),
        new RaisedButton(
          child: new Text('No', style: new TextStyle(color: Colors.black),),
          color: Colors.red,
          onPressed: ()  => Navigator.pop(context)
        )
      ],
    );
    showDialog(
      context: context,
      child: alertDialog,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(title: new Text("${widget.list[widget.index]['nom_categoria']}")),
       body: new Container(
        height: 270.0, 
        padding: const EdgeInsets.all(20.0),
        child: new Card(
          child: new Center(
            child: new Column(
              children: <Widget>[

                new Padding(padding: const EdgeInsets.only(top: 30.0),),
                new Text("Identificador de categoria:", style: new TextStyle(fontSize: 20.0),),
                new Text("${widget.list[widget.index]['id_categoria']}", style: new TextStyle(fontSize: 15.0),),
                Divider(),
                new Text("Nombre de categoria:", style: new TextStyle(fontSize: 20.0),),
                new Text("${widget.list[widget.index]['nom_categoria']}", style: new TextStyle(fontSize: 15.0),),
                new Padding(padding: const EdgeInsets.only(top: 30.0),),

                new Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                  new RaisedButton(
                    child: new Text("ELIMINAR"),                  
                    color: Colors.redAccent,
                    shape: new RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(30.0)),
                    onPressed: ()=>Confirmar(),                
                  ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}