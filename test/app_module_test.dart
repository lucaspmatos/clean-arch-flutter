import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:modular_test/modular_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:dio/dio.dart';
import 'dart:convert';

import 'package:clean_arch/modules/search/domain/usecases/search_by_text.dart';
import 'package:clean_arch/modules/search/domain/entities/search_result.dart';
import 'package:clean_arch/app_module.dart';

import 'modules/search/utils/github_response.dart';

class DioMock extends Mock implements Dio {}

main() {
  final dio = DioMock();

  initModule(AppModule(), replaceBinds: [
    Bind<Dio>((i) => dio),
  ]);

  test('Deve recuperar o usecase sem erro', () {
    final usecase = Modular.get<SearchByText>();
    expect(usecase, isA<SearchByTextImpl>());
  });

  test('Deve trazer uma lista de SearchResult', () async {
    when(() => dio.get(any())).thenAnswer(
          (_) async => Response(
        data: jsonDecode(githubResult),
        statusCode: 200,
        requestOptions: RequestOptions(path: ''),
      ),
    );

    final usecase = Modular.get<SearchByText>();
    final result = await usecase('Lucas');

    expect(result | null, isA<List<SearchResult>>());
  });
}
