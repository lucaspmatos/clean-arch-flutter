import 'package:clean_arch/modules/search/domain/entities/search_result.dart';
import 'package:clean_arch/modules/search/domain/errors/errors.dart';

abstract class SearchState {}

class SearchSuccess implements SearchState {
  final List<SearchResult>? list;
  SearchSuccess(this.list);
}

class SearchStart implements SearchState {}

class SearchLoading implements SearchState {}

class SearchError implements SearchState {
  final SearchFailure error;
  SearchError(this.error);
}
