class CommentModel {
  final int id;
  final String text;

  CommentModel({required this.id, required this.text});

  factory CommentModel.fromJson(Map<String, dynamic> json) {
    return CommentModel(id: json['id'], text: json['text']);
  }
}
