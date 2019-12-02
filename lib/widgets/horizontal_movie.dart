import 'package:flutter/material.dart';
import 'package:peliculas/clases/clases.dart';



class MovieHorizontal extends StatelessWidget {


  List<Pelicula> peliculas;

  MovieHorizontal({@required this.peliculas});



  @override
  Widget build(BuildContext context) {
    return Container(
      height: Data.hs*0.3,

      child: PageView(
        reverse: false,
        pageSnapping: false,
        controller: PageController(
          initialPage: 1,
          viewportFraction: 0.3
        ),
        children: _tarjetas()
        ,

      ),
      
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