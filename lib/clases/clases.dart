import 'dart:async';

import 'package:http/http.dart' as http;
import 'dart:convert';


class Data
{

  static var ws,hs;


  // Variables globales
  static var _API_KEY = "64b873fd66dc4231fbdba99c23b3ce88";
  static var _language = "es-MX";
  static var _url = "api.themoviedb.org";


  // Paginación para los stream
  static var _populares_page = 0;


  // Stream
  static final _popularesStreamController = new StreamController<List<Pelicula>>.broadcast();

  static void disposeStreams()
  {
    _popularesStreamController?.close();
  }
  



  static var peliculas_en_cine = new List<Pelicula>();


  static get_peliculas_en_cine() async
  {
    return await get_peliculas_por_ruta("3/movie/now_playing");
  }

    static get_peliculas_populares() async
  {

    _populares_page++;

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
      final pelicula = new Pelicula(

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



      );
      aux.add( pelicula );
      }

    peliculas_en_cine = aux;

    return aux;
  }

  static get_peliculas_por_ruta(ruta) async
  {
    var aux = new List<Pelicula>();

    final url = Uri.https(_url, ruta,
    {
      "api_key"  : _API_KEY,
      "language" : _language
    });

    var response = await http.get(url);

    var jsonList = jsonDecode(response.body)["results"];


      for ( var item in jsonList  ) 
      {
      final pelicula = new Pelicula(

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



      );
      aux.add( pelicula );
      }

    peliculas_en_cine = aux;

    return peliculas_en_cine;
  }



}






class Pelicula {
  double popularity;
  int id;
  bool video;
  int voteCount;
  double voteAverage;
  String title;
  String releaseDate;
  String originalLanguage;
  String originalTitle;
  List<int> genreIds;
  String backdropPath;
  bool adult;
  String overview;
  String posterPath;

  Pelicula({
    this.popularity,
    this.id,
    this.video,
    this.voteCount,
    this.voteAverage,
    this.title,
    this.releaseDate,
    this.originalLanguage,
    this.originalTitle,
    this.genreIds,
    this.backdropPath,
    this.adult,
    this.overview,
    this.posterPath,
  });


    Pelicula.fromJsonMap( Map<String, dynamic> json ) {

    voteCount        = json['vote_count'];
    id               = json['id'];
    video            = json['video'];
    voteAverage      = json['vote_average'] / 1;
    title            = json['title'];
    popularity       = json['popularity'] / 1;
    posterPath       = json['poster_path'];
    originalLanguage = json['original_language'];
    originalTitle    = json['original_title'];
    genreIds         = json['genre_ids'].cast<int>();
    backdropPath     = json['backdrop_path'];
    adult            = json['adult'];
    overview         = json['overview'];
    releaseDate      = json['release_date'];


  }

    getPosterImg() {

    if ( posterPath == null ) {
      return 'https://cdn11.bigcommerce.com/s-auu4kfi2d9/stencil/59512910-bb6d-0136-46ec-71c445b85d45/e/933395a0-cb1b-0135-a812-525400970412/icons/icon-no-image.svg';
    } else {
      return 'https://image.tmdb.org/t/p/w500/$posterPath';
    }

  }

  getBackgroundImg() {

    if ( posterPath == null ) {
      return 'https://cdn11.bigcommerce.com/s-auu4kfi2d9/stencil/59512910-bb6d-0136-46ec-71c445b85d45/e/933395a0-cb1b-0135-a812-525400970412/icons/icon-no-image.svg';
    } else {
      return 'https://image.tmdb.org/t/p/w500/$backdropPath';
    }

  }
}


class Peliculas {

  List<Pelicula> items = new List();

  Peliculas();

  Peliculas.fromJsonList( List<dynamic> jsonList  ) {

    if ( jsonList == null ) return;

    for ( var item in jsonList  ) {
      final pelicula = new Pelicula.fromJsonMap(item);
      items.add( pelicula );
    }

  }

}






