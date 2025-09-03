import 'package:equatable/equatable.dart';

abstract class PageEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoadPages extends PageEvent {}

class LoadPageDetail extends PageEvent {
  final int pageId;
  LoadPageDetail(this.pageId);
  @override
  List<Object?> get props => [pageId];
}
