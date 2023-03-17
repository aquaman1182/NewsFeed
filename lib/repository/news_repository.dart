import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:news_feed/data/category_info.dart';
import 'package:news_feed/data/search_type.dart';
import 'package:news_feed/models/model/news_model.dart';

class NewsRepository {
  static const BASE_URL = "https://newsapi.org/v2/top-headlines?country=us";
  static const API_KEY = "afa60f87827e4fb697cf30f788e14b60";

  Future<List<Article>> getNews(
      {required SearchType searchType, String? keyword, Category? category}) async {
    List<Article> results = [];

    http.Response? response;

    switch (searchType) {
      case SearchType.HEAD_LINE:
        final requestUrl = Uri.parse(BASE_URL + "&apikey=$API_KEY");
        response = await http.get(requestUrl);
        break;
      case SearchType.KEYWORD:
        final requestUrl = Uri.parse(BASE_URL + "&q=$keyword&apikey=$API_KEY");
        response = await http.get(requestUrl);
        break;
      case SearchType.CATEGORY:
        final requestUrl =
            Uri.parse(BASE_URL + "&category=${category?.nameEn}&apikey=$API_KEY");
        response = await http.get(requestUrl);
        break;
    }

    if (response != null && response.statusCode == 200) {
      final responseBody = response.body;
      results = News.fromJson(jsonDecode(responseBody)).articles;
    } else {
      throw Exception("Failed to load news");
    }

    return results;
  }
}