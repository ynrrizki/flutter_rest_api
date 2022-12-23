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
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['category_id'] = categoryId;
    _data['title'] = title;
    _data['author'] = author;
    _data['featured_image'] = featuredImage;
    _data['featured_name'] = featuredName;
    _data['content'] = content;
    _data['created_at'] = createdAt;
    _data['updated_at'] = updatedAt;
    return _data;
  }
}
