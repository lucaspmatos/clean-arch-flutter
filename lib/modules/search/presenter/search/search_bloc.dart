import 'package:rxdart/rxdart.dart';
import 'package:bloc/bloc.dart';

import 'package:clean_arch/modules/search/domain/usecases/search_by_text.dart';
import 'package:clean_arch/modules/search/presenter/search/states/state.dart';

class SearchBloc extends Bloc<String, SearchState> {
  final SearchByText usecase;

  SearchBloc(this.usecase) : super(SearchStart());

  @override
  Stream<SearchState> mapEventToState(String event) async* {
    yield SearchLoading();
    final result = await usecase(event);
    yield result.fold((l) => SearchError(l), (r) => SearchSuccess(r));
  }

  @override
  Stream<Transition<String, SearchState>> transformEvents(Stream<String> events,
      TransitionFunction<String, SearchState> transitionFn) {
    return super.transformEvents(
      events.debounceTime(
        const Duration(
          milliseconds: 800,
        ),
      ),
      transitionFn,
    );
  }
}
