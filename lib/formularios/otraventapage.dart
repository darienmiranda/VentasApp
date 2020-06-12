import 'dart:convert';

import 'package:VentasApp/main.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
//import 'package:image_picker/image_picker.dart';

class anadirproducto extends StatefulWidget {
  @override
  _anadirproductoState createState() => _anadirproductoState();
}

class _anadirproductoState extends State<anadirproducto> {
  final _formKey = GlobalKey<FormState>();
  /*File _image;
  var _formKey = GlobalKey<FormState>();
  TextEditingController nombreimg = new TextEditingController();*/
  //---------------
  TextEditingController nombreproducto = TextEditingController();
  TextEditingController descripcionproducto = TextEditingController();
  TextEditingController precioproducto = TextEditingController();
  TextEditingController categoriaproducto = TextEditingController();

  

  Future <List> _guardarventa (BuildContext context) async{
    final guardaventa = await http.post("http://192.168.0.108/VentasApp/registrar_venta.php",body: {
      "persona_email": username,
      "nom_producto": nombreproducto.text,
      "des_producto": descripcionproducto.text,
      "precio": precioproducto.text,
      "categoria_id": categoriaproducto.text,
    });

    var catregistradas = json.decode(guardaventa.body);

    if(catregistradas.length == 0)
    {
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
          content: Text('esta categoria no esta registrada'),
          actions: <Widget>[
            FlatButton(
              child: Text(
                'Ok',
                style: TextStyle(color: Colors.black, fontWeight: FontWeight.w300)
              ),
              onPressed: (){
                Navigator.pop(context, 'otracategoriapage');
              },
            )
          ],
        ),
      );
    }else{
      guardarventa(context);
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16)
          ),
          elevation:0,
          backgroundColor: Colors.green[200],
          title: Text('Exitoso'),
          content: Text('Su venta se registro con exito!'),
          actions: <Widget>[
            FlatButton(
              child: Text(
                'Ok',
                style: TextStyle(color: Colors.black, fontWeight: FontWeight.w300)
              ),
              onPressed: (){
                Navigator.of(context).pushNamedAndRemoveUntil(
                  'menuprincipal', 
                  (Route<dynamic> route) => false
                );
              },
            )
          ],
        ),
      );
    } 
  }

   Widget RegistrarNombreProducto(){
    return Padding(
      padding: const EdgeInsets.only(top: 0),
        child: TextFormField(
          validator: (value) {
              if (value.isEmpty) {
                return 'Llenar este campo';
              }
            },
          controller: nombreproducto,
          decoration: InputDecoration(
            prefixIcon: Icon(
              Icons.add_shopping_cart,
              color: Colors.black,
            ),
            labelStyle: TextStyle(color: Colors.black),
            labelText: "Nombre del producto",
          ),
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.w300),
          maxLength: 255,
        ),
    );
  }

  Widget RegistrarDescripcionProducto(){
    return Padding(
      padding: const EdgeInsets.only(top: 0),
        child: TextFormField(
          validator: (value) {
            if (value.isEmpty) {
              return 'Llenar este campo';
            }
          },
          controller: descripcionproducto,
          decoration: InputDecoration(
            prefixIcon: Icon(
              Icons.description ,
              color: Colors.black,
            ),
            labelStyle: TextStyle(color: Colors.black),
            labelText: "Descripcion del producto",
          ),
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.w300),
          maxLength: 255,
          maxLines: 3,
        ),
    );
  }

  Widget RegistrarPrecioProducto(){
    return Padding(
      padding: const EdgeInsets.only(top: 0),
      child: TextFormField(
        validator: (value) {
          if (value.isEmpty) {
            return 'Llenar este campo';
          }
        },
        controller: precioproducto,
        decoration: InputDecoration(
          prefixIcon: Icon(
            Icons.monetization_on,
            color: Colors.black,
          ),  
          labelStyle: TextStyle(color: Colors.black),
          labelText: "Precio del producto",
        ),
        keyboardType: TextInputType.number,
        style: TextStyle(color: Colors.
        black, fontWeight: FontWeight.w300),
        maxLength: 50,
      ),
    );
  }

  Widget RegistrarCategoriaProducto(){
    return Padding(
      padding: const EdgeInsets.only(top: 0),
      child: TextFormField(
        validator: (value) {
          if (value.isEmpty) {
            return 'Llenar este campo';
          }
        },
        controller: categoriaproducto,
        decoration: InputDecoration(
          prefixIcon: Icon(
            Icons.category,
            color: Colors.black,
          ),  
          labelStyle: TextStyle(color: Colors.black),
          labelText: "Categoria del producto",
        ),
        keyboardType: TextInputType.number,
        style: TextStyle(color: Colors.
        black, fontWeight: FontWeight.w300),
        maxLength: 50,
      ),
    );
  }
  Widget guardarventa(BuildContext context){
    return Container(
      padding: const EdgeInsets.only(top: 15),
      child: RaisedButton(
        textColor: Colors.black,
        child: Text('Guardar Venta'),
        shape: RoundedRectangleBorder(borderRadius: new BorderRadius.circular(30.0)),
        color: Colors.yellow[300],
        onPressed: (){
          if (_formKey.currentState.validate()) {
            _guardarventa(context);
          }
        },
      ));
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Scaffold(
        appBar: new AppBar(
          title: new Text('Añadir Nueva Venta'),
        ),
        body: Container(
        padding: const EdgeInsets.only(top: 30),
        child: ListView(children:[
          Image.asset(
            'assets/images/carrito.png',
            width: 150,
            height: 150,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: RegistrarNombreProducto(),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: RegistrarDescripcionProducto(),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: RegistrarPrecioProducto(),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: RegistrarCategoriaProducto(),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: guardarventa(context),
          ),
        ]),
      ),
      ),
    );
  }
}