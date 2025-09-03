import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:html_viewer/bloc/comment_bloc.dart';
import 'package:html_viewer/bloc/comment_event.dart';
import 'package:html_viewer/bloc/comment_state.dart';
import 'package:html_viewer/bloc/page_bloc.dart';
import 'package:html_viewer/bloc/page_event.dart';
import 'package:html_viewer/bloc/page_state.dart';

class PageDetail extends StatefulWidget {
  final int pageId;
  final String pageTitle;

  const PageDetail({super.key, required this.pageId, required this.pageTitle});

  @override
  State<PageDetail> createState() => _PageDetailState();
}

class _PageDetailState extends State<PageDetail> {
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    context.read<PageBloc>().add(LoadPageDetail(widget.pageId));
    context.read<CommentBloc>().add(LoadComments(widget.pageId));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.pageTitle)),
      body: Column(
        children: [
          Expanded(
            child: BlocBuilder<PageBloc, PageState>(
              builder: (context, state) {
                if (state is PageLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is PageDetailLoaded) {
                  return SingleChildScrollView(
                    padding: const EdgeInsets.all(12),
                    child: HtmlWidget(state.page.content),
                  );
                } else if (state is PageError) {
                  return Center(child: Text(state.message));
                }
                return const SizedBox();
              },
            ),
          ),
          const Divider(),
          Expanded(
            child: Column(
              children: [
                const Text(
                  "Comments",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                Expanded(
                  child: BlocBuilder<CommentBloc, CommentState>(
                    builder: (context, state) {
                      if (state is CommentLoading) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (state is CommentsLoaded) {
                        return ListView.builder(
                          itemCount: state.comments.length,
                          itemBuilder: (context, index) {
                            final comment = state.comments[index];
                            return ListTile(
                              leading: const Icon(Icons.comment),
                              title: Text(comment.text),
                            );
                          },
                        );
                      } else if (state is CommentError) {
                        return Center(child: Text(state.message));
                      }
                      return const SizedBox();
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: _controller,
                          decoration: const InputDecoration(
                            hintText: "Write a comment...",
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.send),
                        onPressed: () {
                          if (_controller.text.isNotEmpty) {
                            context.read<CommentBloc>().add(
                              AddComment(widget.pageId, _controller.text),
                            );
                            _controller.clear();
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
