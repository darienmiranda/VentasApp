import 'dart:convert';

class Posts {
  final String idproducto;
  final String eusuario;
  final String nombre;
  final String descripcion;
  final String precio;
  final String categoriaid;
  final String fecha;

  Posts({this.idproducto,this.eusuario, this.nombre, this.descripcion, this.precio, this.categoriaid, this.fecha});

  factory Posts.formJson(Map <String, dynamic> json){
    return new Posts(
       idproducto: json['id_producto'],
       eusuario: json['persona_email'],
       nombre: json['nom_producto'],
       descripcion: json['des_producto'],
       precio: json['precio'],
       categoriaid: json['categoria_id'],
       fecha: json['fecha_producto'],
    );
  }

  get id => null;
}