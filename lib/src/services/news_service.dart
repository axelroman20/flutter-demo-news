// ignore_for_file: constant_identifier_names

import 'package:flutter/material.dart';
import 'package:flutter_provider/src/models/category_model.dart';
import 'package:flutter_provider/src/models/news_response.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;

const String _URL_NEWS = "https://newsapi.org/v2";
const String _APUKEY = "9942a80983ec4fb0a2ba797d6f82ee2e";

class NewsService with ChangeNotifier {
  List<Article> headlines = [];
  String _selectedCategory = 'business';

  List<Category> categories = [
    Category(FontAwesomeIcons.building, 'business'),
    Category(FontAwesomeIcons.tv, 'entertainment'),
    Category(FontAwesomeIcons.addressCard, 'general'),
    Category(FontAwesomeIcons.headSideVirus, 'health'),
    Category(FontAwesomeIcons.vials, 'science'),
    Category(FontAwesomeIcons.volleyball, 'sports'),
    Category(FontAwesomeIcons.memory, 'technology'),
  ];

  Map<String, List<Article>> categoryArticles = {};

  NewsService() {
    getTopHeadlines();
    for (var item in categories) {
      categoryArticles[item.name] = [];
    }
  }

  String get selectedGategory => _selectedCategory;
  set selectedGategory(String valor) {
    _selectedCategory = valor;
    getArticleByCategory(valor);
    notifyListeners();
  }

  List<Article>? get getArticulosCategoriaSeleccionada =>
      categoryArticles[_selectedCategory];

  getArticleByCategory(String category) async {
    if (categoryArticles[category]!.isNotEmpty) {
      return categoryArticles[category];
    }
    final uri = Uri.parse(
        "$_URL_NEWS/top-headlines?apiKey=$_APUKEY&country=mx&category=$category");
    final resp = await http.get(uri);
    final newsResposne = newsResponseFromJson(resp.body);
    categoryArticles[category]!.addAll(newsResposne.articles!);
    notifyListeners();
  }

  getTopHeadlines() async {
    final uri =
        Uri.parse("$_URL_NEWS/top-headlines?apiKey=$_APUKEY&country=mx");
    final resp = await http.get(uri);
    final newsResposne = newsResponseFromJson(resp.body);
    headlines.addAll(newsResposne.articles!);
    notifyListeners();
  }
}
