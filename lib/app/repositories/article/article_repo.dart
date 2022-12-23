import 'dart:async';
import 'dart:convert';

import 'package:flutter_laravel_rest_api/app/models/article/article.dart';
import 'package:http/http.dart' as http;
part 'repository.dart';

class ArticleRepository implements Repository {
  final String _apiUrl = 'https://isoc.co.id/api/articles/posts';

  final int _limit = 5;

  int _startIndex = 0;

  final List<Article> _articles = [];

  final StreamController<List<Article>> _articleController = StreamController();

  bool isEmpty = false;

  bool isNotEmpty = false;

  @override
  Stream<List<Article>> get articleStream => _articleController.stream;

  @override
  Future<List<Article>> fetchArticle({
    bool onScrollMax = false,
  }) async {
    final response = await http.get(
      Uri.parse('$_apiUrl?start=$_startIndex&limit=$_limit'),
    );
    if (response.statusCode == 200) {
      List articleData = json.decode(response.body);
      if (onScrollMax) {
        _startIndex += _limit;
      }

      return articleData.map((article) => Article.fromJson(article)).toList();
    } else {
      throw Exception('Failed to load article');
    }
  }

  void loadMoreArticles() {
    fetchArticle(onScrollMax: true).then((value) {
      if (value.isNotEmpty) {
        _articles.addAll(value);
        _articleController.sink.add(_articles);
        isNotEmpty = value.isNotEmpty;
      }
      if (value.isEmpty) {
        isEmpty = value.isEmpty;
      }
    });
  }
}
