import 'dart:convert';

import 'package:VentasApp/main.dart';
import 'package:VentasApp/menus/menuprincipal.dart';
import 'package:flutter/material.dart';
import 'package:VentasApp/formularios/principalpage.dart';
 import 'package:http/http.dart' as http;

class DetailProducto extends StatefulWidget {
  List list;
  int index;
  DetailProducto({this.list, this.index});
  @override
  _DetailProductoState createState() => _DetailProductoState();
}

class _DetailProductoState extends State<DetailProducto> {

  void deletedproducto(){
    http.post("http://192.168.0.108/VentasApp/borrar_producto.php", body: {
      'id_producto': widget.list[widget.index]['id_producto'],
    });
  }
  
  Future <List> _validarproductoparacarritonorepetido(BuildContext context) async{
    final carritonorepetido = await http.post("http://192.168.0.108/VentasApp/registrar_compra.php",body: {
      'email_id': username,
      'producto_id': widget.list[widget.index]['id_producto']
    });
  
    var ventasregistradas = json.decode(carritonorepetido.body);
    if(ventasregistradas.length == 0){
      anadidoexitoso();
    }else{
      errordecarritoyaesta();
    }
  }

  void anadidoexitoso(){
    AlertDialog alertDialog = AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16)
      ),
      elevation:0,
      backgroundColor: Colors.green[200],
      content: new Text("Añadido Exitosamente"),
      actions: <Widget>[
        new RaisedButton(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20)
          ),
          child: new Text('Ok', style: new TextStyle(color: Colors.black),),
          color: Colors.green[200],
          onPressed: ()  => Navigator.pop(context)
        )
      ],
    );
    showDialog(
      context: context,
      barrierDismissible: false,
      child: alertDialog,
    );
  }

  void validarproductoparaeleiminar() async{
    if(widget.list[widget.index]['persona_email'] == username){
      Confirmareliminacion();
    }else{
      errordeeliminacion();
    }
  }

  void validarproductoparacarrito() async{
    if(widget.list[widget.index]['persona_email'] != username){
      Confirmarcarrito();
    }else{
      errordecarrito();
    }
  }

  void errordecarritoyaesta(){
    AlertDialog alertDialog = AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16)
      ),
      elevation:0,
      backgroundColor: Colors.red[200],
      content: new Text("Ya Tienes Este Producto En Favoritos"),
      actions: <Widget>[
        new RaisedButton(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20)
          ),
          child: new Text('Ok', style: new TextStyle(color: Colors.black),),
          color: Colors.red[200],
          onPressed: ()  => Navigator.pop(context)
        )
      ],
    );
    showDialog(
      context: context,
      barrierDismissible: false,
      child: alertDialog,
    );
  }

  void errordeeliminacion(){
    AlertDialog alertDialog = AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16)
      ),
      elevation:0,
      backgroundColor: Colors.yellow[200],
      content: new Text("No Puedes Eliminar Este Producto Porque Tu No Publicaste"),
      actions: <Widget>[
        new RaisedButton(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20)
          ),
          child: new Text('Ok', style: new TextStyle(color: Colors.black),),
          color: Colors.red[200],
          onPressed: ()  => Navigator.pop(context)
        )
      ],
    );
    showDialog(
      context: context,
      barrierDismissible: false,
      child: alertDialog,
    );
  }

  void errordecarrito(){
    AlertDialog alertDialog = AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16)
      ),
      elevation:0,
      backgroundColor: Colors.yellow[200],
      content: new Text("No Puedes añadir este producto a favoritos porque lo publicaste tú"),
      actions: <Widget>[
        new RaisedButton(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20)
          ),
          child: new Text('Ok', style: new TextStyle(color: Colors.black),),
          color: Colors.red[200],
          onPressed: ()  => Navigator.pop(context)
        )
      ],
    );
    showDialog(
      context: context,
      barrierDismissible: false,
      child: alertDialog,
    );
  }
  void Confirmareliminacion(){
    AlertDialog alertDialog = AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16)
      ),
      elevation:0,
      backgroundColor: Colors.yellow,
      content: new Text("Seguro que desea eliminar el producto: '${widget.list[widget.index]['nom_producto']}'"),
      actions: <Widget>[
        new RaisedButton(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20)
          ),
          child: new Text('Si, Elimiar', style: new TextStyle(color: Colors.black),),
          color: Colors.green,
          onPressed: (){
            deletedproducto();
            Navigator.of(context).push(
              new MaterialPageRoute(builder: (BuildContext context)  => menupricipal())
            );
          },
        ),
        new RaisedButton(
          child: new Text('No', style: new TextStyle(color: Colors.black),),
          color: Colors.red,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20)
          ),
          onPressed: ()  => Navigator.pop(context)
        )
      ],
    );
    showDialog(
      context: context,
      barrierDismissible: false,
      child: alertDialog,
    );
  }

  void Confirmarcarrito(){
    AlertDialog alertDialog = AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16)
      ),
      elevation:0,
      backgroundColor: Colors.yellow,
      content: new Text("Seguro que desea añadir el producto: '${widget.list[widget.index]['nom_producto']}' a favoritos"),
      actions: <Widget>[
        new RaisedButton(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20)
          ),
          child: new Text('Si, añadir', style: new TextStyle(color: Colors.black),),
          color: Colors.green,
          onPressed: (){
            _validarproductoparacarritonorepetido(context);
          },
        ),
        new RaisedButton(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20)
          ),
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


  Widget buttoneliminar(){
    return new Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          new RaisedButton(
            child: new Text("ELIMINAR"),                  
            color: Colors.redAccent,
            shape: new RoundedRectangleBorder(
              borderRadius: new BorderRadius.circular(30.0)
            ),
            onPressed: ()=>validarproductoparaeleiminar(), 
          ),               
        ],
      );
  }

  Widget buttoncarrito(){
    return new Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          new RaisedButton(
            child: new Text("Añadir A Favoritos"),                  
            color: Colors.greenAccent,
            shape: new RoundedRectangleBorder(
              borderRadius: new BorderRadius.circular(30.0)
            ),
            onPressed: ()=>validarproductoparacarrito(),                
          ),
        ],
      );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(title: new Text("${widget.list[widget.index]['nom_producto']}")),
       body: new Container(
        //height: 270.0, 
        padding: const EdgeInsets.all(15.0),
        child: new Card(
          child: new Center(
            child: new Column(
              children: <Widget>[

                new Padding(padding: const EdgeInsets.only(top: 30.0),),
                new Text("Identificador de venta:", style: new TextStyle(fontSize: 20.0),),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: new Text("${widget.list[widget.index]['id_producto']}", style: new TextStyle(fontSize: 15.0),),
                ),
                Divider(),

                new Padding(padding: const EdgeInsets.only(top: 5.0),),
                new Text("Nombre: ", style: new TextStyle(fontSize: 20.0),),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: new Text("${widget.list[widget.index]['nom_producto']}", style: new TextStyle(fontSize: 15.0),),
                ),
                Divider(),

                new Padding(padding: const EdgeInsets.only(top: 5.0),),
                new Text("Descripcion:", style: new TextStyle(fontSize: 20.0),),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: new Text("${widget.list[widget.index]['des_producto']}", style: new TextStyle(fontSize: 15.0),),
                ),
                Divider(),

                new Padding(padding: const EdgeInsets.only(top: 5.0),),
                new Text("Precio:", style: new TextStyle(fontSize: 20.0),),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: new Text("${widget.list[widget.index]['precio']}", style: new TextStyle(fontSize: 15.0),),
                ),
                Divider(),

                new Padding(padding: const EdgeInsets.only(top: 5.0),),
                new Text("Categoria:", style: new TextStyle(fontSize: 20.0),),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: new Text("${widget.list[widget.index]['categoria_id']}", style: new TextStyle(fontSize: 15.0),),
                ),
                Divider(),

                new Padding(padding: const EdgeInsets.only(top: 5.0),),
                new Text("Fecha de publicaion:", style: new TextStyle(fontSize: 20.0),),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: new Text("${widget.list[widget.index]['fecha_producto']}", style: new TextStyle(fontSize: 15.0),),
                ),
                Divider(),
                
                buttoncarrito(),
                Divider(),
                buttoneliminar(),

                
              ],
            ),
          ),
        ),
      ),
    );
  }
}