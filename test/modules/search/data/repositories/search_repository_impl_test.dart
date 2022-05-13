import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:dartz/dartz.dart';

import 'package:clean_arch/modules/search/data/repositories/search_repository_impl.dart';
import 'package:clean_arch/modules/search/data/datasources/search_datasource.dart';
import 'package:clean_arch/modules/search/data/models/search_result_model.dart';
import 'package:clean_arch/modules/search/domain/entities/search_result.dart';
import 'package:clean_arch/modules/search/domain/errors/errors.dart';

class SearchDataSourceMock extends Mock implements SearchDataSource {}

main() {
  final datasource = SearchDataSourceMock();
  final repository = SearchRepositoryImpl(datasource);

  test('Deve retornar uma lista de SearchResult', () async {
    when(() => datasource.getSearch(any()))
        .thenAnswer((_) async => <SearchResultModel>[]);

    final result = await repository.search('Lucas');
    expect(result | null, isA<List<SearchResult>>());
  });

  test('Deve retornar um DataSourceError se datasource falhar', () async {
    when(() => datasource.getSearch(any())).thenThrow(Exception());

    final result = await repository.search('Lucas');
    expect(result.fold(id, id), isA<DataSourceError>());
  });
}
