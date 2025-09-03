import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewDetail extends StatefulWidget {
  const WebViewDetail({super.key});

  @override
  State<WebViewDetail> createState() => _WebViewDetailState();
}

class _WebViewDetailState extends State<WebViewDetail> {
  late final WebViewController controller;
  final TextEditingController _commentController = TextEditingController();
  final List<String> _comments = []; // local list to store comments

  final String _htmlContent = """
  <!DOCTYPE html>
  <html lang="en">
  <head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Responsive Page</title>
    <style>
      body {
        font-family: Arial, sans-serif;
        margin: 0;
        padding: 20px;
        text-align: center;
      }
      .box {
        background-color: #007BFF;
        color: white;
        padding: 20px;
        border-radius: 8px;
        margin: 10px auto;
        max-width: 600px;
      }
    </style>
  </head>
  <body>
    <h2>Responsive HTML in Flutter</h2>
    <div class="box">
      Resize the screen to see responsiveness!
    </div>
  </body>
  </html>
  """;

  @override
  void initState() {
    super.initState();
    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..loadHtmlString(_htmlContent);
  }

  void _addComment() {
    if (_commentController.text.trim().isEmpty) return;
    setState(() {
      _comments.insert(0, _commentController.text.trim());
      _commentController.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // resizeToAvoidBottomInset: true,
      appBar: AppBar(title: const Text("HTML + Comments")),
      body: Column(
        children: [
          // WebView Section
          SizedBox(
            height: MediaQuery.of(context).size.height / 2,
            child: WebViewWidget(controller: controller),
          ),

          // Comment Input
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _commentController,
                    decoration: InputDecoration(
                      hintText: "Enter your comment...",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                ElevatedButton(
                  onPressed: _addComment,
                  child: const Text("Post"),
                ),
              ],
            ),
          ),

          Expanded(
            child: _comments.isEmpty
                ? const Center(child: Text("No comments yet."))
                : ListView.builder(
                    itemCount: _comments.length,
                    itemBuilder: (context, index) {
                      return Card(
                        margin: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        child: ListTile(
                          leading: const Icon(Icons.comment),
                          title: Text(_comments[index]),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
