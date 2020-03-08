import 'package:flutter/material.dart';
import 'package:peliculas/clases/clases.dart';



class MovieHorizontal extends StatelessWidget {


  List<Pelicula> peliculas;
  final Function siguientePagina;

  MovieHorizontal({@required this.peliculas, @required this.siguientePagina});

  PageController _pageController = new PageController(
      initialPage: 1,
      viewportFraction: 0.3
  );


  @override
  Widget build(BuildContext context) {


    _pageController.addListener((){
      if( _pageController.position.pixels >= _pageController.position.maxScrollExtent - 200 )
      {
        // print("Cargar siguientes peliculas");
        siguientePagina();
      }
    });


    return Container(
      height: Data.hs*0.3,

      child: PageView.builder(
        reverse: false,
        pageSnapping: false,
        controller: _pageController,
        itemBuilder: (context, index) => _tarjeta(context, peliculas[index]),
        itemCount: peliculas.length,

      ),
      
    );
  }


  _tarjeta(BuildContext context, Pelicula pelicula)
  {
    var tarjeta = Container(

      margin: EdgeInsets.only(right: 15),
      child: Column(children: <Widget>[


        ClipRRect(
          borderRadius: BorderRadius.circular(20),

          child: FadeInImage(

            image: NetworkImage(
                pelicula.getPosterImg()
            ),

            placeholder: AssetImage(
                "assets/img/no-image.jpg"
            ),

            fit: BoxFit.cover,
            height: 160,
          ),
        ),


      ],),

    );

    return GestureDetector(
      child: tarjeta,
      onTap: ()
      {
         Navigator.pushNamed(context, "/peliculaDetalle", arguments: pelicula);
      },

    );
  }


   List<Widget> _tarjetas()
  {

    List<Widget> widgets = new List<Widget>();

    for (Pelicula pelicula in peliculas)
    {
      widgets.add(Container(

          margin: EdgeInsets.only(right: 15),
          child: Column(children: <Widget>[


            ClipRRect(
              borderRadius: BorderRadius.circular(20),

              child: FadeInImage(

                image: NetworkImage(
                  pelicula.getPosterImg()
                ),

                placeholder: AssetImage(
                  "assets/img/no-image.jpg"
                ),

                fit: BoxFit.cover,
                height: 160,
              ),
            ),
            

          ],),

        ));
    }

      return widgets;


  }

}