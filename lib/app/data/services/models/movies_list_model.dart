import 'dart:convert';

List<MovieListModel> movieListModelFromJson(String str) =>
    List<MovieListModel>.from(
        json.decode(str).map((x) => MovieListModel.fromJson(x)));

String movieListModelToJson(List<MovieListModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class MovieListModel {
  int id;
  String movie;
  double rating;
  String image;
  String imdbUrl;

  MovieListModel({
    required this.id,
    required this.movie,
    required this.rating,
    required this.image,
    required this.imdbUrl,
  });

  factory MovieListModel.fromJson(Map<String, dynamic> json) => MovieListModel(
        id: json["id"],
        movie: json["movie"],
        rating: json["rating"]?.toDouble(),
        image: json["image"],
        imdbUrl: json["imdb_url"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "movie": movie,
        "rating": rating,
        "image": image,
        "imdb_url": imdbUrl,
      };
}
