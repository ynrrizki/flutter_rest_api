part of 'article_repo.dart';

abstract class Repository {
  Stream<List<Article>> get articleStream;

  Future<List<Article>> fetchArticle({
    bool onScrollMax = false,
    bool onScrollMin = false,
  });
}
