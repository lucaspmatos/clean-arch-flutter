import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:dartz/dartz.dart';

import 'package:clean_arch/modules/search/domain/repositories/search_repository.dart';
import 'package:clean_arch/modules/search/domain/usecases/search_by_text.dart';
import 'package:clean_arch/modules/search/domain/entities/search_result.dart';
import 'package:clean_arch/modules/search/domain/errors/errors.dart';

class SearchRepositoryMock extends Mock implements SearchRepository {}

main() {
  final repository = SearchRepositoryMock();
  final usecase = SearchByTextImpl(repository);

  test('Deve retornar uma lista de SearchResult', () async {
    when(() => repository.search(any()))
        .thenAnswer((_) async => const Right(<SearchResult>[]));

    final result = await usecase('Lucas');
    expect(result | null, isA<List<SearchResult>>());
  });

  test('Deve retornar Exception caso texto seja inválido', () async {
    when(() => repository.search(any()))
        .thenAnswer((_) async => const Right(<SearchResult>[]));

    var result = await usecase(null);
    expect(result.fold(id, id), isA<InvalidTextError>());

    result = await usecase('');
    expect(result.fold(id, id), isA<InvalidTextError>());
  });
}
