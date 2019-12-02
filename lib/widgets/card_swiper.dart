import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:peliculas/clases/clases.dart';



class CardSwiper extends StatelessWidget {

  var peliculas;

  CardSwiper({@required this.peliculas});



  @override
  Widget build(BuildContext context) {
    return Swiper(

            layout: SwiperLayout.STACK,
            itemWidth: Data.ws*0.45,
            itemHeight: Data.hs*0.4,
            itemBuilder: (BuildContext context, int index) {
              return new ClipRRect(
                borderRadius:BorderRadius.circular(10),
                child: FadeInImage(
                  image: NetworkImage(
                "${peliculas[index].getPosterImg()}",

              ),
              


                placeholder: AssetImage("assets/img/no-image.jpg"),
                fit: BoxFit.cover,

                )
              );
            },
            itemCount: peliculas.length,
            //pagination: new SwiperPagination(),
            //control: new SwiperControl(),
          );
  }
}