import 'package:flutter/material.dart';
import 'package:flutter_laravel_rest_api/app/models/article/article.dart';
import 'package:flutter_laravel_rest_api/app/repositories/article/article_repo.dart';
import 'package:flutter_laravel_rest_api/ui/widgets/article_card.dart';

class ArticlePage extends StatefulWidget {
  const ArticlePage({super.key});

  @override
  State<ArticlePage> createState() => _ArticlePageState();
}

class _ArticlePageState extends State<ArticlePage> {
  final ArticleRepository _articleRepository = ArticleRepository();
  final ScrollController scrollController = ScrollController();
  int limit = 7;

  bool isLoading = false;
  bool isLoadMore = false;

  @override
  void initState() {
    scrollController.addListener(() {
      if (scrollController.position.pixels >=
          0.9 * scrollController.position.maxScrollExtent) {
        // load more
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Article'),
      ),
      body: StreamBuilder<List<Article>>(
          stream: _articleRepository.articleStream,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                physics: const BouncingScrollPhysics(),
                controller: scrollController,
                itemCount: snapshot.data!.length,
                padding: const EdgeInsets.all(10),
                itemBuilder: (context, index) {
                  return ArticleCard(
                    article: snapshot.data![index],
                  );
                },
              );
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          }),
    );
  }
}
