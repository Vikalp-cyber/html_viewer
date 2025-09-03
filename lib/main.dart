import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:html_viewer/views/homepage.dart';
import 'repository/api_repository.dart';
import 'bloc/page_bloc.dart';
import 'bloc/page_event.dart';
import 'bloc/comment_bloc.dart';

void main() {
  final repository = ApiRepository();
  runApp(MyApp(repository: repository));
}

class MyApp extends StatelessWidget {
  final ApiRepository repository;
  const MyApp({super.key, required this.repository});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<PageBloc>(
          create: (_) => PageBloc(repository)..add(LoadPages()),
        ),
        BlocProvider<CommentBloc>(create: (_) => CommentBloc(repository)),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          appBar: AppBar(title: Text("Dashboard")),
          body: Dashboard(),
        ),
      ),
    );
  }
}
