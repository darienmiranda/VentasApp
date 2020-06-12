import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'main.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  TextEditingController registrarnombre = new TextEditingController();
  TextEditingController registrarapellido = new TextEditingController();
  TextEditingController registrartelefono = new TextEditingController();
  TextEditingController registraremail = new TextEditingController();
  TextEditingController registrarpassword = new TextEditingController();
  
  final _formKey = GlobalKey<FormState>();

  Future <List> _register(BuildContext context) async{
    final regitrarse = await http.post("http://192.168.0.108/VentasApp/registrar.php",body: {
      "nom_usuario": registrarnombre.text,
      "ape_usuario": registrarapellido.text,
      "telefono": registrartelefono.text,
      "email": registraremail.text,
      "password": registrarpassword.text
    });

    var usuariosregistrados = json.decode(regitrarse.body);

    if(usuariosregistrados.length != 0)
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
          content: Text('este correo ya esta registrado'),
          actions: <Widget>[
            FlatButton(
              child: Text(
                'Ok',
                style: TextStyle(color: Colors.black, fontWeight: FontWeight.w300)
              ),
              onPressed: (){
                Navigator.pop(context, 'registerpage');
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
          content: Text('Uusario registrado con exito'),
          actions: <Widget>[
            FlatButton(
              child: Text(
                'Ok',
                style: TextStyle(color: Colors.black, fontWeight: FontWeight.w300)
              ),
              onPressed: (){
                username = registraremail.text;
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
    return usuariosregistrados;
  }

  

  Widget RegistrarNombre(){
    return Padding(
      padding: const EdgeInsets.only(top: 0),
        child: TextFormField(
          validator: (value) {
          if (value.isEmpty) {
            return 'Llenar este campo';
          }
        },
          controller: registrarnombre,
          decoration: InputDecoration(
            prefixIcon: Icon(
              Icons.account_circle,
              color: Colors.white,
            ),
            labelStyle: TextStyle(color: Colors.white),
            labelText: "Nombre",
          ),
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w300),
          maxLength: 100,
        ),
    );
  }

  Widget RegistrarApellido(){
    return Padding(
      padding: const EdgeInsets.only(top: 0),
      child: TextFormField(
        validator: (value) {
          if (value.isEmpty) {
            return 'Llenar este campo';
          }
        },
        controller: registrarapellido,
        decoration: InputDecoration(
          prefixIcon: Icon(
            Icons.account_circle,
            color: Colors.white,
          ),
          labelStyle: TextStyle(color: Colors.white),
          labelText: "Apellido",
        ),
        style: TextStyle(color: Colors.white, fontWeight: FontWeight.w300),
        maxLength: 100,
      ),
    );
  }

  Widget RegistrarEmail(){
    return Padding(
      padding: const EdgeInsets.only(top: 0),
      child: TextFormField(
        validator: (value) {
          if (value.isEmpty) {
            return 'Llenar este campo';
          }
        },
        controller: registraremail,
        decoration: InputDecoration(
          prefixIcon: Icon(
            Icons.email,
            color: Colors.white,
          ),
          labelStyle: TextStyle(color: Colors.white),
          labelText: "Correo Electronico",
        ),
        keyboardType:TextInputType.emailAddress,
        style: TextStyle(color: Colors.white, fontWeight: FontWeight.w300),
        maxLength: 255,
      ),
    );
  }

  Widget RegistrarTelefono(){
    return Padding(
      padding: const EdgeInsets.only(top: 0),
      child: TextFormField(
        validator: (value) {
          if (value.isEmpty) {
            return 'Llenar este campo';
          }
        },
        controller: registrartelefono,
        decoration: InputDecoration(
          prefixIcon: Icon(
            Icons.phone,
            color: Colors.white,
          ),
          labelStyle: TextStyle(color: Colors.white),
          labelText: "Telefono",
        ),
        keyboardType: TextInputType.number,
        style: TextStyle(color: Colors.white, fontWeight: FontWeight.w300),
        maxLength: 100,
      ),
    );
  }

  Widget RegistrarPassword(){
    return Padding(
      padding: const EdgeInsets.only(top: 0),
      child: TextFormField(
        validator: (value) {
          if (value.isEmpty) {
            return 'Llenar este campo';
          }
        },
        controller: registrarpassword,
        decoration: InputDecoration(
          prefixIcon: Icon(
            Icons.vpn_key,
            color: Colors.white,
          ),  
          labelStyle: TextStyle(color: Colors.white),
          labelText: "Contraseña",
        ),
        style: TextStyle(color: Colors.white, fontWeight: FontWeight.w300),
        maxLength: 10,
        obscureText: true,
      ),
    );
  }

  Widget ButtonRegistrar(BuildContext context){
    return Container(
      padding: const EdgeInsets.only(top: 15),
      child: RaisedButton(
        textColor: Colors.black,
        child: Text('Registrarse'),
        shape: RoundedRectangleBorder(borderRadius: new BorderRadius.circular(30.0)),
        color: Colors.yellow[300],
        onPressed: (){
          if (_formKey.currentState.validate()) {
            _register(context);
          }
        },
      ));
  }

  Widget ButtonVolver(BuildContext context){
    return Container(
      padding: const EdgeInsets.only(top: 15),
      child: RaisedButton(
        textColor: Colors.black,
        child: Text('Iniciar Sesion'),
        shape: RoundedRectangleBorder(borderRadius: new BorderRadius.circular(30.0)),
        color: Colors.yellow[300],
        onPressed: (){
          Navigator.pushNamed(context, 'main');
        },
      ));
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Scaffold(
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 45),
        decoration: new BoxDecoration(
            image: DecorationImage(
              image: new AssetImage('assets/images/Fondo.jpg'),
              fit: BoxFit.cover
              ),
          ),

        child: ListView(children:[
          Image.asset(
            'assets/images/logo.png',
            width: 200,
            height: 200,),
            RegistrarNombre(),
            RegistrarApellido(),
            RegistrarTelefono(),
            RegistrarEmail(),
            RegistrarPassword(),
            ButtonRegistrar(context),
            ButtonVolver(context)
        ]),
      ),
      )
    );
  }
}