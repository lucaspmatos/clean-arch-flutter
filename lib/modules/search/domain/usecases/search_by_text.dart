import 'package:dartz/dartz.dart';

import 'package:clean_arch/modules/search/domain/repositories/search_repository.dart';
import 'package:clean_arch/modules/search/domain/entities/search_result.dart';
import 'package:clean_arch/modules/search/domain/errors/errors.dart';

abstract class SearchByText {
  Future<Either<SearchFailure, List<SearchResult>?>> call(String? searchText);
}

class SearchByTextImpl implements SearchByText {
  final SearchRepository repository;

  SearchByTextImpl(this.repository);

  @override
  Future<Either<SearchFailure, List<SearchResult>?>> call(
      String? searchText) async {
    if (searchText == null || searchText.isEmpty) {
      return Left(InvalidTextError());
    }

    return repository.search(searchText);
  }
}
