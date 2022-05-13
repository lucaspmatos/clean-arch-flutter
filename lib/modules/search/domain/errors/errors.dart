abstract class SearchFailure implements Exception {}

class InvalidTextError implements SearchFailure {}

class DataSourceError implements SearchFailure {
  final String? message;

  DataSourceError({this.message});
}
