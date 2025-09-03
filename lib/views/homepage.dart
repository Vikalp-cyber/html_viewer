import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:html_viewer/views/widgets/page_detail.dart';
import '../bloc/page_bloc.dart';
import '../bloc/page_event.dart';
import '../bloc/page_state.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PageBloc, PageState>(
      builder: (context, state) {
        if (state is PageLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is PagesLoaded) {
          return ListView.builder(
            itemCount: state.pages.length,
            itemBuilder: (context, index) {
              final page = state.pages[index];
              return Card(
                child: ListTile(
                  title: Text(page.title),
                  subtitle: Text(page.description),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) =>
                            PageDetail(pageId: page.id, pageTitle: page.title),
                      ),
                    );
                  },
                ),
              );
            },
          );
        } else if (state is PageError) {
          return Center(child: Text(state.message));
        }
        return const Center(child: Text("No pages available"));
      },
    );
  }
}
