import 'package:flutter_modular/flutter_modular.dart';
import 'package:dio/dio.dart';

import 'package:clean_arch/modules/search/external/datasources/github_datasource.dart';
import 'package:clean_arch/modules/search/data/repositories/search_repository_impl.dart';
import 'package:clean_arch/modules/search/domain/usecases/search_by_text.dart';
import 'package:clean_arch/modules/search/presenter/search/search_bloc.dart';
import 'package:clean_arch/modules/search/presenter/search/search_page.dart';

class AppModule extends Module {
  @override
  List<Bind> get binds => [
    Bind<Dio>((i) => Dio(i())),
    Bind<GitHubDataSource>((i) => GitHubDataSource(i())),
    Bind<SearchRepositoryImpl>((i) => SearchRepositoryImpl(i())),
    Bind<SearchByTextImpl>((i) => SearchByTextImpl(i())),
    Bind<SearchBloc>((i) => SearchBloc(i())),
  ];

  @override
  List<ModularRoute> get routes => [
    ChildRoute('/', child: (context, args) => const SearchPage()),
  ];
}