import 'package:clean_arch/modules/search/domain/errors/errors.dart';
import 'package:dio/dio.dart';

import 'package:clean_arch/modules/search/data/datasources/search_datasource.dart';
import 'package:clean_arch/modules/search/data/models/search_result_model.dart';

extension on String {
  normalize() => replaceAll(' ', '+');
}

class GitHubDataSource implements SearchDataSource {
  final Dio dio;

  GitHubDataSource(this.dio);

  @override
  Future<List<SearchResultModel>> getSearch(String? searchText) async {
    final path =
        'https://api.github.com/search/users?q=${searchText?.normalize()}';
    final response = await dio.get(path);

    if (response.statusCode == 200) {
      final list = (response.data['items'] as List)
          .map((e) => SearchResultModel.fromJson(e))
          .toList();

      return list;
    } else {
      throw DataSourceError();
    }
  }
}
