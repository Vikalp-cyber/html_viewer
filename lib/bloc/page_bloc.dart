import 'package:flutter_bloc/flutter_bloc.dart';
import 'page_event.dart';
import 'page_state.dart';
import '../repository/api_repository.dart';

class PageBloc extends Bloc<PageEvent, PageState> {
  final ApiRepository repository;

  PageBloc(this.repository) : super(PageInitial()) {
    on<LoadPages>((event, emit) async {
      emit(PageLoading());
      try {
        final pages = await repository.fetchPages();
        emit(PagesLoaded(pages));
      } catch (e) {
        emit(PageError(e.toString()));
      }
    });

    on<LoadPageDetail>((event, emit) async {
      emit(PageLoading());
      try {
        final page = await repository.fetchPageDetail(event.pageId);
        emit(PageDetailLoaded(page));
      } catch (e) {
        emit(PageError(e.toString()));
      }
    });
  }
}
