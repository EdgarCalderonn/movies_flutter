import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'package:peliculas/clases/clases.dart';
import 'package:peliculas/clases/peliculas_provider.dart';

import 'package:peliculas/widgets/card_swiper.dart';
import 'package:peliculas/widgets/horizontal_movie.dart';

class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {

  final PeliculasProvider peliculasProvider = new PeliculasProvider();


  @override
  Widget build(BuildContext context) {
    Data.ws = MediaQuery.of(context).size.width;
    Data.hs = MediaQuery.of(context).size.height;

    peliculasProvider.getPopulares();

    return SafeArea(
      child: Scaffold(

        
        // AppBar
        appBar: AppBar(
          title: Text("Peliculas en cine"),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.search),
              onPressed: () {},
            )
          ],
        ),

        // Body
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,

          children: <Widget>[
            FutureBuilder(
              future: Data.get_peliculas_en_cine(),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  if (snapshot.hasData) {



                    return Container(
                      padding: EdgeInsets.only(top: 10),
                      width: double.infinity,
                      height: Data.hs * 0.4,
                      child: new CardSwiper(
                        peliculas: snapshot.data,
                      ),
                    );
                  }
                } 
                
                else
                  return Container(padding: EdgeInsets.only(top: 80),child: Center(child: CircularProgressIndicator()));

                return Container();
              },
            ),

            _Footer(context)
          ],
        ),
      ),
    );
  }



  Widget _Footer(BuildContext context)
  {

    return Container(


      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>
        [

          Container(

            margin: EdgeInsets.only(left: Data.ws*0.03,bottom: Data.ws*0.04),

              child: Text('Populares',
              style: Theme.of(context).textTheme.subhead,
              )
            ),

          StreamBuilder(
            stream: peliculasProvider.popularesStream,
            builder: (BuildContext context, snapshot)
            
            {


              if(snapshot.hasData)
              {
                //print("tamaño: ${snapshot.data.length}");
                return MovieHorizontal(
                  peliculas: snapshot.data,
                  siguientePagina: peliculasProvider.getPopulares,
                );
              }

              else
                return Center(child: CircularProgressIndicator(),);

            }
            ,

          )


        ],
        ),


    );






  }

}
