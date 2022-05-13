import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:dio/dio.dart';
import 'dart:convert';

import 'package:clean_arch/modules/search/external/datasources/github_datasource.dart';
import 'package:clean_arch/modules/search/domain/errors/errors.dart';

import '../../utils/github_response.dart';

class DioMock extends Mock implements Dio {}

main() {
  final dio = DioMock();
  final datasource = GitHubDataSource(dio);

  test('Deve retornar uma lista de SearchResultModel', () async {
    when(() => dio.get(any())).thenAnswer(
      (_) async => Response(
        data: jsonDecode(githubResult),
        statusCode: 200,
        requestOptions: RequestOptions(path: ''),
      ),
    );

    final future = datasource.getSearch('searchText');
    expect(future, completes);
  });

  test('Deve retornar um DataSourceError se o código não for 200', () async {
    when(() => dio.get(any())).thenAnswer(
      (_) async => Response(
        data: null,
        statusCode: 401,
        requestOptions: RequestOptions(path: ''),
      ),
    );

    final future = datasource.getSearch('searchText');
    expect(future, throwsA(isA<DataSourceError>()));
  });
}