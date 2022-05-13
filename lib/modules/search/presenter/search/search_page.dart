import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'package:clean_arch/modules/search/presenter/search/search_bloc.dart';
import 'package:clean_arch/modules/search/presenter/search/states/state.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final bloc = Modular.get<SearchBloc>();

  @override
  void dispose() {
    super.dispose();
    bloc.close();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('GitHub Search'),
      ),
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(
              top: 8.0,
              left: 8.0,
              right: 8.0,
            ),
            child: TextField(
              onChanged: bloc.add,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Search',
              ),
            ),
          ),
          Expanded(
            child: StreamBuilder(
                stream: bloc.stream,
                builder: (context, snapshot) {
                  final state = bloc.state;

                  if (state is SearchStart) {
                    return const Center(
                      child: Text('Digite um texto'),
                    );
                  }

                  if (state is SearchLoading) {
                    return const Center(
                      child: CircularProgressIndicator.adaptive(),
                    );
                  }

                  if (state is SearchError) {
                    return const Center(
                      child: Text('Houve um erro!'),
                    );
                  }

                  final list = (state as SearchSuccess).list;
                  return ListView.builder(
                    itemCount: list?.length,
                    itemBuilder: (_, id) {
                      final item = list?[id];
                      return ListTile(
                        leading: item?.img == null
                            ? Container()
                            : CircleAvatar(
                                backgroundImage: NetworkImage('${item?.img}'),
                              ),
                        title: Text(item?.title ?? 'Sem título'),
                      );
                    },
                  );
                }),
          ),
        ],
      ),
    );
  }
}
