import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:VentasApp/registerpage.dart';
import 'package:VentasApp/menus/menuprincipal.dart';
import 'package:http/http.dart' as http;

import 'formularios/otracategoriapage.dart';

 
void main() => runApp(LoginApp());

String username = "";

class LoginApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        dividerColor: Colors.white,
        primarySwatch: Colors.yellow,
        buttonTheme: ButtonThemeData(height: 45),
        textTheme: TextTheme(
          button: TextStyle(
            fontSize: 17,
          ),
        ),
      ),
      home: LoginPage(),
      routes: {
        'main': (context) => LoginPage(),
        'RegisterPage': (context) => RegisterPage(),
        'menuprincipal': (context) => menupricipal(),
      },
    );
  }
}

class LoginPage extends StatefulWidget {
  @override
  LoginPageState createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {

  TextEditingController usuario=new TextEditingController();
  TextEditingController password=new TextEditingController();

  Future<List> _login(BuildContext context) async {
    final response = await http.post("http://192.168.0.108/VentasApp/login.php", body: {
      "email": usuario.text,
      "password": password.text
    });

    var datauser = json.decode(response.body);

    if(datauser.length==0){
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
          content: Text('esta cuenta no esta registrada'),
          actions: <Widget>[
            FlatButton(
              child: Text(
                'Ok',
                style: TextStyle(color: Colors.black, fontWeight: FontWeight.w300)
              ),
              onPressed: (){
                Navigator.of(context).pushNamedAndRemoveUntil(
                  'main', 
                  (Route<dynamic> route) => false
                );
              },
            )
          ],
        ),
      );
    }else{
      setState(() {
        username = datauser[0]['email'];
      });
      Navigator.of(context).pushNamedAndRemoveUntil(
        'menuprincipal', 
        (Route<dynamic> route) => false
      );
    }

    return datauser;
  }

  Widget CreateEmailImput(){
    return Padding(
      padding: const EdgeInsets.only(top: 40),
      child: TextFormField(
        controller: usuario,
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
      ),
    );
  }
  Widget CreatePasswordImput(){
    return Padding(
      padding: const EdgeInsets.only(top: 30),
      child: TextFormField(
        controller: password,
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

  Widget ButtonLogin(BuildContext context){
    return Container(
      padding: const EdgeInsets.only(top: 32),
      child: RaisedButton(
        textColor: Colors.black,
        child: Text('Inicia Sesion'),
        shape: RoundedRectangleBorder(borderRadius: new BorderRadius.circular(30.0)),
        color: Colors.yellow[300],
        onPressed: (){
          _login(context);
        },
      ));
  }

  Widget DivisorLogin(){
    return Container(
      padding: const EdgeInsets.only(top: 15),
      child: Row(children: [
        Expanded(child:  Divider(height: 1)),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Text(
            'o',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.w300),
          ),
        ),
        Expanded(child:  Divider(height: 1))
      ]),
    );
  }

  Widget ButtonRegistrar(BuildContext context){
    return Container(
      padding: const EdgeInsets.only(top: 15),
      child: RaisedButton(
        textColor: Colors.black,
        child: Text('Registrate'),
        shape: RoundedRectangleBorder(borderRadius: new BorderRadius.circular(30.0)),
        color: Colors.yellow[300],
        onPressed: (){
          Navigator.pushNamed(context, 'RegisterPage');
        },
      ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      body: Container(
        child: Container(
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
          CreateEmailImput(),
          CreatePasswordImput(),
          ButtonLogin(context),
          DivisorLogin(),
          ButtonRegistrar(context),       
        ]),
        )
      ),
    );
  }
}