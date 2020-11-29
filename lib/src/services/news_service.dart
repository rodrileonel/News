

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:news/src/models/categories_model.dart';
import 'package:news/src/models/news_model.dart';
import 'package:http/http.dart' as http;

class NewsService with ChangeNotifier{
  List<Article> headlines = [];
  String _selectedCateg = 'business';

  List<Category> categories =[
    Category(FontAwesomeIcons.building,'business'),
    Category(FontAwesomeIcons.tv,'entertainment'),
    Category(FontAwesomeIcons.addressBook,'general'),
    Category(FontAwesomeIcons.bookMedical,'health'),
    Category(FontAwesomeIcons.search,'science'),
    Category(FontAwesomeIcons.footballBall,'sports'),
    Category(FontAwesomeIcons.windows,'technology'),
  ];

  //voy a crear un mapa de cetegorias 
  //para que no tenga que cargar cada vez que cambio de categoria
  Map<String,List<Article>> categoryNews ={}; 
  
  NewsService(){
    this.getHeadlines();
    categories.forEach((e) {
      this.categoryNews[e.name] = List();
    });
  }

  String get selectedCateg => this._selectedCateg;
  set selectedCateg(value){
    this._selectedCateg = value;
    getArticlesByCategory(value);
    notifyListeners();
  }

  List<Article> get getArticlesBySelectedCategory => categoryNews[this.selectedCateg];

  getHeadlines() async {
    final url = 'https://newsapi.org/v2/top-headlines?country=us&apiKey=afcc7789d4ef418dbbbbe4deb189e059';
    final response = await http.get(url);
    final data = newsResponseFromJson(response.body);

    this.headlines.addAll(data.articles);
    notifyListeners();
  }

  getArticlesByCategory(String category) async {
    //si tengo la data no debo volver a consultar
    if(this.categoryNews[category].length>0)
      return this.categoryNews[category];

    //sino consumo el servicio
    final url = 'https://newsapi.org/v2/top-headlines?country=us&category=$category&apiKey=afcc7789d4ef418dbbbbe4deb189e059';
    final response = await http.get(url);
    final data = newsResponseFromJson(response.body);
    
    this.categoryNews[category].addAll(data.articles);

    notifyListeners();
  }
}