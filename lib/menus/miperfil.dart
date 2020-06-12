import 'dart:convert';
import 'package:VentasApp/main.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class MiPerfil extends StatefulWidget {
  _MiPerfilState createState() => _MiPerfilState();
}

class _MiPerfilState extends State<MiPerfil> {
  Future<List> getperfil() async{
    final trearperfil = await http.post("http://192.168.0.108/VentasApp/perfil.php", body:{
      'email': username
    });
    return json.decode(trearperfil.body);
  }

  void cerrarsesion(BuildContext context){
    AlertDialog alertDialog = AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16)
      ),
      elevation:0,
      backgroundColor: Colors.yellow[200],
      content: new Text("¿Desea cerrar sesion?"),
      actions: <Widget>[
        new RaisedButton(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20)
          ),
          child: new Text('Si', style: new TextStyle(color: Colors.black),),
          color: Colors.green[200],
          onPressed: (){
            Navigator.of(context).pushNamedAndRemoveUntil(
              'main', 
              (Route<dynamic> route) => false
            );
          }
        ),
        new RaisedButton(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20)
          ),
          child: new Text('No', style: new TextStyle(color: Colors.black),),
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
          Icons.close,
          color: Colors.black,
        ),
        backgroundColor: Colors.red,
        onPressed: () {
          cerrarsesion(context);
        }
      ),
      body: new FutureBuilder<List>(
        future: getperfil(),
        builder: (context, snapshot){
          if(snapshot.hasError) print(snapshot.error);
          return snapshot.hasData
          ? new ListaPerfil(
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
class ListaPerfil extends StatelessWidget {
  final List list;
  ListaPerfil({this.list});

  
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
                  'assets/images/logo.png',
                  width: 200,
                  height: 200,),

                  new Padding(padding: const EdgeInsets.only(top: 30.0),),
                  new Text("Identificador de usuario:", style: new TextStyle(fontSize: 20.0),),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: new Text(list[i]['id_usuario'], style: new TextStyle(fontSize: 15.0),),
                  ),
                  Divider(),

                  new Padding(padding: const EdgeInsets.only(top: 5.0),),
                  new Text("Nombre: ", style: new TextStyle(fontSize: 20.0),),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: new Text(list[i]['nom_usuario'], style: new TextStyle(fontSize: 15.0),),
                  ),
                  Divider(),

                  new Padding(padding: const EdgeInsets.only(top: 5.0),),
                  new Text("Apellido:", style: new TextStyle(fontSize: 20.0),),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: new Text(list[i]['ape_usuario'], style: new TextStyle(fontSize: 15.0),),
                  ),
                  Divider(),

                  new Padding(padding: const EdgeInsets.only(top: 5.0),),
                  new Text("Telefono: ", style: new TextStyle(fontSize: 20.0),),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: new Text(list[i]['telefono'], style: new TextStyle(fontSize: 15.0),),
                  ),
                  Divider(),

                  new Padding(padding: const EdgeInsets.only(top: 5.0),),
                  new Text("Correo electronico:", style: new TextStyle(fontSize: 20.0),),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: new Text(list[i]['email'], style: new TextStyle(fontSize: 15.0),),
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