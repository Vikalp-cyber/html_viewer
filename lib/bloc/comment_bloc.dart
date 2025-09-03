import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:html_viewer/model/comment_model.dart';
import 'comment_event.dart';
import 'comment_state.dart';
import '../repository/api_repository.dart';

class CommentBloc extends Bloc<CommentEvent, CommentState> {
  final ApiRepository repository;

  CommentBloc(this.repository) : super(CommentInitial()) {
    on<LoadComments>((event, emit) async {
      emit(CommentLoading());
      try {
        final comments = await repository.fetchComments(event.pageId);
        emit(CommentsLoaded(comments));
      } catch (e) {
        emit(CommentError(e.toString()));
      }
    });

    on<AddComment>((event, emit) async {
      if (state is CommentsLoaded) {
        final currentComments = (state as CommentsLoaded).comments;
        try {
          final newComment = await repository.postComment(
            event.pageId,
            event.text,
          );
          final updated = List<CommentModel>.from(currentComments)
            ..add(newComment);
          emit(CommentsLoaded(updated));
        } catch (e) {
          emit(CommentError(e.toString()));
        }
      }
    });
  }
}
