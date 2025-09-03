import 'dart:convert';
import 'package:html_viewer/model/comment_model.dart';
import 'package:html_viewer/model/page_model.dart';
import 'package:http/http.dart' as http;

class ApiRepository {
  final String baseUrl = "https://your-backend-url.onrender.com";

  Future<List<PageModel>> fetchPages() async {
    final response = await http.get(Uri.parse("$baseUrl/pages"));
    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data.map((e) => PageModel.fromJson(e)).toList();
    } else {
      throw Exception("Failed to load pages");
    }
  }

  Future<PageModel> fetchPageDetail(int pageId) async {
    final response = await http.get(Uri.parse("$baseUrl/pages/$pageId"));
    if (response.statusCode == 200) {
      return PageModel.fromJson(json.decode(response.body));
    } else {
      throw Exception("Failed to load page detail");
    }
  }

  Future<List<CommentModel>> fetchComments(int pageId) async {
    final response = await http.get(
      Uri.parse("$baseUrl/pages/$pageId/comments"),
    );
    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data.map((e) => CommentModel.fromJson(e)).toList();
    } else {
      throw Exception("Failed to load comments");
    }
  }

  Future<CommentModel> postComment(int pageId, String text) async {
    final response = await http.post(
      Uri.parse("$baseUrl/pages/$pageId/comments"),
      headers: {"Content-Type": "application/json"},
      body: json.encode({"text": text}),
    );
    if (response.statusCode == 201) {
      return CommentModel.fromJson(json.decode(response.body));
    } else {
      throw Exception("Failed to post comment");
    }
  }
}
