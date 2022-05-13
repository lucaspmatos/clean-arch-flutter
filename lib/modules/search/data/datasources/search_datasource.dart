import 'package:clean_arch/modules/search/data/models/search_result_model.dart';

abstract class SearchDataSource {
  Future<List<SearchResultModel>> getSearch(String? searchText);
}