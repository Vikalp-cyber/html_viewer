import 'package:equatable/equatable.dart';

abstract class CommentEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoadComments extends CommentEvent {
  final int pageId;
  LoadComments(this.pageId);
  @override
  List<Object?> get props => [pageId];
}

class AddComment extends CommentEvent {
  final int pageId;
  final String text;
  AddComment(this.pageId, this.text);
  @override
  List<Object?> get props => [pageId, text];
}
