import 'package:flutter/material.dart';
import 'package:flutter_laravel_rest_api/app/models/article/article.dart';
import 'package:flutter_laravel_rest_api/app/repositories/repositories.dart';
import 'package:flutter_laravel_rest_api/ui/widgets/article_card.dart';

class ArticlePage extends StatefulWidget {
  const ArticlePage({super.key});

  @override
  State<ArticlePage> createState() => _ArticlePageState();
}

class _ArticlePageState extends State<ArticlePage> {
  ArticleRepository? _articleRepository;

  bool _isLoading = false;

  List<Article> _articles = [];

  @override
  void initState() {
    super.initState();
    _articleRepository = ArticleRepository();

    _articleRepository!.articleStream.listen((articles) {
      setState(() {
        _articles = articles;
        _isLoading = false;
      });
    });

    _articleRepository!.loadMoreArticles();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Article')),
      body: NotificationListener(
        onNotification: (notification) {
          if (notification is ScrollEndNotification) {
            if (_articleRepository!.isEmpty) {
              setState(() {
                _isLoading = false;
              });
            } else {
              if (!_isLoading) {
                setState(() {
                  _isLoading = true;
                });
                _articleRepository!.loadMoreArticles();
              }
            }
          }
          return true;
        },
        child: ListView.builder(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 10),
          itemCount: _articles.length + (_isLoading ? 1 : 0),
          itemBuilder: (context, index) {
            if (index == _articles.length) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 25),
                child: Center(
                  child: Column(
                    children: const [
                      Divider(
                        thickness: 2,
                        height: 20,
                      ),
                      SizedBox(height: 5),
                      CircularProgressIndicator(),
                    ],
                  ),
                ),
              );
            }
            return ArticleCard(article: _articles[index]);
          },
        ),
      ),
    );
  }
}
