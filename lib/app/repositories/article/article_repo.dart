import 'dart:async';
import 'dart:convert';

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

  Stream<List<Article>> get articleStream {
    StreamController<List<Article>> controller = StreamController();
    Timer.periodic(const Duration(seconds: 10), (timer) async {
      List<Article> articles = await _fetchArticle();
      controller.sink.add(articles);
    });
    return controller.stream;
  }

  Future<List<Article>> _fetchArticle() async {
    final response =
        await http.get(Uri.parse('$_apiUrl?start=$_startIndex&limit=$_limit'));

    if (response.statusCode == 200) {
      List articleData = json.decode(response.body);
      // _startIndex += _limit;
      return articleData.map((article) => Article.fromJson(article)).toList();
    } else {
      throw Exception('Failed to load article');
    }
  }

  static Stream<List<Article>> getData({int limit = 14}) async* {
    List<Article> articles = [];
    try {
      final response = await http.get(
        Uri.parse('https://isoc.co.id/api/articles/posts?start=0&limit=5'),
      );
      if (response.statusCode == 200) {
        String body = response.body;

        List json = jsonDecode(body);

        for (var data in json) {
          articles.add(Article.fromJson(data));
        }
      }
    } catch (e) {
      e.toString();
    }
    yield articles;
  }
}
