part of 'article_repo.dart';

abstract class Repository<T> {
  Stream<List<Article>> get articleStream;

  Future<List<T>> fetchArticle({bool onScrollMax = false});
}
