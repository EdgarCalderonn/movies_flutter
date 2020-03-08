import 'package:flutter/material.dart';
import 'package:peliculas/views/Dashboard.dart';
import 'package:peliculas/views/pelicula_detalle.dart';




void main()
{
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Peliculas",
      routes:
      {
        "/" : (context) => Dashboard(),
        "/peliculaDetalle" : (context) => PeliculaDetalle()
      },
    )
  );  
}




