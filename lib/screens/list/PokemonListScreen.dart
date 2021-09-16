import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../details/PokemonDetailScreen.dart';
import '../../data/Entities/PokedexEntry.dart';
import '../../data/PokedexRepository.dart';
import '../../localization/AppLocalizations.dart';
import 'pokemon_list_widget.dart';

class PokemonListScreen extends StatelessWidget {
  static const route = '/list';

  @override
  Widget build(BuildContext context) {
    final repository = PokedexRepository(http: http.Client());

    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context).appTitle),
      ),
      body: FutureBuilder<List<PokedexEntry>>(
        future: repository.fetch(1).then((e) => e.entries),
        builder: (context, snapshot) {
          final entries = snapshot.data ?? [];

          return PokemonListWidget(
            entries,
            (index) => _onItemClick(context, entries[index]),
          );
        },
      ),
    );
  }

  void _onItemClick(BuildContext context, PokedexEntry entry) {
    Navigator.pushNamed(
      context,
      PokemonDetailScreen.route,
      arguments: entry,
    );
  }
}