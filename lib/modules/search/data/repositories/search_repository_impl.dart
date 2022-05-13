import 'package:dartz/dartz.dart';

import 'package:clean_arch/modules/search/domain/repositories/search_repository.dart';
import 'package:clean_arch/modules/search/data/datasources/search_datasource.dart';
import 'package:clean_arch/modules/search/domain/entities/search_result.dart';
import 'package:clean_arch/modules/search/domain/errors/errors.dart';

class SearchRepositoryImpl implements SearchRepository {
  final SearchDataSource datasource;

  SearchRepositoryImpl(this.datasource);

  @override
  Future<Either<SearchFailure, List<SearchResult>?>> search(
      String? searchText) async {
    try {
      final result = await datasource.getSearch(searchText);
      return Right(result);
    } on DataSourceError catch (e) {
      return Left(e);
    } catch (e) {
      return Left(DataSourceError());
    }
  }
}
