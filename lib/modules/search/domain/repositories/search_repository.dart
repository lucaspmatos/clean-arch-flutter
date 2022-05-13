import 'package:dartz/dartz.dart';

import '../entities/search_result.dart';
import '../errors/errors.dart';

abstract class SearchRepository {
  Future<Either<SearchFailure, List<SearchResult>?>> search(String? searchText);
}