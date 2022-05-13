import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:dartz/dartz.dart';

import 'package:clean_arch/modules/search/domain/usecases/search_by_text.dart';
import 'package:clean_arch/modules/search/domain/entities/search_result.dart';
import 'package:clean_arch/modules/search/presenter/search/states/state.dart';
import 'package:clean_arch/modules/search/presenter/search/search_bloc.dart';
import 'package:clean_arch/modules/search/domain/errors/errors.dart';

class SearchByTextMock extends Mock implements SearchByText {}

main() {
  final usecase = SearchByTextMock();
  final bloc = SearchBloc(usecase);

  test('Deve retornar os estados na ordem correta', () {
    when(() => usecase.call(any()))
        .thenAnswer((_) async => const Right(<SearchResult>[]));

    expect(
      bloc.stream,
      emitsInOrder([
        isA<SearchLoading>(),
        isA<SearchSuccess>(),
      ]),
    );

    bloc.add('Lucas');
  });

  test('Deve retornar um erro', () {
    when(() => usecase.call(any()))
        .thenAnswer((_) async => Left(InvalidTextError()));

    expect(
      bloc.stream,
      emitsInOrder([
        isA<SearchLoading>(),
        isA<SearchError>(),
      ]),
    );

    bloc.add('Lucas');
  });
}
