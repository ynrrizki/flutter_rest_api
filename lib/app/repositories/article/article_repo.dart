import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:flutter_laravel_rest_api/app/models/article/article.dart';
import 'package:http/http.dart' as http;
part 'repository.dart';

class ArticleRepository implements Repository {
  // URL API
  final String _apiUrl = 'https://isoc.co.id/api/articles/posts';

  // Jumlah data yang akan diambil
  final int _limit = 5;

  // Index data yang ditampilkan
  int _startIndex = 0;

  @override
  Stream<List<Article>> get articleStream {
    StreamController<List<Article>> controller = StreamController();
    Timer.periodic(const Duration(milliseconds: 900), (timer) {
      fetchArticle().then((value) {
        if (value.isNotEmpty) controller.sink.add(value);
      });
    });
    return controller.stream;
  }

  @override
  Future<List<Article>> fetchArticle({
    bool onScrollMax = false,
    bool onScrollMin = false,
  }) async {
    final response =
        await http.get(Uri.parse('$_apiUrl?start=$_startIndex&limit=$_limit'));
    if (response.statusCode == 200) {
      List articleData = json.decode(response.body);
      if (onScrollMax) {
        _startIndex += _limit;
      } else if (onScrollMin) {
        if (_startIndex != 0) {
          _startIndex -= _limit;
        }
      }
      return articleData.map((article) => Article.fromJson(article)).toList();
    } else {
      log('gagal request cuk ${response.statusCode}');
      throw Exception('Failed to load article');
    }
  }

  // =============================================
  // == TEST
  // =============================================
  Future<List<Article>> fetchArticle2() async {
    final response = await http.get(Uri.parse(_apiUrl));
    if (response.statusCode == 200) {
      List articleData = json.decode(response.body);
      return articleData.map((article) => Article.fromJson(article)).toList();
    } else {
      log('gagal request cuk ${response.statusCode}');
      throw Exception('Failed to load article');
    }
  }
}
