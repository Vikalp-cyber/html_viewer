import 'package:equatable/equatable.dart';
import 'package:html_viewer/model/comment_model.dart';

abstract class CommentState extends Equatable {
  @override
  List<Object?> get props => [];
}

class CommentInitial extends CommentState {}

class CommentLoading extends CommentState {}

class CommentsLoaded extends CommentState {
  final List<CommentModel> comments;
  CommentsLoaded(this.comments);
  @override
  List<Object?> get props => [comments];
}

class CommentError extends CommentState {
  final String message;
  CommentError(this.message);
  @override
  List<Object?> get props => [message];
}
