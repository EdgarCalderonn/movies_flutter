import 'package:flutter/material.dart';

import 'package:peliculas/clases/clases.dart';

class PeliculaDetalle extends StatelessWidget {

  Pelicula pelicula;

  @override
  Widget build(BuildContext context) {

    pelicula = ModalRoute.of(context).settings.arguments;

    return SafeArea(
      child: Scaffold(


        body: CustomScrollView(

          slivers: <Widget>[
            _crearAppBar(pelicula),
            SliverList(
              delegate: SliverChildListDelegate(
                [
                  _posterTitulo(context, pelicula),
                  Container(
                      padding: EdgeInsets.only(left: 15, right: 15),
                      child: Text("${pelicula.overview}", textAlign: TextAlign.justify,))
                ]
              ),
            )
          ],
        ),

      ),
    );
  }

  Widget _crearAppBar(Pelicula pelicula)
  {
    return SliverAppBar(
      elevation: 2,
      backgroundColor: Colors.indigo,
      expandedHeight: 200,

      floating: false,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
          title: Text("${pelicula.title}",style: TextStyle(color: Colors.white,fontSize: 16),),
          centerTitle: true,
          background: Container(
            child: FadeInImage(
              image: NetworkImage("${pelicula.getBackgroundImg()}"),
              placeholder: AssetImage("assets/img/loading.gif"),
              fadeInDuration: Duration(seconds: 1),
            ),
          ),
      ),
    );
  }

  Widget _posterTitulo(context, Pelicula pelicula)
  {
    return Container(
      child: Row(
        children: <Widget>[
          // Poster de la pelicula
          Container(
            margin: EdgeInsets.only(top: 5, left: 10, bottom: 12),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image(
                image: NetworkImage("${pelicula.getPosterImg()}"),
                height: 150,
              ),
            ),
          ),

          SizedBox(width: 12,),

          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[

                Text("${pelicula.title}", style: Theme.of(context).textTheme.title, overflow: TextOverflow.fade,),

                Text("${pelicula.originalTitle}", style: Theme.of(context).textTheme.subhead, overflow: TextOverflow.ellipsis,),

                Row(
                  children: <Widget>[
                    Icon(Icons.star),
                    SizedBox(width: 5,),
                    Text("${pelicula.voteAverage}")
                  ],
                )

              ],
            ),
          )
        ],
      ),
    );
  }

}
