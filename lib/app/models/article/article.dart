class Article {
  Article({
    required this.id,
    required this.categoryId,
    required this.title,
    required this.author,
    required this.featuredImage,
    required this.featuredName,
    required this.content,
    required this.createdAt,
    required this.updatedAt,
  });
  late final int id;
  late final String categoryId;
  late final String title;
  late final String author;
  late final String featuredImage;
  late final String featuredName;
  late final String content;
  late final String createdAt;
  late final String updatedAt;

  Article.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    categoryId = json['category_id'];
    title = json['title'];
    author = json['author'];
    featuredImage = json['featured_image'];
    featuredName = json['featured_name'];
    content = json['content'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['category_id'] = categoryId;
    data['title'] = title;
    data['author'] = author;
    data['featured_image'] = featuredImage;
    data['featured_name'] = featuredName;
    data['content'] = content;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
