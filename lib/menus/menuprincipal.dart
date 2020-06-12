import 'package:VentasApp/formularios/principalpage.dart';
import 'package:VentasApp/menus/favoritospage.dart';
import 'package:VentasApp/menus/miperfil.dart';
import 'package:VentasApp/menus/miscategorias.dart';
import 'package:VentasApp/menus/misventas.dart';
import 'package:flutter/material.dart';
import 'package:hidden_drawer_menu/hidden_drawer/hidden_drawer_menu.dart';


class menupricipal extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<menupricipal> {
  List<ScreenHiddenDrawer> itens = new List();

  @override
  void initState() {
    itens.add(new ScreenHiddenDrawer(
        new ItemHiddenMenu(
          name: "Inicio",
          baseStyle: TextStyle( color: Colors.white.withOpacity(0.8), fontSize: 28.0 ),
          colorLineSelected: Colors.yellowAccent,
        ),
        principalpage()));

    itens.add(new ScreenHiddenDrawer(
        new ItemHiddenMenu(
          name: "Mi Perfil",
          baseStyle: TextStyle( color: Colors.white.withOpacity(0.8), fontSize: 28.0 ),
          colorLineSelected: Colors.yellowAccent,
        ),
        MiPerfil()));

    itens.add(new ScreenHiddenDrawer(
        new ItemHiddenMenu(
          name: "Mis Ventas",
          baseStyle: TextStyle( color: Colors.white.withOpacity(0.8), fontSize: 28.0 ),
          colorLineSelected: Colors.yellowAccent,
        ),
        misventaspage()));

    itens.add(new ScreenHiddenDrawer(
        new ItemHiddenMenu(
          name: "Favoritos",
          baseStyle: TextStyle( color: Colors.white.withOpacity(0.8), fontSize: 28.0 ),
          colorLineSelected: Colors.yellowAccent,
        ),
        misfavoritos()));

    itens.add(new ScreenHiddenDrawer(
        new ItemHiddenMenu(
          name: "Categorias",
          baseStyle: TextStyle( color: Colors.white.withOpacity(0.8), fontSize: 28.0 ),
          colorLineSelected: Colors.yellowAccent,
        ),
        miscategoriaspage()));
        

    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return HiddenDrawerMenu(
      //backgroundColorMenu: Colors.blue[200],
      backgroundColorAppBar: Colors.yellow,
      screens: itens,
        //    typeOpen: TypeOpen.FROM_RIGHT,
        //    enableScaleAnimin: true,
        //    enableCornerAnimin: true,
        slidePercent: 55.0,
        verticalScalePercent: 90.0,
        contentCornerRadius: 20.0,
        //    iconMenuAppBar: Icon(Icons.menu),
        //    backgroundContent: DecorationImage((image: ExactAssetImage('assets/bg_news.jpg'),fit: BoxFit.cover),
        //    whithAutoTittleName: true,
        //    styleAutoTittleName: TextStyle(color: Colors.red),
        //    actionsAppBar: <Widget>[],
        //    backgroundColorContent: Colors.blue,
        //    elevationAppBar: 4.0,
        //    tittleAppBar: Center(child: Icon(Icons.ac_unit),),
        //    enableShadowItensMenu: true,
        backgroundMenu: DecorationImage(
          image: ExactAssetImage('assets/images/Fondo.jpg'),
          fit: BoxFit.cover
        ),
    );
    
  }
}
