import 'dart:async';

import 'package:http/http.dart' as http;
import 'dart:convert';
import 'clases.dart';

class PeliculasProvider
{
  // Variables globales
  static var _API_KEY = "64b873fd66dc4231fbdba99c23b3ce88";
  static var _language = "es-MX";
  static var _url = "api.themoviedb.org";



  // Paginación para los stream
  var _populares_page = 0;

  bool _cargando = false;


  // Stream
  final _popularesStreamController = new StreamController<List<Pelicula>>.broadcast();

  Function(List<Pelicula>) get popularesSink => _popularesStreamController.sink.add;

  Stream <List<Pelicula>> get popularesStream => _popularesStreamController.stream;

  void disposeStreams()
  {
    _popularesStreamController?.close();
  }

  var peliculas_en_cine = new List<Pelicula>();
  List<Pelicula> peliculas_populares = new List<Pelicula>();


  getPopulares() async
  {
    if (_cargando)
      return [];

    print("Cargando peliculas...");
    _cargando = true;

    _populares_page++;
    print(_populares_page);

    var aux = new List<Pelicula>();

    final url = Uri.https(_url, "3/movie/popular",
        {
          "api_key"  : _API_KEY,
          "language" : _language,
          "page"     : _populares_page.toString()
        });

    var response = await http.get(url);

    var jsonList = jsonDecode(response.body)["results"];


    for ( var item in jsonList  )
    {
      aux.add(new Pelicula(

          popularity        : item["popularity"] / 1,
          voteCount         : item["vote_count"],
          id                : item["id"],
          video             : item["video"],
          voteAverage       : item["vote_average"] / 1,
          adult             : item["adult"],
          backdropPath      : item["backdrop_path"],
          originalLanguage  : item["original_language"],
          genreIds          : item['genre_ids'].cast<int>(),
          originalTitle     : item["original_title"],
          overview          : item["overview"],
          posterPath        : item["poster_path"],
          releaseDate       : item["release_date"],
          title             : item["title"]



      ));
    }

    peliculas_populares.addAll(aux);

    popularesSink( peliculas_populares );

    _cargando = false;
    return peliculas_populares;
  }


}