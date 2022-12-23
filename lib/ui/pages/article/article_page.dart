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
  final ArticleRepository _articleRepository = ArticleRepository();
  final ScrollController scrollController = ScrollController();

  bool hasReachedMax = false;

  void onScroll() {
    final minScroll = scrollController.position.minScrollExtent;
    final maxScroll = scrollController.position.maxScrollExtent;
    final currentScroll = scrollController.position.pixels;
    if (currentScroll <= 0.9 * minScroll) {
      // load more back
      _articleRepository.fetchArticle(onScrollMin: true).then(
        (value) {
          if (value.isEmpty) {
            setState(() {
              hasReachedMax = true;
            });
          }
        },
      );
      print('Min Scroll');
    }

    if (currentScroll >= 0.9 * maxScroll) {
      // load more
      _articleRepository.fetchArticle(onScrollMax: true).then(
        (value) {
          if (value.isEmpty) {
            setState(() {
              hasReachedMax = true;
            });
          }
        },
      );
      print('Max Scroll');
    }
  }

  @override
  void initState() {
    scrollController.addListener(onScroll);
    super.initState();
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // scrollController.addListener(onScroll);
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
              itemCount: (hasReachedMax)
                  ? snapshot.data!.length
                  : snapshot.data!.length + 1,
              padding: const EdgeInsets.all(10),
              itemBuilder: (context, index) {
                if (index < snapshot.data!.length) {
                  return ArticleCard(
                    article: snapshot.data![index],
                  );
                } else {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 25),
                    child: Center(
                      child: Column(
                        children: const [
                          Divider(
                            thickness: 2,
                            height: 5,
                          ),
                          CircularProgressIndicator(),
                        ],
                      ),
                    ),
                  );
                }
              },
            );
          } else if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return const Center(
              child: Text('Failed load data'),
            );
          }
        },
      ),
    );
  }
}
