import 'dart:convert';

import 'package:VentasApp/main.dart';
import 'package:VentasApp/menus/menuprincipal.dart';
import 'package:flutter/material.dart';
 import 'package:http/http.dart' as http;

 class DetalleProducto extends StatefulWidget {
   List list;
   String index;
   String comprobar;

   DetalleProducto({this.index, this.list, this.comprobar});
   @override
   _DetalleProductoState createState() => _DetalleProductoState();
 }
 
 class _DetalleProductoState extends State<DetalleProducto> {
  get producto => "4";
  get comprobar => "prueba@gmail.com";

   Future<List> getperfil(producto) async{
    final traerventa = await http.post("http://192.168.0.108/VentasApp/consultar_ventas.php", body:{
      'id': producto//widget.list[widget.producto]['idproducto']
    });
    return json.decode(traerventa.body);
  }
  Future <List> _validarproductoparacarritonorepetido(BuildContext context) async{
    final carritonorepetido = await http.post("http://192.168.0.108/VentasApp/registrar_compra.php",body: {
      'email_id': username,
      'producto_id': producto
    });
  
    var ventasregistradas = json.decode(carritonorepetido.body);
    if(ventasregistradas.length == 0){
      anadidoexitoso(context);
    }else{
      errordecarritoyaesta(context);
    }
  }

  void anadidoexitoso(BuildContext context){
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

  void validarproductoparacarrito(BuildContext context) async{
    if( comprobar != username){
      Confirmarcarrito(context);
    }else{
      errordecarrito(context);
    }
  }

  void errordecarrito(BuildContext context){
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

  void Confirmarcarrito(BuildContext context){
    AlertDialog alertDialog = AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16)
      ),
      elevation:0,
      backgroundColor: Colors.yellow,
      content: new Text("Seguro que desea añadir el producto a favoritos"),
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

  void errordecarritoyaesta(BuildContext context){
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: new FloatingActionButton(
        child: new Icon(
          Icons.favorite,
          color: Colors.redAccent,
        ),
        backgroundColor: Colors.yellow,
        onPressed: () {
          validarproductoparacarrito(context);
        }
      ),

      body: new FutureBuilder<List>(
        future: getperfil(producto),
        builder: (context, snapshot){
          if(snapshot.hasError) print(snapshot.error);
          return snapshot.hasData
          ? new ListaPro(
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

class ListaPro extends StatelessWidget {
  final List list;
  final int producto;
  ListaPro({this.list, this.producto});

  
  @override
  Widget build(BuildContext context) {
    return new ListView.builder(
      itemCount: list == null ? 0: list.length,
      itemBuilder: (context, i){
        return new Container(
          padding: const EdgeInsets.all(1.0),
          child: new GestureDetector(
            child: new Card(
              child: new Column(
                children: <Widget>[
                  Image.asset(
                  'assets/images/carrito.png',
                  width: 200,
                  height: 200,),

                  new Padding(padding: const EdgeInsets.only(top: 30.0),),
                  new Text("Identificador de Venta:", style: new TextStyle(fontSize: 20.0),),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: new Text(list[i]['id_producto'], style: new TextStyle(fontSize: 15.0),),
                  ),
                  Divider(),

                  new Padding(padding: const EdgeInsets.only(top: 5.0),),
                  new Text("Nombre: ", style: new TextStyle(fontSize: 20.0),),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: new Text(list[i]['nom_producto'], style: new TextStyle(fontSize: 15.0),),
                  ),
                  Divider(),

                  new Text("Descripcion: ", style: new TextStyle(fontSize: 20.0),),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: new Text(list[i]['des_producto'], style: new TextStyle(fontSize: 15.0),),
                  ),
                  Divider(),

                  new Text("Precio: ", style: new TextStyle(fontSize: 20.0),),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: new Text(list[i]['precio'], style: new TextStyle(fontSize: 15.0),),
                  ),
                  Divider(),

                  new Text("Categoria: ", style: new TextStyle(fontSize: 20.0),),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: new Text(list[i]['categoria_id'], style: new TextStyle(fontSize: 15.0),),
                  ),
                  Divider(),

                  new Text("Fecha De Publicacion: ", style: new TextStyle(fontSize: 20.0),),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: new Text(list[i]['fecha_producto'], style: new TextStyle(fontSize: 15.0),),
                  ),
                  Divider(),

                  new Padding(padding: const EdgeInsets.only(bottom: 10),),

                  
                ],
            ),
            ),
            )
          );
      },
    );
  }
}