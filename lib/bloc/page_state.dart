import 'package:equatable/equatable.dart';
import 'package:html_viewer/model/page_model.dart';

abstract class PageState extends Equatable {
  @override
  List<Object?> get props => [];
}

class PageInitial extends PageState {}

class PageLoading extends PageState {}

class PagesLoaded extends PageState {
  final List<PageModel> pages;
  PagesLoaded(this.pages);
  @override
  List<Object?> get props => [pages];
}

class PageDetailLoaded extends PageState {
  final PageModel page;
  PageDetailLoaded(this.page);
  @override
  List<Object?> get props => [page];
}

class PageError extends PageState {
  final String message;
  PageError(this.message);
  @override
  List<Object?> get props => [message];
}
