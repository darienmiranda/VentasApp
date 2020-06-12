import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:http/http.dart' as http;
class anadircategoria extends StatefulWidget {
  @override
  _anadircategoriaState createState() => _anadircategoriaState();
}

class _anadircategoriaState extends State<anadircategoria> {
  TextEditingController nombredecategoria = new TextEditingController();
  final _formKey = GlobalKey<FormState>();

  Future <List> _guardarcat(BuildContext context) async{
    final regitrarcat = await http.post("http://192.168.0.108/VentasApp/registrar_categoria.php",body: {
      "nom_categoria": nombredecategoria.text,
    });

    var catregistradas = json.decode(regitrarcat.body);

    if(catregistradas.length != 0)
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
          content: Text('esta categoria ya esta registrada'),
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
          content: Text('esta categoria se registro con exito!'),
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
  Widget nomcategoria(){
    return Padding(
      padding: const EdgeInsets.only(top: 40),
        child: TextFormField(
          validator: (value) {
            if (value.isEmpty) {
              return 'No se permiten campos vacios';
            }
          },
          textCapitalization: TextCapitalization.sentences,
          controller: nombredecategoria,
          decoration: InputDecoration(
            prefixIcon: Icon(
              Icons.add_circle_outline,
              color: Colors.black,
            ),
            labelStyle: TextStyle(color: Colors.black),
            labelText: "Nombre",
          ),
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.w300),
        ),
    );
  }

  Widget guardarcategoria(BuildContext context){
    return Container(
      padding: const EdgeInsets.only(top: 15),
      child: RaisedButton(
        textColor: Colors.black,
        child: Text('Guardar Categoria'),
        shape: RoundedRectangleBorder(borderRadius: new BorderRadius.circular(30.0)),
        color: Colors.yellow[300],
        onPressed: (){
          if (_formKey.currentState.validate()) {
            _guardarcat(context);
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
          title: new Text('Añadir Categoria'),
        ),
        body: Container(
          child: ListView(children:[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 45),
              child: nomcategoria(),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 45),
              child: guardarcategoria(context),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 200),
              child: SizedBox(
                height: 300.0,
                //width: 400.0,
                child: Carousel(
                  images: [
                    AssetImage('assets/images/carrusel1.jpg'),
                    AssetImage('assets/images/carrusel2.jpg'),
                    AssetImage('assets/images/carrusel3.jpg'),
                    ExactAssetImage("assets/images/carrusel4.jpg")
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
          ]),
        ),
      ),
    );
  }
}