class PageModel {
  final int id;
  final String title;
  final String description;
  final String content;

  PageModel({
    required this.id,
    required this.title,
    required this.description,
    required this.content,
  });

  factory PageModel.fromJson(Map<String, dynamic> json) {
    return PageModel(
      id: json['id'],
      title: json['title'],
      description: json['description'] ?? '',
      content: json['content'] ?? '',
    );
  }
}
